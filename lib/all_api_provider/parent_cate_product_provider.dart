import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class ParentCateProductProvider extends ChangeNotifier {

  static bool isParentCateProductLoading= false;

  List<AllProductModel> parentCateProductlist= [];
  getParentCateProduct(String? categoryId) async {
    parentCateProductlist = await AllApiService.fetchParentCateProducts(categoryId);
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isParentCateProductLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isParentCateProductLoading = true;
    notifyListeners();
  }
}