// import 'package:george/app/data/app_api_end_point.dart';
// import 'package:george/app/utils/app_log.dart';
// import 'package:george/models/order_history_model.dart';
// import 'package:george/services/api/api_services.dart';

// class OrderRepository {
//   OrderRepository._privateConstructor();

//   static final OrderRepository _instance =
//       OrderRepository._privateConstructor();

//   static OrderRepository get instance => _instance;

//   static final ApiServices _apiServices = ApiServices.instance;
//   static final AppApiEndPoint _apiEndPoint = AppApiEndPoint.instance;

//   Future<OrdersResponse?> getOrder() async {
//     try {
//       var response = await _apiServices.apiGetServices(_apiEndPoint.orders);

//       if (response != null) {
//         return OrdersResponse.fromJson(response);
//       }
//     } catch (e) {
//       errorLog('Order error', e);
//     }
//     return null;
//   }
// }
