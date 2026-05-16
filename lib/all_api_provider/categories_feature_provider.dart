import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/get_category_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

class CategoriesFeatureProvider extends ChangeNotifier {
  static bool isCategoriesFeatureLoading= false;

  List<GetCategoriesModel> categoriesFeatureList= [];
  getCategoriesFeature() async {
    categoriesFeatureList = await AllApiService.fetchCategoriesFeature();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isCategoriesFeatureLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isCategoriesFeatureLoading = true;
    notifyListeners();
  }
}