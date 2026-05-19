import 'package:al_barakah_e_mart/all_api_model/factory_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class FactoryProvider with ChangeNotifier{
List<FactoryModel> factoryList = [];
 getFactory()async{
  factoryList = await AllApiService.fetchFactory();
  notifyListeners();
 }
}