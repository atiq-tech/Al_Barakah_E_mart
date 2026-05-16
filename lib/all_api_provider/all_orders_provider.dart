import 'package:al_barakah_e_mart/all_api_model/all_orders_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class AllOrdersProvider with ChangeNotifier{

  static bool isAllOrderLoading = false;
  List<AllOrderModel> allOrderModellist = [];
  getGetOrders() async {
    allOrderModellist = await AllApiService.fetchGetOrders();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isAllOrderLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isAllOrderLoading = true;
    notifyListeners();
  }
}