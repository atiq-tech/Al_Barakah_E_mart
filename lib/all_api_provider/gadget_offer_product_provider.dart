import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

class GadgetOfferProductProvider extends ChangeNotifier {
  bool isLoading = false;

  List<AllProductModel> gadgetOfferProductsList = [];

  Future<void> getGadgetOfferProducts() async {
    isLoading = true;
    notifyListeners();
    
    gadgetOfferProductsList = await AllApiService.fetchGadgetOfferProducts();

    isLoading = false;
    notifyListeners();
  }
}