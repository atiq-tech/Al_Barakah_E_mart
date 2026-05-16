import 'package:al_barakah_e_mart/all_api_model/get_slide_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class GetSlidersProvider extends ChangeNotifier {

  static bool isGetSlidersLoading= false;

  List<GetSlidersModel> getSliderslist= [];
  getGetSliders() async {
    getSliderslist = await AllApiService.fetchGetSliders();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isGetSlidersLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isGetSlidersLoading = true;
    notifyListeners();
  }
}