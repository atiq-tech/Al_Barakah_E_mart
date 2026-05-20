import 'package:al_barakah_e_mart/all_api_model/delivery_times_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class DeliveryTimesProvider with ChangeNotifier{
List<DeliveryTimesModel> deliveryTimesList = [];
getDeliveryTimes()async{
  deliveryTimesList = await AllApiService.fetchDeliveryTimes();
  notifyListeners();
 }
}