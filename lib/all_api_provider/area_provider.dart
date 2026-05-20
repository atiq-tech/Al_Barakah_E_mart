import 'package:al_barakah_e_mart/all_api_model/area_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class AreaProvider with ChangeNotifier{
List<AreaModel> areaList = [];
getArea(String? thanaId)async{
  areaList = await AllApiService.fetchGetArea(thanaId);
  notifyListeners();
 }
}
