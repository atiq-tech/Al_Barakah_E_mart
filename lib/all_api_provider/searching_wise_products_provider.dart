import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class SearchingWiseProductsProvider extends ChangeNotifier {
  static bool isSearchingWiseProductsloading = false;
  List<AllProductModel> searchingWiseProductslist = [];
  getSearchingWiseProducts(String? srcValue)async{
    searchingWiseProductslist = await AllApiService.fetchSearchingWiseProducts(srcValue);
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isSearchingWiseProductsloading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isSearchingWiseProductsloading = true;
    notifyListeners();
  }
}
