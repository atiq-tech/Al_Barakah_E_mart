import 'package:al_barakah_e_mart/all_api_model/get_slide_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class SliderProvider extends ChangeNotifier {

  static bool isSliderLoading= false;

  List<SliderModel> sliderlist= [];
  getSlider() async {
    sliderlist = await AllApiService.fetchSlider();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isSliderLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isSliderLoading = true;
    notifyListeners();
  }
}