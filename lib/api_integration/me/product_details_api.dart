import 'dart:convert';
import 'package:al_barakah_e_mart/model/product/product_details_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';

class ProductDetailsApi{
  static fetchProductDetails(String slug) async {
    String link = "$baseUrl/api/v1/getProductDetailsWeb";
    try {
      final formData = FormData.fromMap({
        "slug": slug.trim(),
      });
      final response = await Dio().post(link, data: formData);
      var item = jsonDecode(response.data);
      if (item["success"] == true) {
        return ProductDetailsModel.fromMap(item);
      }else{
        return null;
      }
    } catch (e) {
      print("Error message $e");
      return null;
    }
  }
}