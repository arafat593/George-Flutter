import 'package:george/models/product_details_model.dart';
import 'package:george/repository/productdetails_repository.dart';
import 'package:get/get.dart';
import '../../../utils/app_log.dart';

class ProductDetailsController extends GetxController {
  late String productId;

  RxBool isLoading = false.obs;

  final ProductDetailsRepository _productDetailsRepository =
      ProductDetailsRepository.instance;

  Rx<ProductDetailsModel?> productDetails = Rx<ProductDetailsModel?>(null);
  RxInt quantity = 1.obs;

  void increment() {
    quantity.value++;
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments as String;
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      isLoading.value = true;

      final result = await _productDetailsRepository.fetchProductDetails(
        id: productId,
      );

      productDetails.value = result;
    } catch (e) {
      errorLog("ProductDetailsController", e);
    } finally {
      isLoading.value = false;
    }
  }
}
