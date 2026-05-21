import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/all_api_model/customer_orders_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';

class CustomerOrdersProvider with ChangeNotifier {

  bool isLoading = false;
  List<CustomerOrdersModel> customerOrderslist = [];

  Future<void> getCustomerOrders() async {
    isLoading = true;
    notifyListeners();

    customerOrderslist = await AllApiService.fetchCustomerOrders() ?? [];

    isLoading = false;
    notifyListeners();
  }
}