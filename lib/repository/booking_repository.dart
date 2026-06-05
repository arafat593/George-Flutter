import '../app/data/app_api_end_point.dart';
import '../app/utils/app_log.dart';
import '../services/api/api_services.dart';

class BookingRepository {
  BookingRepository._privateConstructor();
  static final BookingRepository _instance =
      BookingRepository._privateConstructor();
  static BookingRepository get instance => _instance;

  final ApiServices _apiServices = ApiServices.instance;
  final AppApiEndPoint _apiEndPoint = AppApiEndPoint.instance;

  Future<Map<String, dynamic>?> payBooking({
    required String classId,
    required String paymentMethod,
  }) async {
    try {
      final body = {'class_id': classId, 'payment_method': paymentMethod};

      final response = await _apiServices.apiPostServices(
        url: _apiEndPoint.bookingPay,
        body: body,
      );

      return response;
    } catch (e) {
      errorLog('payBooking repo error', e);
    }
    return null;
  }

  Future<Map<String, dynamic>?> payCourse({
    required String courseId,
    required String paymentMethod,
  }) async {
    try {
      final body = {'course_id': courseId, 'payment_method': paymentMethod};

      final response = await _apiServices.apiPostServices(
        url: _apiEndPoint.coursePay,
        body: body,
      );

      return response;
    } catch (e) {
      errorLog('payCourse repo error', e);
    }
    return null;
  }

  Future<Map<String, dynamic>?> checkoutOrder({
    required String productId,
    required int quantity,
    required String paymentMethod,
    String notes = 'string',
  }) async {
    try {
      final body = {
        'items': [
          {'product_id': productId, 'quantity': quantity}
        ],
        'payment_method': paymentMethod,
        'notes': notes,
      };

      final response = await _apiServices.apiPostServices(
        url: _apiEndPoint.orderPay,
        body: body,
      );

      return response;
    } catch (e) {
      errorLog('checkoutOrder repo error', e);
    }
    return null;
  }

  Future<Map<String, dynamic>?> buyMembership({
    required String membershipPlanId,
    required String paymentMethod,
    bool autoRenew = false,
  }) async {
    try {
      final body = {
        'membership_plan_id': membershipPlanId,
        'payment_method': paymentMethod,
        'auto_renew': autoRenew,
      };

      final response = await _apiServices.apiPostServices(
        url: _apiEndPoint.membershipPay,
        body: body,
      );

      return response;
    } catch (e) {
      errorLog('buyMembership repo error', e);
    }
    return null;
  }
}
