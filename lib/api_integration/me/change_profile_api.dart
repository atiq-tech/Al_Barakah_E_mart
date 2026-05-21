import 'dart:io';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileChangeApi {
  static Future<String> changeProfile({
    required String name,
    required String mobile,
    required String email,
    required String address,
    File? imageFile,
  }) async {
    print("Updating Profile: $name, $mobile, $email, $address");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String link = "${BaseUrl}customer_profile_update";

    try {
      // ১. FormData তৈরি
      Map<String, dynamic> formDataMap = {
        "Customer_Name": name.trim(),
        "Customer_Mobile": mobile.trim(),
        "Customer_Email": email.trim(),
        "Customer_Address": address.trim(),
      };

      // ২. ইমেজ চেক ও যুক্ত করা
      if (imageFile != null) {
        formDataMap["image_name"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(formDataMap);

      // ৩. রিকোয়েস্ট পাঠানো
      final response = await Dio().post(
        link,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer ${sharedPreferences.getString("token")}",
            "Accept": "application/json",
          },
          followRedirects: true,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      var item = response.data;
      print("Profile Update response===== $item");

      // ৪. নতুন রেসপন্স বডি অনুযায়ী কন্ডিশন চেক (success == true)
      if (item["success"] == true) {
        // রেসপন্সে ডাটার মূল অবজেক্টের কি (Key) হলো "customer"
        var customerData = item["customer"];

        if (customerData != null) {
          await sharedPreferences.setString('name', customerData["Customer_Name"] ?? "");
          await sharedPreferences.setString('email', customerData["Customer_Email"] ?? "");
          await sharedPreferences.setString('phone', customerData["Customer_Mobile"] ?? "");
          await sharedPreferences.setString('address', customerData["Customer_Address"] ?? "");
          await sharedPreferences.setString('image', customerData["image_name"] ?? "");
          await sharedPreferences.setString('id', customerData["Customer_SlNo"].toString());
        }
        
        return item["message"] ?? "Profile Update successfully";
      } else {
        return item["message"] ?? "Failed to update profile";
      }
    } catch (e) {
      print("Error message $e");
      return e.toString();
    }
  }
}

















// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileChangeApi{
// static Future<String> changeProfile(String name) async {
//   print("name=== $name");

//   SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
//   String link = "${BaseUrl}customer_profile_update";

//   try {
//     final response = await Dio().post(
//       link,
//       data: {
//         "name": name.trim(),
//       },
//       options: Options(
//         headers: {
//           "Authorization":"Bearer ${sharedPreferences.getString("token")}",
//         },
//         followRedirects: true,
//         validateStatus: (status) {
//           return status! < 500;
//         },
//       ),
//     );

//     var item = response.data;
//     print("Profile Update response===== $item");

//     if (item["status"] == true) {
//       var data = item["data"];

//       await sharedPreferences.setString('name', data["Customer_Name"] ?? "");
//       await sharedPreferences.setString('email', data["Customer_Email"] ?? "");
//       await sharedPreferences.setString('phone', data["Customer_Mobile"] ?? "");
//       await sharedPreferences.setString('address', data["Customer_Address"] ?? "");
//       await sharedPreferences.setString('image', data["image_name"] ?? "");
//       await sharedPreferences.setString('id', data["Customer_SlNo"].toString());
//       return item["message"];
//     } else {
//       return item["message"];
//     }
//   } catch (e) {
//     print("Error message $e");
//     return e.toString();
//   }
// }
// }