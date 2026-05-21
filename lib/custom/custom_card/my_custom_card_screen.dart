import 'package:al_barakah_e_mart/screens/one_product_details/product_details_screen.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';

import '../../model/add_to_cart_model.dart';
import '../../provider/add_to_cart_provider.dart';
import '../../provider/token_provider/token_provider.dart';
import '../../provider/user_profile_provider.dart';
import '../../utils/custom_image.dart';

class MyCustomCardScreen extends StatefulWidget {
  const MyCustomCardScreen({super.key,
    this.id,
    this.categoryId,
    this.brandId,
    required this.name,
    required this.slug,
    required this.productCode,
    this.keyFeature,
    required this.description,
    this.sellingPrice,
    this.wholesaleRate,
    this.discount,
    this.stock,
    required this.quantity,
    required this.image,
    this.ipAddress,
    this.popular,
    this.status,
    this.createdAt,
    this.updatedAt,
    required this.discountPrice,
  });
  final int? id;
  final String? categoryId;
  final String? brandId;
  final String? name;
  final String? slug;
  final String? productCode;
  final String? keyFeature;
  final String? description;
  final String? sellingPrice;
  final String? wholesaleRate;
  final String? discount;
  final int? stock;
  final String? quantity;
  final String? image;
  final String? ipAddress;
  final String? popular;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? discountPrice;

  @override
  State<MyCustomCardScreen> createState() => _MyCustomCardScreenState();
}

class _MyCustomCardScreenState extends State<MyCustomCardScreen> {
  String? userName = "";
  String? customerId = "";
  String? authType = "";
  Future<void> _initializeData() async {
    customerId = "${sharedPreferences.getString('id')}";
    userName = "${sharedPreferences.getString('name')}";
    authType = "${sharedPreferences.getString('auth_type')}";

    print("auth_type=========$authType");
  }

  // late final Box? box;
  @override
  void initState() {
    _initializeData();
    super.initState();
    // Get reference to an already opened box
    // box = Hive.box('cart');
    ///====new====
    Provider.of<TokenProvider>(context, listen: false).getToken();
    Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final addToCart = Provider.of<AddToCartProvider>(context, listen: true);
    ///====new====
    //final userToken =  Provider.of<TokenProvider>(context).tokenData;
    //final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 242, 255),
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(2.r),
       ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: 200.w,
                  child: CustomImage(
                    path: "${widget.image}",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${widget.name}",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                  ),
                ),
                Center(
                 child: Text(
                    "${widget.discountPrice}",
                    style: GoogleFonts.roboto(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800
                    ),
                  ),
               )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 5.w,right: 5.w,bottom: 5.h),
                child: Row(
                  children: [
                      Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (_) =>
                              One_Product_Details(
                                slug: "${widget.slug}",
                                productId: widget.id.toString(),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 25.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: appBarColor),
                          alignment: Alignment.center,
                          child: Text("Details", style: GoogleFonts.roboto(color: Colors.white,fontSize: 10.sp,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            addToCart.addProduct(
                              AddToCartModel(
                                id: int.parse("${widget.id}"),
                                productName: widget.name,
                                image: widget.image,
                                quantity: int.parse("${widget.quantity}"),
                                slug: widget.slug,
                                discountPrice: double.parse("${widget.discountPrice}"),
                              )
                            );
                            CustomSnackBar.showTopSnackBar(context, "Successfully Added to Cart");
                          });
                        },
                        child: Container(
                          height: 25.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            //color: appBarColor,
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(color: appBarColor,width: 1.w)
                          ),
                          child: Text("Add to Cart",
                            style: GoogleFonts.roboto(color: appBarColor,fontSize: 10.sp,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
