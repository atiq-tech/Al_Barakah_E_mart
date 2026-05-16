import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class TopRatedProductsProvider extends ChangeNotifier {
  static bool isTopRatedProductsLoading= false;

  List<AllProductModel> topRatedProductslist= [];
  getTopRatedProducts() async {
    topRatedProductslist = await AllApiService.fetchTopRated();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isTopRatedProductsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isTopRatedProductsLoading = true;
    notifyListeners();
  }
}