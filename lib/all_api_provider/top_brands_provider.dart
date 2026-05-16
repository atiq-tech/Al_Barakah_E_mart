import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/get_brands_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

class TopBrandsProvider extends ChangeNotifier {

  static bool isTopBrandsLoading= false;

  List<GetBrandsModel> topBrandslist= [];
  getTopBrands() async {
    topBrandslist = await AllApiService.fetchTopBrands();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isTopBrandsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isTopBrandsLoading = true;
    notifyListeners();
  }
}