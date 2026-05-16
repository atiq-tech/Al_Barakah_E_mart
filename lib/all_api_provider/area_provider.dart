import 'package:al_barakah_e_mart/all_api_model/area_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class AreaProvider with ChangeNotifier{
List<AreaModel> areaModelList = [];
getArea()async{
  areaModelList = await AllApiService.fetchGetArea();
  notifyListeners();
 }
}
