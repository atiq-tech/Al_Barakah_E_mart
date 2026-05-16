import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

// class BrandWiseProductsProvider extends ChangeNotifier {

//   static bool isBrandWiseProductsLoading= false;

//   List<AllProductModel> brandWiseProductlist= [];
//   getBrandWiseProducts(String? brandId) async {
//     brandWiseProductlist = await AllApiService.fetchBrandWiseProducts(brandId);
//     off();
//     notifyListeners();
//   }
//   off(){
//     Future.delayed(const Duration(seconds: 1),() {
//       print('offff');
//       isBrandWiseProductsLoading = false;
//       notifyListeners();
//     },);
//   }
//   on(){
//     print('onnn');
//     isBrandWiseProductsLoading = true;
//     notifyListeners();
//   }
// }


class BrandWiseProductsProvider extends ChangeNotifier {
  bool isLoading = false;

  List<AllProductModel> brandWiseProductlist = [];

  Future<void> getBrandWiseProducts(String? brandId) async {
    isLoading = true;
    notifyListeners();
    
    brandWiseProductlist = await AllApiService.fetchBrandWiseProducts(brandId);

    isLoading = false;
    notifyListeners();
  }
}