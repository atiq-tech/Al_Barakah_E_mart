import 'package:al_barakah_e_mart/api_integration/me/profile_api.dart';
import 'package:al_barakah_e_mart/model/profile_model.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier{

  static bool isLoading = false;

  UserProfileResponseModel? userProfileResponseModel;

  getUserProfile() async {
    userProfileResponseModel = await ProfileApi.fetchUserProfile();
    off();
    notifyListeners();
    // return userProfileResponseModel!;
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isLoading = true;
    notifyListeners();
  }

}