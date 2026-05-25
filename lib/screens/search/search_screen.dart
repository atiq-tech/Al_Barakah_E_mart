import 'package:al_barakah_e_mart/utils/what_up_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_provider/all_searching_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/searching_wise_products_provider.dart';
import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
import 'package:al_barakah_e_mart/screens/allProduct/new_all_product_page.dart';
import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchCtrl = TextEditingController();
  late Future<List<AllProductModel>?> _productsFuture;
  bool showClearButton = false;

  @override
  void initState() {
    super.initState();
    _productsFuture = Provider.of<AllSearchingProductsProvider>(context, listen: false).getAllSearchingProducts();       
    searchCtrl.addListener(() {
      setState(() {
        showClearButton = searchCtrl.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      floatingActionButton: const CustomContactFAB(),
      body: FutureBuilder(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          } else if (snapshot.hasData) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, top: 15.h, right: 12.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MainScreen()),
                            );
                          },
                          icon: Icon(Icons.arrow_back, size: 20.r),
                          visualDensity: VisualDensity.compact,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Container(
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.r), 
                              border: Border.all(
                                color: appBarColor,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TypeAheadField<AllProductModel>(
                                    controller: searchCtrl,
                                    builder: (context, controller, focusNode) {
                                      return TextField(
                                        controller: controller,
                                        focusNode: focusNode,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                                          hintText: "Search...",
                                          hintStyle: TextStyle(
                                            fontSize: 14.sp, 
                                            color: Colors.grey.shade500,
                                          ),
                                          border: InputBorder.none,
                                          isDense: true,
                                          suffixIcon: showClearButton
                                          ? GestureDetector(
                                              onTap: () {
                                                searchCtrl.clear();
                                                controller.clear();
                                              },
                                              child: Icon(
                                                Icons.clear, 
                                                color: Colors.grey.shade400, 
                                                size: 18,
                                              ),
                                            )
                                          : null,
                                        ),
                                      );
                                    },
                                    suggestionsCallback: (pattern) {
                                      if (pattern.isEmpty) return [];
                                      return snapshot.data!
                                          .where((element) => element.productName
                                              .toString()
                                              .toLowerCase()
                                              .contains(pattern.toLowerCase()))
                                          .toList();
                                    },
                                    itemBuilder: (context, AllProductModel suggestion) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(4.r),
                                              child: Container(
                                                height: 35.h,
                                                width: 35.w,
                                                color: Colors.grey.shade50,
                                                child: CustomImage(path: "$imageUrl${suggestion.productImage}"),
                                              ),
                                            ),
                                            SizedBox(width: 12.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${suggestion.productName}",
                                                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 2.h),
                                                  Text("Code: ${suggestion.productCode}",
                                                    style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    onSelected: (AllProductModel suggestion) {
                                      Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                          builder: (context) => One_Product_Details(
                                            slug: suggestion.slug,
                                            productId: suggestion.productSlNo.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Provider.of<SearchingWiseProductsProvider>(context, listen: false).getSearchingWiseProducts(searchCtrl.text);
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const NewAllProductPage()));
                                  },
                                  child: Container(
                                    width: 40.w,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: appBarColor, 
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(100.r),bottomRight: Radius.circular(100.r)),
                                    ),
                                    child: Icon(Icons.search, color: Colors.white, size: 20.r),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}