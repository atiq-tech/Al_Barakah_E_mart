import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class AllSearchingProductsProvider with ChangeNotifier{

  List<AllProductModel> allSearchingProductslist = [];
  Future<List<AllProductModel>>getAllSearchingProducts() async {
    allSearchingProductslist = await AllApiService.fetchAllSearchingProducts();
    return allSearchingProductslist;
  }
}