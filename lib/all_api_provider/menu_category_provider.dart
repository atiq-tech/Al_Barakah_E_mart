import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

class MenuCategoryProvider extends ChangeNotifier {
  static bool isMenuCategoryloading = false;
  List<AllProductModel> menuCategoryList = [];
  getMenuCategory(String? slug)async{
    menuCategoryList = await AllApiService.fetchMenuCategory(slug);
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isMenuCategoryloading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isMenuCategoryloading = true;
    notifyListeners();
  }
}