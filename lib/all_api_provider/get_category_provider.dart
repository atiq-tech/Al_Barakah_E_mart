import 'package:al_barakah_e_mart/all_api_model/get_category_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class GetCategoriesProvider extends ChangeNotifier {
  static bool isGetCategoriesLoading= false;

  List<GetCategoriesModel> getCategorieslist= [];
  getGetCategories() async {
    getCategorieslist = await AllApiService.fetchGetCategories();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isGetCategoriesLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isGetCategoriesLoading = true;
    notifyListeners();
  }
}