import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

class BestDealerFeatureProductsProvider extends ChangeNotifier {
  bool isLoading = false;

  List<AllProductModel> bestDealerFeatureProductsList = [];

  Future<void> getBestDealerFeatureProducts() async {
    isLoading = true;
    notifyListeners();

    bestDealerFeatureProductsList =
        await AllApiService.fetchBestDealerFProducts();

    isLoading = false;
    notifyListeners();
  }
}