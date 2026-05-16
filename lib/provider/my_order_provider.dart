import 'package:al_barakah_e_mart/api_integration/me/my_order_api.dart';
import 'package:al_barakah_e_mart/model/order/my_order_model.dart';
import 'package:flutter/cupertino.dart';

class MyOrderProvider extends ChangeNotifier{

  static bool isLoading = false;

  List<MyOrderModel> myOrderModel = [];
  /*Future<List<MyOrderModel>>*/getMyOrder(dateFrom, dateTo) async {
    myOrderModel = await MyOrderApi.fetchMyOrder(dateFrom, dateTo);
    off();
    notifyListeners();
    // return myOrderModel;
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isLoading = true;
    notifyListeners();
  }

}