import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class PopularProductsProvider extends ChangeNotifier {
  static bool isPopularProductsLoading= false;

  List<AllProductModel> popularProductslist= [];
  getPopularProducts() async {
    popularProductslist = await AllApiService.fetchPopularProducts();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isPopularProductsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isPopularProductsLoading = true;
    notifyListeners();
  }
}