import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class ResentProductProvider extends ChangeNotifier {
  static bool isResentProductLoading= false;

  List<AllProductModel> resentProductlist= [];
  getResentProduct() async {
    resentProductlist = await AllApiService.fetchResentProduct();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isResentProductLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isResentProductLoading = true;
    notifyListeners();
  }
}