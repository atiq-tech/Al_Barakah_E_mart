// import 'package:bestbazar/API_Model_Class/all_product_model_class.dart';
// import 'package:bestbazar/api_integration/search_wise_product_api_integration.dart';
// import 'package:flutter/material.dart';
//
// class SearchWiseProductProvider with ChangeNotifier{
//   ///====Get search wise product====///
//   static bool isLoadingSearchWiseProduct = false;
//   List<ProductDataModel> searchWiseProductlist=[];
//   getSearchWiseProduct(context,String search_value)async{
//     searchWiseProductlist=await SearchWise_ProductApi_Integration.SearchWiseProduct(context,search_value);
//     off();
//     notifyListeners();
// }
// off(){
//   Future.delayed(const Duration(seconds: 1),() {
//     print('offff');
//     isLoadingSearchWiseProduct = false;
//     notifyListeners();
//   },);
// }
// on(){
//   print('onnn');
//   isLoadingSearchWiseProduct = true;
//   notifyListeners();
// }
// }