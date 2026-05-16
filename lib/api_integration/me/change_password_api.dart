import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PasswordChangeApi {
  static Future<String> fetchPasswordChange(String oldPass, String newPass, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String link = "${BaseUrl}customer_password_update";

    try {
      final formData = FormData.fromMap({
        "old_password": oldPass.trim(),
        "password": newPass.trim(),
      });

      final response = await Dio().post(
        link,
        data: formData,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":"Bearer ${sharedPreferences.getString("token")}",
        }),
      );

      var item = response.data;
      if (item["status"] == true) {
        return item["message"]; 
      } else {
        return item["message"];
      }
    } catch (e) {
      print("Error change password message $e");
      return "Something went wrong";
    }
  }
}