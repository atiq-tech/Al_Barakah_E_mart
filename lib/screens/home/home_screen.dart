
import 'package:al_barakah_e_mart/all_api_provider/get_category_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/special_products_provider.dart';
import 'package:al_barakah_e_mart/screens/view_all/view_all_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_provider/all_searching_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_slide_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/popular_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/resent_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/searching_wise_products_provider.dart';
import 'package:al_barakah_e_mart/custom/custom_card/my_custom_card_screen.dart';
import 'package:al_barakah_e_mart/footer_section/about_section.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_product.dart';
import 'package:al_barakah_e_mart/screens/main/component/main_controller.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String? title;

  const HomeScreen({super.key, this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName = "";
  String? customerId = "";
  Future<void> _initializeData() async {
    userName = "${sharedPreferences.getString('name')}";
    customerId = "${sharedPreferences.getString('id')}";
    print("User all Information   userName:$userName");
  }

  @override
  void initState() {
    _initializeData();
    SearchingWiseProductsProvider.isSearchingWiseProductsloading = true;
    Provider.of<SearchingWiseProductsProvider>(context,listen: false).getSearchingWiseProducts("");
    Provider.of<SliderProvider>(context,listen: false).getSlider();
    Provider.of<ResentProductProvider>(context,listen: false).getResentProduct();
    Provider.of<PopularProductsProvider>(context,listen: false).getPopularProducts();
    Provider.of<NewArrivalProductsProvider>(context,listen: false).getNewArrivalProducts();
    super.initState();
    Future.microtask(() {
      Provider.of<GetCategoriesProvider>(context,listen: false).getGetCategories();
    });
  }
  int currentIndex = 0;
  void callbackFunction(int index,CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final sliderImages = Provider.of<SliderProvider>(context).sliderlist;
    final allCategorieslist = Provider.of<GetCategoriesProvider>(context).getCategorieslist;
    final allResentProductlist = Provider.of<ResentProductProvider>(context).resentProductlist;
    final allPopularProductlist = Provider.of<PopularProductsProvider>(context).popularProductslist;
    final allNewArrivalProductlist = Provider.of<NewArrivalProductsProvider>(context).newArrivalProductslist;

    return RefreshIndicator(
      onRefresh: () => Provider.of<AllSearchingProductsProvider>(context,listen: false).getAllSearchingProducts(),
      child: CustomScrollView(
        slivers: [
          ///================ SLIDER =================
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              child: CarouselSlider(
                items: List.generate(
                  sliderImages.length,
                      (index) {
                    return SizedBox(
                      width: double.infinity,
                      child: CustomImage(
                        path:
                        "$imageUrl${sliderImages[index].image}",
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
                options: CarouselOptions(
                  height: 180.h,
                  viewportFraction: 1,
                  enableInfiniteScroll:
                  sliderImages.length > 1,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  autoPlayInterval:
                  const Duration(seconds: 5),
                  autoPlayAnimationDuration:
                  const Duration(milliseconds: 800),
                  onPageChanged: callbackFunction,
                ),
              ),
            ),
          ),

          ///================ CATEGORY =================
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                top: 15.h,
                bottom: 2.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Divider(
                    height: 1,
                    thickness: 1.2,
                    color: appBarColor,
                  ),

                  SizedBox(height: 2.h),

                  InkWell(
                    onTap: () {
                      MainController()
                          .naveListener
                          .sink
                          .add(1);
                    },
                    child: Text(
                      "Product Category",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: appBarColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Divider(
                    height: 1,
                    thickness: 1.2,
                    color: appBarColor,
                  ),

                  SizedBox(height: 10.h),

                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: allCategorieslist.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 120,
                    ),
                    itemBuilder: (context, index) {

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SubCategoryProduct(
                                categoryName: allCategorieslist[index].productCategoryName,
                                categoryId: "${allCategorieslist[index].productCategorySlNo}",
                                subCategoryList: allCategorieslist[index].subCategory ?? [],
                              ),
                            ),
                          );
                        },

                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 3,

                          child: Column(
                            children: [

                              Expanded(
                                flex: 4,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.only(
                                    topLeft:
                                    Radius.circular(
                                        10.r),
                                    topRight:
                                    Radius.circular(
                                        10.r),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Image.network(
                                      "$imageUrl${allCategorieslist[index].image}",
                                      fit: BoxFit.fill,

                                      loadingBuilder:
                                          (
                                          context,
                                          child,
                                          loadingProgress,
                                          ) {
                                        if (loadingProgress ==
                                            null) {
                                          return child;
                                        }

                                        return const Center(
                                          child:
                                          CircularProgressIndicator(),
                                        );
                                      },

                                      errorBuilder:
                                          (
                                          context,
                                          error,
                                          stackTrace,
                                          ) {
                                        return const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: appBarColor,
                                    borderRadius:
                                    BorderRadius.only(
                                      bottomLeft:
                                      Radius.circular(
                                          10.r),
                                      bottomRight:
                                      Radius.circular(
                                          10.r),
                                    ),
                                  ),

                                  child: Center(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                      ),
                                      child: Text(
                                        allCategorieslist[
                                        index]
                                            .productCategoryName,
                                        textAlign:
                                        TextAlign.center,
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow
                                            .ellipsis,
                                        style:
                                        GoogleFonts.poppins(
                                          fontSize: 10.sp,
                                          color:
                                          Colors.white,
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          ///================ RECENT PRODUCT =================
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                top: 15.h,
                bottom: 2.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Divider(
                    height: 1,
                    thickness: 1.2,
                    color: appBarColor,
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    "Recent Product",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: appBarColor,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Divider(
                    height: 1,
                    thickness: 1.2,
                    color: appBarColor,
                  ),

                  SizedBox(height: 10.h),

                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    allResentProductlist.length,

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 270,
                    ),

                    itemBuilder: (context, index) {

                      final product =
                      allResentProductlist[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  One_Product_Details(
                                    slug: product.slug,
                                    productId: product
                                        .productSlNo
                                        .toString(),
                                  ),
                            ),
                          );
                        },

                        child: MyCustomCardScreen(
                          quantity: "1",
                          image:
                          "$imageUrl${product.thumImage}",
                          name: product.productName,
                          description:
                          product.productDescription,
                          discountPrice: product
                              .productSellingPrice
                              .toString(),
                          sellingPrice: product
                              .productSellingPrice
                              .toString(),
                          productCode:
                          product.productCode,
                          id: int.tryParse(
                            product.productSlNo
                                .toString(),
                          ),
                          slug: product.slug,
                          stock: product.stock,
                          discount: "",
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          ///================ VIEW ALL =================
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                right: 10.w,
                top: 10,
                bottom: 2.h,
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ViewAllScreen(),
                        ),
                      );
                    },

                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),

                      decoration: BoxDecoration(
                        color: appBarColor,
                        borderRadius:
                        BorderRadius.circular(5.r),
                      ),

                      child: Row(
                        children: [

                          Text(
                            "View All",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),

                          SizedBox(width: 4.w),

                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12.sp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///================ POPULAR PRODUCT =================
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                top: 10.h,
                bottom: 10.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Divider(
                    height: 1,
                    thickness: 1.2,
                    color: appBarColor,
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    "Popular Product",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: appBarColor,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Divider(
                    height: 1,
                    thickness: 1.2,
                    color: appBarColor,
                  ),

                  SizedBox(height: 10.h),

                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    allPopularProductlist.length,

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 250,
                    ),

                    itemBuilder: (context, index) {

                      final product =
                      allPopularProductlist[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  One_Product_Details(
                                    slug: product.slug,
                                    productId: product
                                        .productSlNo
                                        .toString(),
                                  ),
                            ),
                          );
                        },

                        child: MyCustomCardScreen(
                          quantity: "1",
                          image:
                          "$imageUrl${product.thumImage}",
                          name: product.productName,
                          description:
                          product.productDescription,
                          discountPrice: product
                              .productSellingPrice
                              .toString(),
                          sellingPrice: product
                              .productSellingPrice
                              .toString(),
                          productCode:
                          product.productCode,
                          id: int.tryParse(
                            product.productSlNo
                                .toString(),
                          ),
                          slug: product.slug,
                          stock: product.stock,
                          discount: "",
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          ///================ NEW ARRIVAL =================
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                top: 15.h,
                bottom: 10.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Divider(
                    height: 1,
                    thickness: 1.2,
                    color: appBarColor,
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    "New Arrival",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: appBarColor,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Divider(
                    height: 1,
                    thickness: 1.2,
                    color: appBarColor,
                  ),

                  SizedBox(height: 10.h),

                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    allNewArrivalProductlist.length,

                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 250,
                    ),

                    itemBuilder: (context, index) {

                      final product =
                      allNewArrivalProductlist[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  One_Product_Details(
                                    slug: product.slug,
                                    productId: product
                                        .productSlNo
                                        .toString(),
                                  ),
                            ),
                          );
                        },

                        child: MyCustomCardScreen(
                          quantity: "1",
                          image:
                          "$imageUrl${product.thumImage}",
                          name: product.productName,
                          description:
                          product.productDescription,
                          discountPrice: product
                              .productSellingPrice
                              .toString(),
                          sellingPrice: product
                              .productSellingPrice
                              .toString(),
                          productCode:
                          product.productCode,
                          id: int.tryParse(
                            product.productSlNo
                                .toString(),
                          ),
                          slug: product.slug,
                          stock: product.stock,
                          discount: "",
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ///================ FOOTER =================
          const SliverToBoxAdapter(child: BigBuyFooter()),
        ],
      ),
    );
  }
}




// class HomeScreen extends StatefulWidget {
//   final String? title;

//   const HomeScreen({super.key, this.title});

//   @override
//   State<StatefulWidget> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String? userName = "";
//   String? customerId = "";
//   String? authType = "";
//   Future<void> _initializeData() async {
//     userName = "${sharedPreferences.getString('name')}";
//     customerId = "${sharedPreferences.getString('id')}";
//     authType = "${sharedPreferences.getString('auth_type')}";

//     print("auth_type=========$authType");
//     print("User all Information   userName:$userName");

//   }
//   @override
//   void initState() {
//     _initializeData();
//     SearchingWiseProductsProvider.isSearchingWiseProductsloading = true;
//     Provider.of<SearchingWiseProductsProvider>(context,listen: false).getSearchingWiseProducts("");
//     ///===new===
//     Provider.of<SliderProvider>(context, listen: false).getSlider();
//     Provider.of<ResentProductProvider>(context,listen: false).getResentProduct();
//     Provider.of<PopularProductsProvider>(context,listen: false).getPopularProducts();
//     Provider.of<NewArrivalProductsProvider>(context,listen: false).getNewArrivalProducts();

//     // TODO: implement initState
//     super.initState();
//     Future.microtask(() {
//     Provider.of<GetCategoriesProvider>(context,listen: false).getGetCategories();
//   });
//   }
//   void callbackFunction(int index, CarouselPageChangedReason reason) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final sliderImages = Provider.of<SliderProvider>(context).sliderlist;
//     print("sliderImages========      ${sliderImages.length}");
//     final allCategorieslist = Provider.of<GetCategoriesProvider>(context).getCategorieslist;
//     print("allCategorieslist========      ${allCategorieslist.length}");
//     final allResentProductlist = Provider.of<ResentProductProvider>(context).resentProductlist;
//     print("allResentProductlist========      ${allResentProductlist.length}");
//     final allPopularProductlist = Provider.of<PopularProductsProvider>(context).popularProductslist;
//     print("allPopularProductlist========      ${allPopularProductlist.length}");
//     final allNewArrivalProductlist = Provider.of<NewArrivalProductsProvider>(context).newArrivalProductslist;
//     print("allNewArrivalProductlist========      ${allNewArrivalProductlist.length}");


//     const padding = EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 0);
//     return RefreshIndicator(
//       onRefresh: () => Provider.of<AllSearchingProductsProvider>(context,listen: false).getAllSearchingProducts(),
//       child: CustomScrollView(
//         scrollDirection: Axis.vertical,
//         slivers:[
//           ///=====Img Slide=====
//           SliverToBoxAdapter(
//             child: SizedBox(
//               // height: 200,
//                 width: double.infinity,
//                 child: Stack(
//                   children: [
//                     CarouselSlider(
//                       items: List.generate(sliderImages.length, (index) {
//                         return SizedBox(
//                           width: double.infinity,
//                           child: CustomImage(
//                             path: "$imageUrl${sliderImages[index].image}",
//                             fit: BoxFit.fill,
//                           ),
//                         );
//                       }),
//                       options: CarouselOptions(
//                         viewportFraction: 1,
//                         enableInfiniteScroll: sliderImages.length > 1,
//                         reverse: false,
//                         autoPlay: true,
//                         autoPlayInterval: const Duration(seconds: 5),
//                         autoPlayAnimationDuration: const Duration(milliseconds: 1000),
//                         autoPlayCurve: Curves.fastOutSlowIn,
//                         enlargeCenterPage: true,
//                         onPageChanged: callbackFunction,
//                         scrollDirection: Axis.horizontal,
//                       ),
//                     ),
//                   ],
//                 )
//             ),
//           ),
//           ///=============Product Categories=========
//           SliverPadding(
//             padding: padding,
//             sliver: SliverList(
//               delegate: SliverChildBuilderDelegate((context, index) {
//                 return Column(
//                   children: [
//                     Column(
//                       children: [
//                         const SizedBox(height: 5.0),
//                         Divider(height: 1.0,thickness: 1.5,color: appBarColor),
//                         const SizedBox(height: 2.0),
//                         InkWell(
//                           onTap:(){
//                             MainController().naveListener.sink.add(1);
//                           },
//                           child: Column(
//                             children: [
//                               Text("Product Category",style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w700,color: appBarColor),
//                               )),
//                           ],),
//                         ),
//                         const SizedBox(height: 5.0),
//                         Divider(height: 1.0,thickness: 1.5,color: appBarColor),
//                         const SizedBox(height: 12.0),
//                         GridView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: allCategorieslist.length,
//                           scrollDirection: Axis.vertical,
//                           gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 5.0,
//                             mainAxisSpacing: 5.0,
//                             mainAxisExtent: 120
//                           ),
//                           itemBuilder: ((context, index) {
//                             return GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryProduct(
//                                     categoryName: allCategorieslist[index].productCategoryName,
//                                     categoryId: "${allCategorieslist[index].productCategorySlNo}",
//                                     subCategoryList: allCategorieslist[index].subCategory ?? [],
//                                   ),));
//                                 },
//                                child: Card(
//                                 elevation: 6,
//                                 child: Column(
//                                   children: [
//                                   Expanded(
//                                     flex: 3,
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10.r),
//                                         topRight: Radius.circular(10.r),
//                                       ),
//                                       child: SizedBox(
//                                         height: 125.h,
//                                         width: double.infinity,
//                                         child: Image.network(
//                                           "$imageUrl${allCategorieslist[index].image}",
//                                           fit: BoxFit.fill,
//                                           loadingBuilder: (context, child, loadingProgress) {
//                                             if (loadingProgress == null) return child;
//                                             return Center(
//                                               child: SizedBox(
//                                                 height: 25,
//                                                 width: 25,
//                                                 child: CircularProgressIndicator(
//                                                   strokeWidth: 2,
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                           errorBuilder: (context, error, stackTrace) {
//                                             return const Center(
//                                               child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                     height: 75.h,
//                                     width: double.infinity,
//                                     padding: EdgeInsets.symmetric(horizontal: 2.w),
//                                     decoration: BoxDecoration(
//                                       color: appBarColor,
//                                       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r),bottomRight: Radius.circular(10.r))
//                                     ),
//                                     child: Center(
//                                      child: Text(
//                                       allCategorieslist[index].productCategoryName,
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 10.sp,
//                                         fontWeight: FontWeight.w500,
//                                         color:Colors.white
//                                       ),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                      ),
//                                      ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               )
//                                 );
//                           }),
//                         )
//                       ],
//                     ),
//                   ],
//                 );
//               }, childCount: 1),
//             ),
//           ), 
//           ///===============RESENT PRODRCT============
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w),
//               child: Column(
//                 children: [
//                     const SizedBox(height: 5.0),
//                     Divider(height: 1.0,thickness: 1.5,color: appBarColor),
//                     const SizedBox(height: 2.0),
//                     Column(
//                       children: [
//                         Text("Recent Product",style: GoogleFonts.poppins(
//                           textStyle: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w700,color: appBarColor),
//                         )),
//                     ],),
//                     const SizedBox(height: 5.0),
//                     Divider(height: 1.0,thickness: 1.5,color: appBarColor),
//                     const SizedBox(height: 12.0),
//                     GridView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: allResentProductlist.length,
//                     scrollDirection: Axis.vertical,
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10.0,
//                       mainAxisSpacing: 10.0,
//                       mainAxisExtent: 280
//                     ),
//                     itemBuilder: ((context, index) {
//                      final product = allResentProductlist[index];
//                       return GestureDetector(
//                           onTap: () {
//                             Navigator.push(context,
//                               MaterialPageRoute(builder: (_) =>One_Product_Details(
//                                 slug: product.slug,
//                                 productId: product.productSlNo.toString()),
//                               ),
//                             );
//                           },
//                           child: MyCustomCardScreen(
//                             quantity: "1",
//                             image: "$imageUrl${product.thumImage}",
//                             name: product.productName,
//                             description: product.productDescription,
//                             discountPrice: product.productWholesaleRate.toString(),
//                             sellingPrice: product.productWholesaleRate.toString(),
//                             productCode: product.productCode,
//                             id: int.tryParse(product.productSlNo.toString()),
//                             slug: product.slug,
//                             stock: product.stock,
//                             discount: "",
//                           )
//                         );
//                     }),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//           child: Padding(
//              padding: EdgeInsets.only(right: 10.w,bottom: 5.h),
//               child: Row(
//                 mainAxisAlignment:  MainAxisAlignment.end,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,MaterialPageRoute(builder: (_) => ViewAllScreen()));
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 6.h),
//                       decoration: BoxDecoration(color: appBarColor,borderRadius:BorderRadius.circular(5.r)),
//                       child: Row(
//                         children: [
//                           Text("View All",style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.w800)),
//                           SizedBox(width: 4.w),
//                           Icon(Icons.arrow_forward_ios,size: 12.sp,color: Colors.white),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ///===============POPULAR PRODRCT============
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w),
//               child: Column(
//                 children: [
//                     const SizedBox(height: 5.0),
//                     Divider(height: 1.0,thickness: 1.5,color: appBarColor),
//                     const SizedBox(height: 2.0),
//                     Column(
//                       children: [
//                         Text("Popular Product",style: GoogleFonts.poppins(
//                           textStyle: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w700,color: appBarColor),
//                         )),
//                     ],),
//                     const SizedBox(height: 5.0),
//                     Divider(height: 1.0,thickness: 1.5,color: appBarColor),
//                     const SizedBox(height: 12.0),
//                     GridView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: allPopularProductlist.length,
//                     scrollDirection: Axis.vertical,
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10.0,
//                       mainAxisSpacing: 10.0,
//                       mainAxisExtent: 250
//                     ),
//                     itemBuilder: ((context, index) {
//                      final product = allPopularProductlist[index];
//                       return GestureDetector(
//                           onTap: () {
//                             Navigator.push(context,
//                               MaterialPageRoute(builder: (_) =>One_Product_Details(
//                                 slug: product.slug,
//                                 productId: product.productSlNo.toString()),
//                               ),
//                             );
//                           },
//                           child: MyCustomCardScreen(
//                             quantity: "1",
//                             image: "$imageUrl${product.thumImage}",
//                             name: product.productName,
//                             description: product.productDescription,
//                             discountPrice: product.productWholesaleRate.toString(),
//                             sellingPrice: product.productWholesaleRate.toString(),
//                             productCode: product.productCode,
//                             id: int.tryParse(product.productSlNo.toString()),
//                             slug: product.slug,
//                             stock: product.stock,
//                             discount: "",
//                           )
//                         );
//                     }),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           ///===============NEW ARRIVAL PRODRCT============
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.w),
//               child: Column(
//                 children: [
//                     const SizedBox(height: 5.0),
//                     Divider(height: 1.0,thickness: 1.5,color: appBarColor),
//                     const SizedBox(height: 2.0),
//                     Column(
//                       children: [
//                         Text("New Arrival",style: GoogleFonts.poppins(
//                           textStyle: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w700,color: appBarColor),
//                         )),
//                     ],),
//                     const SizedBox(height: 5.0),
//                     Divider(height: 1.0,thickness: 1.5,color: appBarColor),
//                     const SizedBox(height: 12.0),
//                     GridView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: allNewArrivalProductlist.length,
//                     scrollDirection: Axis.vertical,
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10.0,
//                       mainAxisSpacing: 10.0,
//                       mainAxisExtent: 250
//                     ),
//                     itemBuilder: ((context, index) {
//                      final product = allNewArrivalProductlist[index];
//                       return GestureDetector(
//                           onTap: () {
//                             Navigator.push(context,
//                               MaterialPageRoute(builder: (_) =>One_Product_Details(
//                                 slug: product.slug,
//                                 productId: product.productSlNo.toString()),
//                               ),
//                             );
//                           },
//                           child: MyCustomCardScreen(
//                             quantity: "1",
//                             image: "$imageUrl${product.thumImage}",
//                             name: product.productName,
//                             description: product.productDescription,
//                             discountPrice: product.productWholesaleRate.toString(),
//                             sellingPrice: product.productWholesaleRate.toString(),
//                             productCode: product.productCode,
//                             id: int.tryParse(product.productSlNo.toString()),
//                             slug: product.slug,
//                             stock: product.stock,
//                             discount: "",
//                           )
//                         );
//                     }),
//                   )
//                 ],
//               ),
//             ),
//           ),
//          ///==========Footer Area=========
//           const SliverToBoxAdapter(
//             child: BigBuyFooter(),
//           ),
//         ],
//       ),
//     );
//   }
// }
