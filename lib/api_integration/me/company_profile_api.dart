import 'dart:convert';
import 'package:al_barakah_e_mart/model/company_profile_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';

class CompanyProfileApi{

  static fetchCompanyProfile() async {

    String link = "$baseUrl/api/v1/get_company";
    try {
      final response = await Dio().post(link);
      var item = jsonDecode(response.data);
      if (item["success"] == true) {
        return CompanyProfileModel.fromMap(item['data']);
      }else{
        return null;
      }
    } catch (e) {
      print("Error message $e");
      return null;
    }
  }
}