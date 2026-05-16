import 'dart:convert';

import 'package:al_barakah_e_mart/model/profile_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApi{

  static fetchUserProfile() async {

    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String link = "$baseUrl/api/v1/get_total_dashboard";
    try {
      final formData = {
        "token": sharedPreferences.getString('token'),
      };
      final response = await Dio().post(link, data: formData);
      var item = jsonDecode(response.data);
      return UserProfileResponseModel.fromMap(item);
    } catch (e) {
      print("Error message $e");
      return null;
    }
  }
}