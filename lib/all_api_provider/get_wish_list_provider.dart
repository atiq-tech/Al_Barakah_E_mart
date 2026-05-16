
import 'package:al_barakah_e_mart/all_api_model/get_wish_list_model.dart';
import 'package:al_barakah_e_mart/all_api_service/all_api_service.dart';
import 'package:flutter/material.dart';

class GetWishListProvider extends ChangeNotifier {

  // List<GetWishListModel> wishListData = [];
  // Future<List<GetWishListModel>> getGetWishList() async {
  //   wishListData = await AllApiService.fetchGetWishList();
  //   return wishListData;
  // }

  static bool  isGetWishListLoading = false;

  List<GetWishListModel> wishListData= [];
  getGetWishList() async {
    wishListData = await AllApiService.fetchGetWishList();
    off();
    notifyListeners();
  }
  off(){
    Future.delayed(const Duration(seconds: 1),() {
      print('offff');
      isGetWishListLoading = false;
      notifyListeners();
    },);
  }
  on(){
    print('onnn');
    isGetWishListLoading = true;
    notifyListeners();
  }
}