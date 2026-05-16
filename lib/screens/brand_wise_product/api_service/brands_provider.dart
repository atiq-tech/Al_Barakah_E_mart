import 'package:al_barakah_e_mart/screens/brand_wise_product/api_service/brand_api.dart';
import 'package:al_barakah_e_mart/screens/brand_wise_product/model/brand_model.dart';
import 'package:flutter/foundation.dart';

class BrandsProvider with ChangeNotifier{
  List<BrandsModel> brandsModellist=[];
  static bool isBrandsloading = false;
  getBrands(context)async{
    brandsModellist=await ApiService.fetchBrands(context);
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isBrandsloading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isBrandsloading = true;
    notifyListeners();
  }
}