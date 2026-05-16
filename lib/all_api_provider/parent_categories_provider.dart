import 'package:al_barakah_e_mart/all_api_model/get_category_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class ParentCategoriesProvider extends ChangeNotifier {

  static bool isParentCategoriesLoading= false;

  List<GetCategoriesModel> parentCategorieslist= [];
  getParentCategories(String? categoryId) async {
    parentCategorieslist = await AllApiService.fetchParentCategories(categoryId);
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isParentCategoriesLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isParentCategoriesLoading = true;
    notifyListeners();
  }
}