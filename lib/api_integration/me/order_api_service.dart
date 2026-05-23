import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';

class OrderApiService {
  static Future<bool> storeOrder({
    required String customerName,
    required String customerMobile,
    required String customerEmail,
    required String districtId,
    required String thanaId,
    required String areaId,
    required String billingAddress,
    required String shippingAddress,
    required String deliveryDate,
    required String timeId,
    required String shippingCost,
    required String totalAmount,
    required List<Map<String, dynamic>> cart,

  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var request = http.MultipartRequest('POST',
        Uri.parse('${BaseUrl}store_order'),
      );
      /// =====================
      /// TOKEN HEADER
      /// =====================
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization":"Bearer ${sharedPreferences.getString("token") ?? ""}",
      });

      /// =====================
      /// FORM DATA
      /// =====================
      request.fields['customer_name'] = customerName;
      request.fields['customer_mobile'] = customerMobile;
      request.fields['customer_email'] = customerEmail;
      request.fields['district_id'] = districtId;
      request.fields['thana_id'] = thanaId;
      request.fields['area_id'] = areaId;
      request.fields['billing_address'] = billingAddress;
      request.fields['shipping_address'] = shippingAddress;
      request.fields['delivery_date'] = deliveryDate;
      request.fields['time_id'] = timeId;
      request.fields['shipping_cost'] = shippingCost;
      request.fields['total_amount'] = totalAmount;

      /// =====================
      /// CART DATA
      /// =====================
      for (int i = 0; i < cart.length; i++) {
        request.fields['cart[$i][id]'] = cart[i]['id'].toString();
        request.fields['cart[$i][price]'] = cart[i]['price'].toString();
        request.fields['cart[$i][quantity]'] = cart[i]['quantity'].toString();
      }

      /// =====================
      /// SEND REQUEST
      /// =====================
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      debugPrint("ORDER RESPONSE: $responseData");

      /// =====================
      /// PARSE RESPONSE
      /// =====================
      final Map<String, dynamic> item = jsonDecode(responseData);

      final bool success = item["success"] ?? false;
      final String? token = item["token"];
      final Map<String, dynamic> customer = item["customer"] ?? {};

      /// =====================
      /// SAVE ONLY IF TOKEN NOT NULL
      /// =====================
      if (token != null && token.isNotEmpty) {
        await sharedPreferences.setString('token',token);
        await sharedPreferences.setString('name',customer["Customer_Name"] ?? "");
        await sharedPreferences.setString('email',customer["Customer_Email"] ?? "",);
        await sharedPreferences.setString('phone',customer["Customer_Phone"] ?? "");
        await sharedPreferences.setString('address',customer["Customer_Address"] ?? "");
        await sharedPreferences.setString('image', customer["image_name"] ?? "");
        await sharedPreferences.setString('id', customer["Customer_SlNo"]?.toString() ?? "");
        await sharedPreferences.setString('districtId',customer["district_id"]?.toString() ?? "");
        await sharedPreferences.setString('thanaId', customer["thana_id"]?.toString() ?? "");
        await sharedPreferences.setString('areaId',customer["area_id"]?.toString() ?? "");
      }

      /// =====================
      /// RETURN RESULT
      /// =====================
      return success;

    } catch (e) {
      debugPrint("ORDER ERROR: $e");
    }

    return false;
  }
}








// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class OrderApiService {

//   static Future<bool> storeOrder({
//     required String customerName,
//     required String customerMobile,
//     required String customerEmail,
//     required String districtId,
//     required String thanaId,
//     required String areaId,
//     required String billingAddress,
//     required String shippingAddress,
//     required String deliveryDate,
//     required String timeId,
//     required String shippingCost,
//     required String totalAmount,
//     required List<Map<String, dynamic>> cart,

//   }) async {
// SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     try {
//       var request = http.MultipartRequest('POST',
//         Uri.parse('${BaseUrl}store_order',
//         ),
//       );
//       /// TOKEN HEADER
//       request.headers.addAll({
//         "Accept": "application/json",
//         "Authorization": "Bearer ${sharedPreferences.getString("token")??"null"}",
//       });

//       /// FORM DATA
//       request.fields['customer_name'] = customerName;
//       request.fields['customer_mobile'] = customerMobile;
//       request.fields['customer_email'] = customerEmail;
//       request.fields['district_id'] = districtId;
//       request.fields['thana_id'] = thanaId;
//       request.fields['area_id'] = areaId;
//       request.fields['billing_address'] = billingAddress;
//       request.fields['shipping_address'] = shippingAddress;
//       request.fields['delivery_date'] = deliveryDate;
//       request.fields['time_id'] = timeId;
//       request.fields['shipping_cost'] = shippingCost;
//       request.fields['total_amount'] = totalAmount;
//       /// CART ARRAY
//       for (int i = 0; i < cart.length; i++) {
//         request.fields['cart[$i][id]'] = cart[i]['id'].toString();
//         request.fields['cart[$i][price]'] = cart[i]['price'].toString();
//         request.fields['cart[$i][quantity]'] = cart[i]['quantity'].toString();
//       }
//       final response = await request.send();
//       final responseData = await response.stream.bytesToString();
//       debugPrint(responseData);
//       if (response.statusCode == 200) {
//       final item =  responseData;
//        var customer = item["customer"];
//       String userName = "${customer["Customer_Name"] ?? ""}";

//       GetStorage().write("name", userName);
//       // login again-------------------null na hole set hobe
//       sharedPreferences = await SharedPreferences.getInstance();
//       sharedPreferences.setString('token', "${item["token"]}");
//       sharedPreferences.setString('name', "${customer["Customer_Name"] ?? ""}");
//       sharedPreferences.setString('email', "${customer["Customer_Email"] ?? ""}");
//       sharedPreferences.setString('phone', "${customer["Customer_Phone"] ?? ""}");
//       sharedPreferences.setString('address', "${customer["Customer_Address"] ?? ""}");
//       sharedPreferences.setString('image', "${customer["image_name"] ?? ""}");
//       sharedPreferences.setString('id', "${customer["Customer_SlNo"]}");
//       sharedPreferences.setString('auth_type', "${customer["auth_type"]}");

//       sharedPreferences.setString('districtName', "${customer["district"]["District_Name"] ?? ""}");
//       sharedPreferences.setString('thanaName', "${customer["thana"]["name"] ?? ""}");
//       sharedPreferences.setString('areaName', "${customer["area"]["name"]}");

//       sharedPreferences.setString('districtId', "${customer["district_id"] ?? ""}");
//       sharedPreferences.setString('thanaId', "${customer["thana_id"] ?? ""}");
//       sharedPreferences.setString('areaId', "${customer["area_id"]}");
//       // login again-------------------



//         debugPrint(item.toString());
//         return true;
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//     return false;
//   }
// }