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
  String? selectSearch;
  String? slugging;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      floatingActionButton: const CustomContactFAB(),
      body: FutureBuilder(
        future: Provider.of<AllSearchingProductsProvider>(context).getAllSearchingProducts(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasData){
            return Container(
              padding: EdgeInsets.only(left: 5.w, top: 40.h, right: 5.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                            //Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                      flex: 9,
                      child: SizedBox(
                        height: 28.h,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            border: Border.all(color: appBarColor),
                            color: Colors.white,
                          ),
                          child: TypeAheadField<AllProductModel>(
                            controller: searchCtrl,
                            builder: (context, controller, focusNode) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey.shade600,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 5.h, left: 10.w),
                                  hintText: "Search Here...",
                                  hintStyle: TextStyle(fontSize: 12.sp),
                                  border: InputBorder.none,
                                  isDense: true,
                                  suffixIcon: selectSearch == '' ? null
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              searchCtrl.clear();
                                              controller.clear();
                                              selectSearch = '';
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
                                            child: Icon(
                                              Icons.close,
                                              size: 14.r,
                                            ),
                                          ),
                                        ),
                                ),
                                onChanged: (value) {
                                  if (value == '') {
                                    setState(() {
                                      selectSearch = '';
                                    });
                                  }
                                },
                                onTap: () async {
                                  // Optional: preload if needed
                                },
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
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 35.h,
                                      width: 35.w,
                                      child: CustomImage(path: "$imageUrl${suggestion.productImage}"),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        "${suggestion.productName}-${suggestion.productCode}",
                                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            onSelected: (AllProductModel suggestion) {
                              slugging = suggestion.slug;
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => One_Product_Details(slug: suggestion.slug,
                                      productId: suggestion.productSlNo.toString()),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                      SizedBox(width: 5.w),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<SearchingWiseProductsProvider>(context, listen: false).getSearchingWiseProducts(searchCtrl.text);
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const NewAllProductPage()),
                            );
                          },
                          child: Center(child: Text("Search",style: TextStyle(color: appBarColor))),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          else{
            return const SizedBox();
          }
        },
      ),
    );
  }
}







// import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
// import 'package:al_barakah_e_mart/all_api_provider/all_searching_products_provider.dart';
// import 'package:al_barakah_e_mart/all_api_provider/searching_wise_products_provider.dart';
// import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
// import 'package:al_barakah_e_mart/screens/allProduct/new_all_product_page.dart';
// import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:provider/provider.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final searchCtrl = TextEditingController();
//   String? selectSearch;
//   String? slugging;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scaffoldColor,
//       body: FutureBuilder(
//         future: Provider.of<AllSearchingProductsProvider>(context).getAllSearchingProducts(),
//         builder: (context, snapshot) {
//           if(snapshot.connectionState == ConnectionState.waiting){
//             return const Center(child: CircularProgressIndicator(),);
//           }
//           else if(snapshot.hasData){
//             return Container(
//               padding: const EdgeInsets.only(left: 10, top: 40, right: 10),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen(),));
//                             //Navigator.pop(context);
//                           },
//                           child: const Icon(Icons.arrow_back),
//                         ),
//                       ),
//                       const SizedBox(
//                         width:15,
//                       ),
//                       Expanded(
//                       flex: 12,
//                       child: SizedBox(
//                         height: 35,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border.all(color: Colors.orange.shade700),
//                             color: Colors.white,
//                           ),
//                           child: TypeAheadField<AllProductModel>(
//                             controller: searchCtrl,
//                             builder: (context, controller, focusNode) {
//                               return TextField(
//                                 controller: controller,
//                                 focusNode: focusNode,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey.shade600,
//                                 ),
//                                 decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.only(top: 5, left: 10),
//                                   hintText: "Search Here...",
//                                   hintStyle: const TextStyle(fontSize: 14),
//                                   border: InputBorder.none,
//                                   isDense: true,
//                                   suffixIcon: selectSearch == ''
//                                       ? null
//                                       : GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               searchCtrl.clear();
//                                               controller.clear();
//                                               selectSearch = '';
//                                             });
//                                           },
//                                           child: const Padding(
//                                             padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
//                                             child: Icon(
//                                               Icons.close,
//                                               size: 14,
//                                             ),
//                                           ),
//                                         ),
//                                 ),
//                                 onChanged: (value) {
//                                   if (value == '') {
//                                     setState(() {
//                                       selectSearch = '';
//                                     });
//                                   }
//                                 },
//                                 onTap: () async {
//                                   // Optional: preload if needed
//                                 },
//                               );
//                             },
//                             suggestionsCallback: (pattern) {
//                               if (pattern.isEmpty) return [];

//                               return snapshot.data!
//                                   .where((element) => element.name
//                                       .toString()
//                                       .toLowerCase()
//                                       .contains(pattern.toLowerCase()))
//                                   .toList();
//                             },
//                             itemBuilder: (context, AllProductModel suggestion) {
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       height: 60.0,
//                                       width: 55,
//                                       child: CustomImage(path: "$BaseUrl${suggestion.image}"),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Expanded(
//                                       child: Text(
//                                         "${suggestion.name} ${suggestion.productCode}",
//                                         style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             onSelected: (AllProductModel suggestion) {
//                               slugging = suggestion.slug;
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => One_Product_Details(slug: suggestion.slug),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ),

//                       // Expanded(
//                       //   flex: 12,
//                       //   child: SizedBox(
//                       //     height: 35,
//                       //     child: TypeAheadFormField(

//                       //       textFieldConfiguration: TextFieldConfiguration(

//                       //           onChanged: (value) {
//                       //             if (value == '') {
//                       //               selectSearch = '';
//                       //             }
//                       //           },
//                       //           style: TextStyle(
//                       //             fontSize: 14,
//                       //             color: Colors.grey.shade600,
//                       //           ),
//                       //           controller: searchCtrl,
//                       //           decoration: InputDecoration(
//                       //             contentPadding: const EdgeInsets.only(bottom: 25,left: 10),
//                       //             hintText: "Search Here...",
//                       //             hintStyle: const TextStyle(fontSize: 14),
//                       //             fillColor: Colors.white,
//                       //             filled: true,
//                       //             border: OutlineInputBorder(
//                       //               borderRadius: BorderRadius.circular(50),
//                       //               borderSide:  BorderSide(color: Colors.orange.shade700),
//                       //             ),
//                       //             focusedBorder: OutlineInputBorder(
//                       //               borderRadius: BorderRadius.circular(50),
//                       //               borderSide:  BorderSide(color: Colors.orange.shade700),
//                       //             ),
//                       //             enabledBorder: OutlineInputBorder(
//                       //               borderRadius: BorderRadius.circular(50),
//                       //               borderSide:  BorderSide(color: Colors.orange.shade700),
//                       //             ),
//                       //             isDense: true,
//                       //             suffix: selectSearch == ''
//                       //                 ? null
//                       //                 : GestureDetector(
//                       //               onTap: () {
//                       //                 setState(() {
//                       //                   searchCtrl.text = '';
//                       //                 });
//                       //               },
//                       //               child: const Padding(
//                       //                 padding:
//                       //                 EdgeInsets.symmetric(horizontal: 13,vertical: 5),
//                       //                 child: Icon(
//                       //                   Icons.close,
//                       //                   size: 14,
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           )),
//                       //       suggestionsCallback: (pattern) {
//                       //         if(searchCtrl.text == '') {
//                       //           return snapshot.data!.where((element) => element.name.toString().toLowerCase().contains(pattern.toString().toLowerCase())).take(0).toList();
//                       //         }else{
//                       //           return snapshot.data!.where((element) => element.name.toString().toLowerCase().contains(pattern.toString().toLowerCase())).take(snapshot.data!.length).toList();
//                       //         }
//                       //       },
//                       //       itemBuilder: (context, suggestion) {
//                       //         return SingleChildScrollView(
//                       //           scrollDirection: Axis.horizontal,
//                       //           child: Padding(
//                       //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       //             child: Row(
//                       //               children: [
//                       //                 SizedBox(
//                       //                   height:60.0,width: 55,
//                       //                   child: CustomImage(path: "$BaseUrl${suggestion.image}")),
//                       //                 Text(
//                       //                   "${suggestion.name} ${suggestion.productCode}",
//                       //                   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                       //                   maxLines: 1,
//                       //                   overflow: TextOverflow.ellipsis,
//                       //                 ),
//                       //               ],
//                       //             ),
//                       //           ),
//                       //         );
//                       //       },
//                       //       transitionBuilder: (context, suggestionsBox, controller) {
//                       //         return suggestionsBox;
//                       //       },
//                       //       onSuggestionSelected: (AllProductModel suggestion) {
//                       //         //searchCtrl.text = suggestion.productName!;
//                       //         slugging = suggestion.slug;
//                       //         // setState(() {
//                       //         //   selectSearch = suggestion.productSlNo.toString();
//                       //         // });
//                       //         Navigator.pushReplacement(context,
//                       //           MaterialPageRoute(builder: (context) =>
//                       //                 One_Product_Details(slug: suggestion.slug),
//                       //           ),
//                       //         );
//                       //       },

//                       //       onSaved: (value) {},
//                       //     ),
                       
//                       //   ),
//                       // ),
                   
//                       const SizedBox(width: 15.0),
//                       Expanded(
//                         flex: 3,
//                         child: GestureDetector(
//                           onTap: () {
//                             Provider.of<SearchingWiseProductsProvider>(context, listen: false).getSearchingWiseProducts(searchCtrl.text);
//                             Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const NewAllProductPage()),
//                             );
//                           },
//                           child:  Text("Search",style: TextStyle(color: Colors.orange.shade700),),
//                         ),
//                       ),

//                     ],
//                   )
//                 ],
//               ),
//             );
//           }
//           else{
//             return const SizedBox();
//           }
//         },
//       ),
//     );
//   }
// }

