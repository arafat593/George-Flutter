import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:george/app/data/app_api_end_point.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/services/api/non_auth_api.dart';
import 'package:george/services/storage_services/get_storage_services.dart';
import 'package:get/get.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppApi {
  final Dio _dio = Dio();
  AppApi._privateConstructor();
  static final AppApi _instance = AppApi._privateConstructor();
  static AppApi get instance => _instance;
  var storageServices = GetStorageServices.instance;
  AppApi() {
    _dio.options.baseUrl = AppApiEndPoint.instance.baseUrl;
    _dio.options.sendTimeout = const Duration(seconds: 120);
    _dio.options.connectTimeout = const Duration(seconds: 120);
    _dio.options.receiveTimeout = const Duration(seconds: 120);
    _dio.options.followRedirects = false;

    _dio.interceptors.addAll({
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.baseUrl = AppApiEndPoint.instance.baseUrl;
          options.headers["Accept"] = "application/json";

          String token = storageServices.getToken();
          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          if (options.contentType == null) {
            options.contentType = Headers.jsonContentType;
          } else {
            options.contentType ??= 'application/json';
          }
          return handler.next(options); // Continue request
        },
        onError: (error, handler) async {
          appLog("""

API error occurred:

Status code: ${error.response?.statusCode}

Error message: ${error.message}

""");

          try {
            if (error.response?.statusCode == 401) {
              var response = await _reFreshNewAccessToken();
              if (response.isNotEmpty) {
                _dio.options.headers["Authorization"] = "Bearer $response";
                return handler.resolve(await _dio.fetch(error.requestOptions));
              } else {
                await storageServices.logout();
                Get.offAllNamed(Routes.logIn);
                return handler.next(error);
              }
            }
          } catch (e) {
            errorLog("error form api try and catch bloc", e);
            return handler.next(error);
          }

          return handler.next(error); // Continue with error
        },
      ),
      if (kDebugMode)
        PrettyDioLogger(requestHeader: true, request: true, compact: true, error: true, requestBody: true, responseHeader: true, responseBody: true),
    });
  }
  Dio get sendRequest => _dio;
}

// Token refresh logic
Future<String> _reFreshNewAccessToken() async {
  try {
    var refreshToken = GetStorageServices.instance.getRefreshToken();
    final response = await NonAuthApi().sendRequest.post(AppApiEndPoint.instance.refreshToken, data: {"token": refreshToken});
    if (response.statusCode == 200) {
      if (response.data["access_token"] is String) {
        await GetStorageServices.instance.setToken(response.data["access_token"]);
        await GetStorageServices.instance.setRefreshToken(response.data["refresh_token"]);
        return response.data["access_token"].toString();
      }
    } else {
      await GetStorageServices.instance.logout();
    }
  } catch (e) {
    errorLog("reFreshNewAccessToken", e);
  }
  return "";
}
