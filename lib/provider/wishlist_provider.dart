import 'package:al_barakah_e_mart/api_integration/me/wishlist_api.dart';
import 'package:al_barakah_e_mart/model/wishList_model.dart';
import 'package:flutter/material.dart';

class WishListProvider with ChangeNotifier {
/////////////////////////////////////////////////////All Product Loist Providewr///////////////
  List<WishListModel> wishListData = [];

  Future<List<WishListModel>> getWishListData() async {
    wishListData = await WishListApi.getWishListData();
    return wishListData;
  }
}