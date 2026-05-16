import 'dart:convert';

import 'package:al_barakah_e_mart/model/order/order_details_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsApi{

  static fetchOrderDetails(String orderId,) async {

    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String link = "$baseUrl/api/v1/getCustomerOrderDetailsWeb";
    try {
      final formData = FormData.fromMap({
        "token": sharedPreferences.getString('token'),
        "id": orderId.trim(),
      });
      final response = await Dio().post(link, data: formData);
      var item = jsonDecode(response.data);
      if (item["success"] == true) {
        return OrderDetailsModel.fromMap(item);
      }else{
        return null;
      }
    } catch (e) {
      print("Error message $e");
      return null;
    }
  }
}