import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class NewArrivalProductsProvider extends ChangeNotifier {
  static bool isNewArrivalProductsLoading= false;

  List<AllProductModel> newArrivalProductslist= [];
  getNewArrivalProducts() async {
    newArrivalProductslist = await AllApiService.fetchNewArrivalProducts();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isNewArrivalProductsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isNewArrivalProductsLoading = true;
    notifyListeners();
  }
}