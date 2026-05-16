import 'dart:convert';
import 'package:al_barakah_e_mart/model/wishList_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListApi{

  static getWishListData() async {
    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String link = "$baseUrl/api/v1/getCustomerwishlistWeb";
    try {
      final formData = FormData.fromMap({
        "token": sharedPreferences.getString('token'),
      });
      final response = await Dio().post(link, data: formData);
      var item = jsonDecode(response.data);

      if (item["success"] == true) {
        return List.from(item["data"]).map((e) => WishListModel.fromMap(e)).toList();
      }else{
        return [];
      }
    } catch (e) {
      print("Error message $e");
      return null;
    }
  }

  static Future<String>addWishListData(String productId) async {
    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String link = "$baseUrl/api/v1/add_wishlist";
    try {
      final formData = FormData.fromMap({
        "token": sharedPreferences.getString('token'),
        "product_id" : productId.toString().trim()
      });
      final response = await Dio().post(link, data: formData);
      var item = jsonDecode(response.data);
      if (item["success"] == true) {
        return item["data"];
      }else{
        return "Something wrong";
      }
    } catch (e) {
      print("Error message $e");
      return e.toString();
    }
  }

  static Future<String>removeWishListData(String productId) async {

    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String link = "$baseUrl/api/v1/remove_wishlist";
    try {
      final formData = FormData.fromMap({
        "token": sharedPreferences.getString('token'),
        "id" : productId.toString().trim()
      });
      final response = await Dio().post(link, data: formData);
      var item = jsonDecode(response.data);
      if (item["success"] == true) {
        return item["data"];
      }else{
        return "Something wrong";
      }
    } catch (e) {
      print("Error message $e");
      return e.toString();
    }
  }

}