import 'package:al_barakah_e_mart/screens/auth/pages/signin_page.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PasswordChangeApi {

  static Future<Map<String, dynamic>> fetchPasswordChange(
    String currentPass,
    String confirmPass,
    String password,
    BuildContext context,
  ) async {

    SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String link = "${BaseUrl}password_update";

    try {

      final formData = FormData.fromMap({

        "currentPass": currentPass.trim(),

        "confirmed": confirmPass.trim(),

        "password": password.trim(),
      });

      final response = await Dio().post(

        link,

        data: formData,

        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPreferences.getString("token")}",
          },
        ),
      );

      var item = response.data;

      print("Password change === $item");

      return {
        "success": item["success"] ?? false,
        "message": item["message"] ?? "",
      };

    } catch (e) {

      print("Error change password message $e");

      return {
        "success": false,
        "message": "Something went wrong",
      };
    }
  }
}