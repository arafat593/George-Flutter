import 'package:flutter/material.dart';
import 'package:george/models/product_details_model.dart';
import 'package:george/repository/productdetails_repository.dart';
import 'package:get/get.dart';
import '../../../utils/app_log.dart';

class ProductDetailsController extends GetxController {
  late String productId;

  RxBool isLoading = false.obs;

  final ProductDetailsRepository _productDetailsRepository =
      ProductDetailsRepository.instance;

  Rxn<ProductDetailsModel> productDetails = Rxn<ProductDetailsModel>();


  void increment() {
    try {
      var product = productDetails.value;
      if (product == null) return;
      var quantity = product.quantity;
      var stockQuantity = product.stockQuantity;
      if ((quantity + 1) < stockQuantity) {
        quantity = quantity +1;
        var totalPrice = product.price * quantity;
        productDetails.value = product.copyWith(
          quantity: quantity,
          totalPrice: totalPrice,
        );
      } else {
        Get.snackbar(
          "Insufficient Quantity",
          "Need To less",
          backgroundColor: Colors.orange,
        );
      }
    } catch (e) {
      errorLog("Error is", e);
    }
  }

  void decrement() {
    try{
      var product = productDetails.value;
      if(product == null)return;
       var currentQuantity =product.quantity;
       if(currentQuantity > 1){
        var newQuantity =  currentQuantity -1;
        var totalPrice= product.price * newQuantity;
        productDetails.value = product.copyWith(
          quantity: newQuantity,
          totalPrice:  totalPrice,
        );
       }else{
         Get.snackbar(
           "Minimum Quantity",
           "Quantity cannot be less than 1",
           backgroundColor: Colors.orange,
         );
       }
    }catch(e){
      errorLog("Error is", e);
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
