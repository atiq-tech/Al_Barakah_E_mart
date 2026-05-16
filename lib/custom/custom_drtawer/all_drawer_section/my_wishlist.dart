import 'package:al_barakah_e_mart/all_api_provider/get_wish_list_provider.dart';
import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWishListScreen extends StatefulWidget {
  const MyWishListScreen({
  //   required this.mainImage,
  //   required this.mainPrice,
  //   this.cashbackAmount,
  //   required this.productName,
  //   required this.qty,
  //   this.subCategoryId,
  //   required this.productCode,
  //   this.status,
  //   this.ipAddress,
  //   this.addBy,
  //   this.addTime,
  //   this.brand,
  //   this.brandName,
  //   required this.cashbackPercent,
  //   this.isFeatured,
  //   this.isHotDeals,
  //   this.isNewArrival,
  //   this.productBranchid,
  //   this.productCategoryID,
  //   this.productCategoryName,
  //   required this.productDescription,
  //   this.productShippingReturns,
  //   this.productSlNo,
  //   this.productSubCategoryName,
  //   this.productSubSubCategoryName,
  //   required this.salePrice,
  //   required this.slug,
  //   this.stock,
  //   this.subSubCategoryId,
  //   this.unitID,
  //   this.unitName,
  //   this.updateBy,
  //   this.updateTime,
  //   this.purchaseRate,
  //   required this.colorDataModel,
  //   required this.sizeDataModel,
    super.key});
  // final String? productSlNo;
  // final String? productCode;
  // final String? productName;
  // final String slug;
  // final String? productCategoryID;
  // final String? subCategoryId;
  // final String? subSubCategoryId;
  // final String? brand;
  // final String? salePrice;
  // final String? mainPrice;
  // final String? purchaseRate;
  // final String? cashbackPercent;
  // final String? cashbackAmount;
  // final String? productDescription;
  // final String? productShippingReturns;
  // final String? stock;
  // final String? unitID;
  // final String? mainImage;
  // final String? isFeatured;
  // final String? isHotDeals;
  // final String? isNewArrival;
  // final String? status;
  // final String? addBy;
  // final String? addTime;
  // final String? updateBy;
  // final String? updateTime;
  // final String? ipAddress;
  // final String? productBranchid;
  // final String? qty;
  // final String? productCategoryName;
  // final String? productSubCategoryName;
  // final String? productSubSubCategoryName;
  // final String? brandName;
  // final String? unitName;
  // final List<ColorDataModel> colorDataModel;
  // final List<SizeDataModel> sizeDataModel;


  @override
  State<MyWishListScreen> createState() => _MyWishListScreenState();
}

class _MyWishListScreenState extends State<MyWishListScreen> {


  @override
  void initState() {
    GetWishListProvider.isGetWishListLoading = true;
    Provider.of<GetWishListProvider>(context,listen: false).getGetWishList();
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final addToCart = Provider.of<AddToCartProvider>(context, listen: true);
    final allWishListData = Provider.of<GetWishListProvider>(context).wishListData;
    print("wishlist lenth>>>>>  ${allWishListData.length}");
    // final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text("My WishList",style: AllTextStyle.getTitleTextStyle()),
        ),
        backgroundColor: scaffoldColor,
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 60),
          child: allWishListData.isEmpty
              ? const Center(child: Text("No items available",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),)
              : Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Consumer<GetWishListProvider>(
                      builder: (context, value, child) {
                        return Stack(
                          children: [
                            Card(
                              child: ListTile(
                                onTap: () {
                                   Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) => One_Product_Details(
                                              slug: allWishListData[index].product.slug,
                                              productId: allWishListData[index].product.id.toString(),
                                              ),
                                            ),
                                          );
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(slug: allWishListData[index].product.slug)));
                                },
                                leading: Container(
                                  height: 100,
                                  width: 50,
                                  decoration: const BoxDecoration(color: Colors.pink),
                                  child: CustomImage(
                                    path: "$BaseUrl${allWishListData[index].product.image}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: Text(allWishListData[index].product.name,style: const TextStyle(fontSize: 13.0,color: Colors.black,fontWeight: FontWeight.w500)),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("৳ ${allWishListData[index].product.discountPrice}",style: const TextStyle(color: Colors.green,fontWeight: FontWeight.w500),),
                                    GestureDetector(
                                      onTap:(){
                                        setState(() {
                                          addToCart.addProduct(
                                              AddToCartModel(
                                                id: int.parse("${allWishListData[index].id}"),
                                                productName: allWishListData[index].product.name,
                                                brandName: "",
                                                image: "$BaseUrl${allWishListData[index].product.image}",
                                                quantity: 1,
                                                slug: allWishListData[index].product.slug,
                                                discountPrice: double.parse(allWishListData[index].product.discountPrice),
                                              )
                                          );
                                          Utils.showSnackBar(context, "Successfully Added to Cart");
                                        });
                                      },
                                      child: Container(
                                        height: 30.0,
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                              color: Colors.teal.shade700,
                                            borderRadius: BorderRadius.circular(5.0),
                                          ),
                                          child: const Center(child: Text("Add to Cart",style: AllTextStyle.saveButtonTextStyle))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                            right: 10,
                            top: 8,
                            child: GestureDetector(
                            onTap: () {
                              setState(() {
                                removeWishListData("${allWishListData[index].id}");
                              });
                            },
                            child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.red,
                            ),
                            ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: allWishListData.length,
                ),
              ),
            ],
          ),
        )
    );
  }
  // addWishListData(String productId) async {
  //   SharedPreferences? sharedPreferences;
  //   sharedPreferences = await SharedPreferences.getInstance();
  //
  //   String url = "${BaseUrl}api/add_wish_list";
  //   final response = await Dio().post(
  //     url,
  //     data: {
  //       "customerId": "${sharedPreferences.getString("id")}",
  //       "product_id": productId
  //     },
  //     options: Options(
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization": "Bearer ${sharedPreferences.getString("token")}",
  //       },
  //     ),
  //   );
  //   var item = response.data;
  //   print("add to wish list ====>>  $item");
  //   if (item["success"] == true) {
  //     Utils.showSnackBar(context, "${item["message"]}");
  //     // Pass the required data to MyWishListScreen
  //     Navigator.pushReplacement(context,
  //       MaterialPageRoute(builder: (context) => MyWishListScreen(mainImage: '',productName: '',mainPrice: '', qty: '', productCode: '', cashbackPercent: '', productDescription: '', salePrice: '', slug: '', colorDataModel: [], sizeDataModel: [],),),
  //     );
  //   } else {
  //     Utils.showSnackBar(context, "${item["message"]}");
  //     return item;
  //   }
  // }

  removeWishListData(String productId) async {

    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String link = "${BaseUrl}api/destroy_wish_list";
    try {
      final formData = FormData.fromMap({
        "id" : productId
      });
      final response = await Dio().post(link, data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPreferences.getString("token")}",
          },
        ),
      );
      var item = response.data;
      print("wislist deleted==>  $item");
      if (item["success"] == true) {
        Utils.showSnackBar(context, "${item["message"]}");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyWishListScreen()));
      }else{
        return "Something wrong";
      }
    } catch (e) {
      print("Error message $e");
      return e.toString();
    }
  }

}
