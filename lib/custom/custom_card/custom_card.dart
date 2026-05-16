// import 'dart:ffi';
//
// import 'package:bestbazar/model/add_to_cart_model.dart';
// import 'package:bestbazar/model/product/color_model.dart';
// import 'package:bestbazar/model/product/size_model.dart';
// import 'package:bestbazar/provider/add_to_cart_provider.dart';
// import 'package:bestbazar/provider/company_profile_provider.dart';
// import 'package:bestbazar/provider/token_provider/token_provider.dart';
// import 'package:bestbazar/provider/user_profile_provider.dart';
// import 'package:bestbazar/screens/One_Product_Details/product_details_screen.dart';
// import 'package:bestbazar/screens/auth/pages/signin_page.dart';
// import 'package:bestbazar/screens/checkOut/checkout_from_details_screen.dart';
// import 'package:bestbazar/utils/custom_image.dart';
// import 'package:bestbazar/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';
//
// class CustomCardPage extends StatefulWidget {
//   const CustomCardPage({
//     Key? key,
//     this.id,
//     this.categoryId,
//     this.brandId,
//     required this.name,
//     required this.slug,
//     required this.productCode,
//     this.keyFeature,
//     required this.description,
//     this.sellingPrice,
//     this.discount,
//     required this.quantity,
//     required this.image,
//     this.ipAddress,
//     this.popular,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     required this.discountPrice,
//     ///=====
//     // required this.mainImage,
//     // required this.mainPrice,
//     // this.cashbackAmount,
//     // required this.productName,
//     // required this.qty,
//     // this.subCategoryId,
//     // required this.productCode,
//     // this.status,
//     // this.ipAddress,
//     // this.addBy,
//     // this.addTime,
//     // this.brand,
//     // this.brandName,
//     // required this.cashbackPercent,
//     // this.isFeatured,
//     // this.isHotDeals,
//     // this.isNewArrival,
//     // this.productBranchid,
//     // this.productCategoryID,
//     // this.productCategoryName,
//     // required this.productDescription,
//     // this.productShippingReturns,
//     // this.productSlNo,
//     // this.productSubCategoryName,
//     // this.productSubSubCategoryName,
//     // required this.salePrice,
//     // required this.slug,
//     // this.stock,
//     // this.subSubCategoryId,
//     // this.unitID,
//     // this.unitName,
//     // this.updateBy,
//     // this.updateTime,
//     // this.purchaseRate,
//     // required this.colorDataModel,
//     // required this.sizeDataModel,
//   }) : super(key: key);
//   final int? id;
//   final String? categoryId;
//   final String? brandId;
//   final String? name;
//   final String? slug;
//   final String? productCode;
//   final String? keyFeature;
//   final String? description;
//   final String? sellingPrice;
//   final String? discount;
//   final String? quantity;
//   final String? image;
//   final String? ipAddress;
//   final String? popular;
//   final String? status;
//   final String? createdAt;
//   final String? updatedAt;
//   final String? discountPrice;
//   ///======
//   // final String? productSlNo;
//   // final String? productCode;
//   // final String? productName;
//   // final String slug;
//   // final String? productCategoryID;
//   // final String? subCategoryId;
//   // final String? subSubCategoryId;
//   // final String? brand;
//   // final String? salePrice;
//   // final String? mainPrice;
//   // final String? purchaseRate;
//   // final String? cashbackPercent;
//   // final String? cashbackAmount;
//   // final String? productDescription;
//   // final String? productShippingReturns;
//   // final String? stock;
//   // final String? unitID;
//   // final String? mainImage;
//   // final String? isFeatured;
//   // final String? isHotDeals;
//   // final String? isNewArrival;
//   // final String? status;
//   // final String? addBy;
//   // final String? addTime;
//   // final String? updateBy;
//   // final String? updateTime;
//   // final String? ipAddress;
//   // final String? productBranchid;
//   // final String? qty;
//   // final String? productCategoryName;
//   // final String? productSubCategoryName;
//   // final String? productSubSubCategoryName;
//   // final String? brandName;
//   // final String? unitName;
//   // final List<ColorDataModel> colorDataModel;
//   // final List<SizeDataModel> sizeDataModel;
//
//   @override
//   State<CustomCardPage> createState() => _CustomCardPageState();
// }
//
// class _CustomCardPageState extends State<CustomCardPage> {
//
//
//
//   // late final Box? box;
//   @override
//   void initState() {
//     super.initState();
//     // Get reference to an already opened box
//     // box = Hive.box('cart');
//     ///====new====
//     Provider.of<TokenProvider>(context, listen: false).getToken();
//     Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
//     Provider.of<CompanyProfileProvider>(context, listen: false).getCompanyProfile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final addToCart = Provider.of<AddToCartProvider>(context, listen: true);
//     ///====new====
//     final userToken =  Provider.of<TokenProvider>(context).tokenData;
//     final userProfileModel = Provider.of<UserProfileProvider>(context, listen: true).userProfileResponseModel;
//     final companyProfileModel = Provider.of<CompanyProfileProvider>(context, listen: true).companyProfileModel;
//     final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;
//
//
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//           //color: Colors.white,
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(0.0)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 4,
//             child: Stack(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height/5.5,
//                   width: 200,
//                   child: CustomImage(
//                     path: "${widget.image}",
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 5),
//           Expanded(
//             flex: 2,
//             child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text("${widget.name}",
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     style: GoogleFonts.roboto(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 13,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     "৳ ${widget.discountPrice}",
//                     style: GoogleFonts.roboto(
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey.shade800,
//                     ),
//                   ),
//                   //  Text('৳ ${double.parse("${widget.salePrice}" ).toDouble() -  double.parse("${widget.cashbackPercent}").toDouble()}',
//                   //   style: GoogleFonts.roboto(
//                   //     fontSize: 15.0,
//                   //     fontWeight: FontWeight.w500,
//                   //     color: Colors.grey.shade800,
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           addToCart.addProduct(
//                             AddToCartModel(
//                                 id: int.parse("${widget.id}"),
//                                 productName: widget.name,
//                                 image: widget.image,
//                                 quantity: int.parse("${widget.quantity}"),
//                                 slug: widget.slug,
//                                 discountPrice: double.parse("${widget.discountPrice}"),
//                             )
//                             // AddToCartModel(
//                             //   id: int.parse("${widget.productSlNo}").toInt(),
//                             //   productName: widget.productName,
//                             //   image: widget.mainImage,
//                             //   mainPrice: 0.0,
//                             //   salePrice: double.parse("${widget.salePrice}").toDouble(),
//                             //   purchaseRate: widget.purchaseRate,
//                             //   cashBackAmount: widget.cashbackAmount,
//                             //   cashBackPercent: "${widget.cashbackPercent}",
//                             //   //cashBackPercent: widget.cashbackPercent,
//                             //  // colorId: widget.colorDataModel[0].colorId??"",
//                             //  // sizeId: widget.sizeDataModel[0].sizeId??"",
//                             //   quantity: int.parse("${widget.qty}"),
//                             //   slug: widget.slug,
//                             //   discountPrice: "",
//                             // ),
//                           );
//                           Utils.showSnackBar(context, "Successfully Added to Cart");
//                         });
//                       },
//                       child: Container(
//                         height: 30,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade300,
//                           borderRadius: BorderRadius.circular(3),
//                         ),
//                         child: Text("ADD",
//                           style: GoogleFonts.roboto(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 5.0),
//                   Expanded(
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {
//                           addToCart.addProduct(
//                               AddToCartModel(
//                                 id: int.parse("${widget.id}"),
//                                 productName: widget.name,
//                                 image: widget.image,
//                                 quantity: int.parse("${widget.quantity}"),
//                                 slug: widget.slug,
//                                 discountPrice: double.parse("${widget.discountPrice}"),
//                               )
//                             // AddToCartModel(
//                             //   id: int.parse("${widget.productSlNo}").toInt(),
//                             //   productName: widget.productName,
//                             //   image: widget.mainImage,
//                             //   mainPrice: 0.0,
//                             //   salePrice: double.parse("${widget.salePrice}").toDouble(),
//                             //   // colorId: widget.colorDataModel[0].colorId??"",
//                             //   // sizeId: widget.sizeDataModel[0].sizeId??"",
//                             //   quantity: int.parse("${widget.qty}"),
//                             //   slug: widget.slug,
//                             //   purchaseRate: '',
//                             //   cashBackPercent: "${widget.cashbackPercent}",
//                             //   cashBackAmount: '',
//                             //   discountPrice: '',
//                             // ),
//                           );
//                         });
//                       // Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(slug: "${widget.slug}"),));
//                       ///===new===
//                         ///===old===
//                        // if(userToken!='') {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 CheckoutScreen(
//                                   addToCart: addToCartProviderList,
//                                   from: 'cart',
//                                   quantity: 1,
//                                   ///===old===
//                                   // userProfileModel: userProfileModel!.userProfileModel,
//                                   //companyProfileModel: companyProfileModel!,
//                                   token: userToken,
//                                   total: "${Provider.of<AddToCartProvider>(context, listen: true).totalCartValue}",
//                                 ),
//                           ),
//                         );
//                           ///=====old====
//                         // }else{
//                         //   Utils.errorSnackBarWithButton(context, "Sign In Please",() {
//                         //     Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage(),));
//                         //   },);
//                         // }
//                       },
//                       child: Container(
//                         height: 30,
//                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: const Color(0xffFA9862)),
//                         alignment: Alignment.center,
//                         child: Text("BUY NOW", style: GoogleFonts.roboto(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
