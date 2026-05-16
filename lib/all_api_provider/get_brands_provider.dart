import 'package:al_barakah_e_mart/all_api_model/get_brands_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class GetBrandsProvider extends ChangeNotifier {

  static bool isGetBrandsLoading= false;

  List<GetBrandsModel> getBrandslist= [];
  getGetBrands() async {
    getBrandslist = await AllApiService.fetchGetBrands();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isGetBrandsLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isGetBrandsLoading = true;
    notifyListeners();
  }
}