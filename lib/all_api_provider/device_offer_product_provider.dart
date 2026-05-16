import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

class DeviceOfferProductProvider extends ChangeNotifier {
  bool isLoading = false;

  List<AllProductModel> deviceOfferProductsList = [];

  Future<void> getDeviceOfferProducts() async {
    isLoading = true;
    notifyListeners();
    
    deviceOfferProductsList = await AllApiService.fetchDeviceOfferProducts();

    isLoading = false;
    notifyListeners();
  }
}