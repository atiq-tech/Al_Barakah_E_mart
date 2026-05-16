import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class FeatureProductsProvider extends ChangeNotifier {
  static bool isFeatureProductsLoading= false;

  List<AllProductModel> featureProductslist= [];
  getFeatureProducts() async {
    featureProductslist = await AllApiService.fetchFeatureProducts();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isFeatureProductsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isFeatureProductsLoading = true;
    notifyListeners();
  }
}