import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class AllProductsProvider with ChangeNotifier {
  bool isProductsLoading = false; 
  List<AllProductModel> allProductslist = [];

  Future<void> getAllProducts() async {
    on();
    allProductslist = await AllApiService.fetchAllSearchingProducts();
    off(); 
  }

  void on() {
    isProductsLoading = true;
    notifyListeners();
  }

  void off() {
    isProductsLoading = false;
    notifyListeners();
  }
}