import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileChangeApi{
static Future<String> changeProfile(String name) async {
  print("name=== $name");

  SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
  String link = "${BaseUrl}customer_profile_update";

  try {
    final response = await Dio().post(
      link,
      data: {
        "name": name.trim(),
      },
      options: Options(
        headers: {
          "Authorization":"Bearer ${sharedPreferences.getString("token")}",
        },
        followRedirects: true,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    var item = response.data;
    print("Profile Update response===== $item");

    if (item["status"] == true) {
      var data = item["data"];

      await sharedPreferences.setString('name', data["Customer_Name"] ?? "");
      await sharedPreferences.setString('email', data["Customer_Email"] ?? "");
      await sharedPreferences.setString('phone', data["Customer_Mobile"] ?? "");
      await sharedPreferences.setString('address', data["Customer_Address"] ?? "");
      await sharedPreferences.setString('image', data["image_name"] ?? "");
      await sharedPreferences.setString('id', data["Customer_SlNo"].toString());
      return item["message"];
    } else {
      return item["message"];
    }
  } catch (e) {
    print("Error message $e");
    return e.toString();
  }
}
}