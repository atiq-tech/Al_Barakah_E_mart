import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class RelatedProductsProvider extends ChangeNotifier {

  static bool isRelatedProductsLoading = false;

  List<AllProductModel> relatedProductslist= [];
  getRelatedProducts(String? categoryId) async {
    relatedProductslist = await AllApiService.fetchRelatedProducts(categoryId);
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isRelatedProductsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isRelatedProductsLoading = true;
    notifyListeners();
  }
}