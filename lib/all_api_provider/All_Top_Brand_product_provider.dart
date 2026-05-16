import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

class AllTopBrandProductProvider extends ChangeNotifier {
  bool isLoading = false;

  List<AllProductModel> allTopBrandProductsList = [];

  Future<void> getAllTopBrandProducts() async {
    isLoading = true;
    notifyListeners();

    allTopBrandProductsList = await AllApiService.fetchAllTopBrandProducts();

    isLoading = false;
    notifyListeners();
  }
}