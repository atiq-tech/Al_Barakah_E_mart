import 'package:al_barakah_e_mart/API_Model_Class/all_product_model_class.dart';
import 'package:al_barakah_e_mart/screens/brand_wise_product/api_service/brand_api.dart';
import 'package:flutter/foundation.dart';

class GetBrandWiseProvider with ChangeNotifier{
  List<ProductDataModel> dataList = [];
  static bool isBrandsProductAllloading = false;
  getBrands(context,String? brandId )async{
    dataList=await ApiService.getBrandsWise(context,brandId);
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isBrandsProductAllloading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isBrandsProductAllloading = true;
    notifyListeners();
  }
}