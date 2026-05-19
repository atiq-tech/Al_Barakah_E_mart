import 'package:al_barakah_e_mart/all_api_model/thana_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class ThanaProvider with ChangeNotifier{
List<ThanaModel> thanaList = [];
 getThana()async{
  thanaList = await AllApiService.fetchThana();
  notifyListeners();
 }
}