import 'package:al_barakah_e_mart/api_integration/me/product_details_api.dart';
import 'package:al_barakah_e_mart/model/product/product_details_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsProvider extends ChangeNotifier {

  static bool isLoading = false;

  ProductDetailsModel? productDetailsModel;
  getProductDetails(String slug) async {
    productDetailsModel = await ProductDetailsApi.fetchProductDetails(slug);
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isLoading = true;
    notifyListeners();
  }
}
