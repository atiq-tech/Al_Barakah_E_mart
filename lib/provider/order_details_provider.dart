import 'package:al_barakah_e_mart/api_integration/me/order_details_api.dart';
import 'package:al_barakah_e_mart/model/order/order_details_model.dart';
import 'package:flutter/material.dart';

class OrderDetailsProvider extends ChangeNotifier{

  OrderDetailsModel? orderDetailsModel;

  Future<OrderDetailsModel>getOrderDetails(String orderId) async {
    orderDetailsModel = await OrderDetailsApi.fetchOrderDetails(orderId);
    // notifyListeners();
    return orderDetailsModel!;
  }

}