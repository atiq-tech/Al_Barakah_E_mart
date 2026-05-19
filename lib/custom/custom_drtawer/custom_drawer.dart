import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_category_provider.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/provider/token_provider/token_provider.dart';
import 'package:al_barakah_e_mart/provider/user_profile_provider.dart';
import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/menu_category_product.dart';
import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_individual_products.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? userName = "User";
  String? customerId = "";
  String? authType = "";

  int expandedIndex = -1; // 🔥 main controller

  Future<void> _initializeData() async {
    customerId = "${sharedPreferences.getString('id')}";
    userName = "${sharedPreferences.getString('name')}";
    authType = "${sharedPreferences.getString('auth_type')}";
  }

  @override
  void initState() {
    super.initState();
    _initializeData();

    Provider.of<TokenProvider>(context, listen: false).getToken();
    Provider.of<UserProfileProvider>(context, listen: false)
        .getUserProfile();

    Future.microtask(() {
      Provider.of<GetCategoriesProvider>(context, listen: false)
          .getGetCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<GetCategoriesProvider>(context);
    final categoryList = categoryProvider.getCategorieslist;

    return SafeArea(
      child: Drawer(
        backgroundColor: appBarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.r),
            bottomRight: Radius.circular(50.r),
          ),
        ),
        child: SizedBox(
          width: 200.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// 🔰 HEADER
                Container(
                  height: 110.h,
                  width: double.infinity,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: CustomImage(
                    path: "images/ablogo.png",
                    height: 120.h,
                    width: 120.w,
                  ),
                ),

                /// 🔰 CATEGORY LIST
                categoryList.isEmpty ? const Padding(padding: EdgeInsets.all(20),child: CircularProgressIndicator())
                 : ListView.builder(
                    itemCount: categoryList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final category = categoryList[index];
                      final hasSubCategory = category.subCategory != null && category.subCategory!.isNotEmpty;
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                        elevation: 5,
                        child: hasSubCategory
                          ? ExpansionTile(
                            key: ValueKey(expandedIndex == index), // 🔥 FIX
                            initiallyExpanded:expandedIndex == index,
                            onExpansionChanged: (isExpanded) {
                              setState(() {
                                expandedIndex =isExpanded ? index : -1;
                              });
                            },
                            tilePadding: EdgeInsets.symmetric(horizontal: 10.w),
                            childrenPadding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(vertical: -4),
                            collapsedIconColor: Colors.black,
                            iconColor: Colors.black,
                            title: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuCategoryProducts(
                                      slug: category.slug,
                                      categoryName:category.productCategoryName,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Image.network(
                                      "$imageUrl${category.image}",
                                      fit: BoxFit.fill,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(Icons.broken_image, size: 20, color: Colors.grey),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    category.productCategoryName ?? "",
                                    style: GoogleFonts.adamina(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            children: category.subCategory!.map<Widget>((subCategory) {
                              return Padding(
                                padding:EdgeInsets.only(left: 5.w, right: 5.w),
                                child: Card(
                                  color: const Color.fromARGB(255, 220, 248, 242),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                                  child: ListTile(
                                    visualDensity: const VisualDensity(vertical: -4),
                                    dense: true,
                                    title: Row(
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                          width: 20.w,
                                          child: Image.network(
                                            "$imageUrl${subCategory.image}",
                                            fit: BoxFit.fill,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Center(
                                                child: SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Center(
                                                child: Icon(Icons.broken_image, size: 20, color: Colors.grey),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          subCategory.name ??"",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context) =>SubCategoryIndividualProducts(
                                            categoryName: subCategory.name,
                                            categoryId:"${subCategory.categoryId}",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                          : ListTile(
                            visualDensity: const VisualDensity(vertical: -4),
                              title: Row(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Image.network(
                                      "$imageUrl${category.image}",
                                      fit: BoxFit.fill,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(Icons.broken_image, size: 20, color: Colors.grey),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    category.productCategoryName ?? "",
                                    style: GoogleFonts.adamina(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push( context,
                                  MaterialPageRoute(
                                    builder: (context) => MenuCategoryProducts(
                                      slug: category.slug,
                                      categoryName:category.productCategoryName,
                                    ),
                                  ),
                                );
                              },
                            ),
                      );
                    },
                  ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}










// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:al_barakah_e_mart/all_api_provider/get_category_provider.dart';
// import 'package:al_barakah_e_mart/main.dart';
// import 'package:al_barakah_e_mart/provider/token_provider/token_provider.dart';
// import 'package:al_barakah_e_mart/provider/user_profile_provider.dart';
// import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/menu_category_product.dart';
// import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_individual_products.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';


// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({Key? key}) : super(key: key);

//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer> {
//   String? userName = "User";
//   String? customerId = "";
//   String? authType = "";
//   Future<void> _initializeData() async {
//     customerId = "${sharedPreferences.getString('id')}";
//     userName = "${sharedPreferences.getString('name')}";
//     authType = "${sharedPreferences.getString('auth_type')}";

//     print("auth_type=========$authType");
//   }
  

//   @override
//   void initState() {
//     _initializeData();
//     // TODO: implement initState
//     super.initState();
//     Provider.of<TokenProvider>(context, listen: false).getToken();
//     Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
//     Future.microtask(() {
//     Provider.of<GetCategoriesProvider>(context,listen: false).getGetCategories();
//   });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categoryProvider = Provider.of<GetCategoriesProvider>(context);
//     final categoryList = categoryProvider.getCategorieslist;

//     return SafeArea(
//       child: Drawer(
//         backgroundColor: const Color.fromARGB(255, 20, 24, 29),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(topRight: Radius.circular(50.r),bottomRight: Radius.circular(50.r))
//         ),
//         child: SizedBox(
//           height: double.infinity,
//           width: 200.w,
//           child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 110.h,
//                       width: double.infinity,
//                       color: appBarColor,
//                       padding: EdgeInsets.all(10.r),
//                       alignment: Alignment.center,
//                       child: CustomImage(
//                         path: "images/tmlogo.png",
//                         fit: BoxFit.cover,
//                         height: 100.h,
//                         width: 100.w,
//                       ),
//                     ),

//                    categoryList.isEmpty ? const Center(child: CircularProgressIndicator())
//                       : ListView.builder(
//                           itemCount: categoryList.length,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             final category = categoryList[index];
//                             final hasSubCategory = category.children != null && category.children!.isNotEmpty;
//                             return Theme(
//                               data: Theme.of(context).copyWith(
//                                 dividerColor: Colors.transparent,
//                               ),
//                               child: Card(
//                                 elevation: 5,
//                                 color: Colors.white,
//                                 child: hasSubCategory
//                                     ? ExpansionTile(
//                                         tilePadding: EdgeInsets.symmetric(horizontal: 10.w),
//                                         childrenPadding: EdgeInsets.zero,
//                                         visualDensity: const VisualDensity(vertical: -4),
//                                         collapsedIconColor: Colors.black,
//                                         iconColor: Colors.black,
//                                         title: GestureDetector(
//                                           onTap: () {
//                                             Navigator.pop(context);
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => MenuCategoryProducts(
//                                                   slug: category.slug,
//                                                   categoryName: category.productCategoryName,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                           child: Text(
//                                             category.productCategoryName ?? "",
//                                             style: GoogleFonts.adamina(
//                                               fontSize: 11.sp,
//                                               fontWeight: FontWeight.w700,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                         children: List.generate(
//                                           category.children!.length,
//                                           (subIndex) {
//                                             final subCategory = category.children![subIndex];
//                                             return Padding(
//                                               padding: EdgeInsets.only(left: 5.w),
//                                               child: Card(
//                                                 elevation: 5,
//                                                 color: appBarColor,
//                                                 child: ListTile(
//                                                   dense: true,
//                                                   visualDensity: const VisualDensity(vertical: -4),
//                                                   title: Text(
//                                                     subCategory.productCategoryName ?? "",
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 11.sp,
//                                                     ),
//                                                   ),
//                                                   onTap: () {
//                                                     Navigator.pop(context);
//                                                     Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) => SubCategoryIndividualProducts(
//                                                           categoryName: subCategory.productCategoryName,
//                                                           categoryId:"${subCategory.productCategorySlNo}",
//                                                         ),
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       )
//                                     : ListTile(
//                                         visualDensity: const VisualDensity(vertical: -4),
//                                         title: Text(
//                                           category.productCategoryName ?? "",
//                                           style: GoogleFonts.adamina(
//                                             fontSize: 11.sp,
//                                             fontWeight: FontWeight.w700,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) => MenuCategoryProducts(
//                                                 slug: category.slug,
//                                                 categoryName: category.productCategoryName,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                               ),
//                             );
//                           },
//                         ),
//                       SizedBox(height: 100.h),
//                   ],
//                 ),
//               )
//         ),
//       ),
//     );
//   }
// }























// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({Key? key}) : super(key: key);

//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer> {
//   String? userName = "";
//   String? customerId = "";
//   String? authType = "";
//   Future<void> _initializeData() async {
//     customerId = "${sharedPreferences.getString('id')}";
//     userName = "${sharedPreferences.getString('name')}";
//     authType = "${sharedPreferences.getString('auth_type')}";

//     print("auth_type=========$authType");
//   }
  

//   @override
//   void initState() {
//     _initializeData();
//     // TODO: implement initState
//     super.initState();
//     Provider.of<TokenProvider>(context, listen: false).getToken();
//     Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;
//     final customerId = "${sharedPreferences.getString('id')}";
//     double size = 20.r;
//     double sizee = 15.r;
//     Color color = Colors.white;

//     return SafeArea(
//       child: Drawer(
//         backgroundColor: const Color.fromARGB(255, 20, 24, 29),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(topRight: Radius.circular(50.r),bottomRight: Radius.circular(50.r))
//         ),
//         child: SizedBox(
//           height: double.infinity,
//           width: 200.w,
//           child: LayoutBuilder(builder: (context, constraints) {
//             if (customerId == "null" ||customerId == "" ||customerId.isEmpty) {
//               return Center(
//                 child: ElevatedButton(onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage(),));
//                 }, child: const Text("Sign in Please")),
//               );
//             }
//             else{
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 150.h,
//                       width: double.infinity,
//                       color: appBarColor,
//                       padding: EdgeInsets.all(10.r),
//                       alignment: Alignment.center,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           CustomImage(
//                             path: "images/tmlogo.png",
//                             fit: BoxFit.cover,
//                             height: 100.h,
//                             width: 100.w,
//                           ),
//                           Text("Hello, $userName",style: GoogleFonts.adamina(fontSize: 12.sp,fontWeight: FontWeight.w700,color: color),),
//                         ],
//                       ),
//                     ),
//                     Custom_Item_Section(
//                       Name: "Home",
//                       onTap: () {
//                         Navigator.pop(context);
//                         MainController().naveListener.sink.add(0);
//                       },
//                       icon: Icon(Icons.home,size: size,color: color),
//                       iconn: Icon(Icons.arrow_forward_ios,size: sizee,color: color),
//                     ),
//                     Custom_Item_Section(
//                       Name: "My Profile",
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(context,MaterialPageRoute(builder: (context) => const UpdateProfile()));
//                       },
//                       icon: Icon(Icons.account_circle_outlined,size: size,color: color),
//                       iconn: Icon(Icons.arrow_forward_ios, size: sizee,color: color),
//                     ),
//                     Custom_Item_Section(
//                       Name: "Change Password",
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(context,MaterialPageRoute(builder: (context) => const ChangePassword()));
//                       },
//                       icon: Icon(Icons.visibility_off,size: size,color: color),
//                       iconn: Icon(Icons.arrow_forward_ios,size: sizee,color: color),
//                     ),
//                     authType == "reseller" ? Custom_Item_Section(
//                       Name: "Product List",
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(context,MaterialPageRoute(builder: (context) => const ProductListScreen()));
//                       },
//                       icon: Icon(Icons.card_giftcard,size: size,color: color),
//                       iconn: Icon(Icons.arrow_forward_ios,size: sizee,color: color),
//                     ):Custom_Item_Section(
//                       Name: "All Brands",
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(context,MaterialPageRoute(builder: (context) => const BrandsWiseAllItemsScreen()));
//                       },
//                       icon: Icon(Icons.add_chart,size: size,color: color),
//                       iconn: Icon(Icons.arrow_forward_ios,size: sizee,color: color),
//                     ),
//                     Custom_Item_Section(
//                       Name: "My Order",
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.push(context,MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
//                       },
//                       icon: Icon(Icons.shopping_cart,size: size,color: color),
//                       iconn: Icon(Icons.arrow_forward_ios,size: sizee,color: color),
//                     ),
//                     InkWell(
//                       onTap: () {
//                           addToCartProviderList.clear();
//                         Provider.of<TokenProvider>(context, listen: false).removeAToken();
//                         Navigator.pop(context);
//                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInPage()),(route) => false);
//                         Utils.showSnackBar(context, "User Logged out successfully");
//                       },
//                       child: Container(
//                         margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.r),
//                           color: appBarColor,
//                         ),
//                         padding: EdgeInsets.only(left: 10.w, right: 10.w),
//                         height: 35.h,
//                         width: MediaQuery.of(context).size.width,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Icon(Icons.logout_outlined, color: color),
//                                 SizedBox(width: 10.w),
//                                 Text(
//                                   "Log out",
//                                   style: GoogleFonts.adamina(
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.w700,
//                                     color: color,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Icon(Icons.arrow_forward_ios,size: sizee,color: color),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },)
//         ),
//       ),
//     );
//   }

//  Future<void> logoutApi(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString("token");
//   try {
//     String url = "${BaseUrl}customer/logout";
//     final response = await Dio().post(
//       url,
//       options: Options(
//         headers: {
//           "Authorization": "Bearer $token",
//           "Accept": "application/json",
//         },
//       ),
//     );

//     var data = response.data;

//     if (data["status"] == true) {
//       Utils.showSnackBar(context, data["message"] ?? "Logged out");
//     }
//   } on DioError catch (e) {
//     if (e.response?.statusCode == 401) {
//       print("Token expired → local logout");
//     } else {
//       Utils.errorSnackBar(context, "Logout failed");
//       return;
//     }
//   } catch (e) {
//     Utils.errorSnackBar(context, "Logout failed");
//     return;
//   }

//   /// ✅ LOCAL LOGOUT
//   Provider.of<TokenProvider>(context, listen: false).removeAToken();
//   await prefs.clear();

//   Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(builder: (_) => const SignInPage()),(route) => false,
//   );
// }
// }
