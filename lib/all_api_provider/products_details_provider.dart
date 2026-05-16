import 'package:al_barakah_e_mart/all_api_model/products_details_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class ProductsDetailsProvider extends ChangeNotifier {

  bool isProductsDetailsLoading = false;
  ProductDetailsModel? productsDetails;

  Future<void> getProductsDetails(String slug) async {
    _on();

    productsDetails = await AllApiService.fetchProductsDetails(slug);

    _off();
  }

  void _on() {
    isProductsDetailsLoading = true;
    notifyListeners();
  }

  void _off() {
    isProductsDetailsLoading = false;
    notifyListeners();
  }
}