import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/customer_orders_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

// class CustomerOrdersProvider with ChangeNotifier{
//   static bool isCustomerOrdersLoading = false;
//   List<CustomerOrdersModel> customerOrderslist = [];
//   getCustomerOrders(String? orderStatus) async {
//     customerOrderslist = await AllApiService.fetchCustomerOrders(orderStatus);
//     off();
//     notifyListeners();
//   }
//   off(){
//     Future.delayed(const Duration(seconds: 1),() {
//       print('offff');
//       isCustomerOrdersLoading = false;
//       notifyListeners();
//     },);
//   }
//   on(){
//     print('onnn');
//     isCustomerOrdersLoading = true;
//     notifyListeners();
//   }
// }


class CustomerOrdersProvider with ChangeNotifier {

  bool isLoading = false;
  List<CustomerOrdersModel> customerOrderslist = [];

  Future<void> getCustomerOrders(String? orderStatus) async {
    isLoading = true;
    notifyListeners();

    customerOrderslist = await AllApiService.fetchCustomerOrders(orderStatus) ?? [];

    isLoading = false;
    notifyListeners();
  }
}