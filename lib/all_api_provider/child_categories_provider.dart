import 'package:al_barakah_e_mart/all_api_model/child_categories_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class ChildCategoriesProvider extends ChangeNotifier {

  static bool isChildCategoriesLoading = false;

  ChildCategoriesModel? childCategoriesModel;
  getChildCategories(String? categoryId) async {
    childCategoriesModel = await AllApiService.fetchChildCategories(categoryId);
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isChildCategoriesLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isChildCategoriesLoading = true;
    notifyListeners();
  }
}