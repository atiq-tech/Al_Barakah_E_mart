import 'package:al_barakah_e_mart/all_api_model/district_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class DistrictProvider with ChangeNotifier{
List<DistrictModel> districtList = [];
 getThana()async{
  districtList = await AllApiService.fetchDistrict();
  notifyListeners();
 }
}