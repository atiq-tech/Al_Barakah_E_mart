import 'dart:convert';
import 'package:al_barakah_e_mart/model/order/my_order_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrderApi{

  static fetchMyOrder(String dateFrom, String dateTo) async {

    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String link = "$baseUrl/api/v1/getCustomerOrderWeb";
    try {
      final formData = FormData.fromMap({
        "token": sharedPreferences.getString('token'),
        "dateFrom": dateFrom.trim(),
        "dateTo": dateTo.trim(),
      });
      final response = await Dio().post(link, data: formData);
      var item = jsonDecode(response.data);
      if (item["success"] == true) {
        return List.from(item["data"]).map((e) => MyOrderModel.fromMap(e)).toList();
      }else{
        return [];
      }
    } catch (e) {
      print("Error message $e");
      return null;
    }
  }
}