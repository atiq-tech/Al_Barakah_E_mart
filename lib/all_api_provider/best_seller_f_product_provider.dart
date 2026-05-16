import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

class BestSellerFeatureProductsProvider extends ChangeNotifier {
  bool isLoading = false;

  List<AllProductModel> bestSellerFeatureProductsList = [];

  Future<void> getBestSellerFeatureProducts() async {
    isLoading = true;
    notifyListeners();

    bestSellerFeatureProductsList =
        await AllApiService.fetchBestSellersFProducts();

    isLoading = false;
    notifyListeners();
  }
}