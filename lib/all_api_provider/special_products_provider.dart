import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class SpecialProductsProvider extends ChangeNotifier {
  static bool isSpecialProductsLoading= false;

  List<AllProductModel> specialProductslist= [];
  getSpecialProducts() async {
    specialProductslist = await AllApiService.fetchSpecialProducts();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isSpecialProductsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isSpecialProductsLoading = true;
    notifyListeners();
  }
}