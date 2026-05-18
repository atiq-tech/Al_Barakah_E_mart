import 'package:al_barakah_e_mart/all_api_provider/brand_wise_products_provider.dart';
import 'package:al_barakah_e_mart/custom/custom_card/my_custom_card_screen.dart';
import 'package:al_barakah_e_mart/footer_section/about_section.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SubBrandsProduct extends StatefulWidget {
  const SubBrandsProduct({Key? key, required this.brandsId, this.brandsName})
      : super(key: key);

  final String? brandsId;
  final String? brandsName;

  @override
  State<SubBrandsProduct> createState() => _SubBrandsProductState();
}

class _SubBrandsProductState extends State<SubBrandsProduct> {
  String? userName = "";
  String? customerId = "";
  String? authType = "";
  Future<void> _initializeData() async {
    userName = "${sharedPreferences.getString('name')}";
    customerId = "${sharedPreferences.getString('id')}";
    authType = "${sharedPreferences.getString('auth_type')}";

    print("auth_type=========$authType");
    print("User all Information   userName:$userName");

  }
  bool checkHasDiscount(dynamic startDateStr, dynamic endDateStr) {
    if (startDateStr == null || endDateStr == null) return false;

    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);

    DateTime start = DateTime.parse(startDateStr.toString());
    DateTime end = DateTime.parse(endDateStr.toString());

    DateTime startDate = DateTime(start.year, start.month, start.day);
    DateTime endDate = DateTime(end.year, end.month, end.day);

    return (currentDate.isAtSameMomentAs(startDate) || currentDate.isAfter(startDate)) &&
        (currentDate.isAtSameMomentAs(endDate) || currentDate.isBefore(endDate));
  } 
  @override
  void initState() {
    _initializeData();
    super.initState();
    Future.microtask(() {
      Provider.of<BrandWiseProductsProvider>(context, listen: false)
          .getBrandWiseProducts(widget.brandsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 25, color: Colors.black87),
        ),
        title: Text(
          "${widget.brandsName} Products",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      /// ===== BODY =====
      body: Consumer<BrandWiseProductsProvider>(
        builder: (context, provider, _) {
          /// ===== LOADING =====
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final list = provider.brandWiseProductlist;

          /// ===== EMPTY =====
          if (list.isEmpty) {
            return Center(
              child: Text(
                "Product not found",
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          /// ===== GRID =====
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 16,
                    crossAxisSpacing:
                        MediaQuery.of(context).size.width * 0.04,
                    mainAxisExtent: 275,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = list[index];
                     // bool hasDiscount = checkHasDiscount(product.startDate, product.endDate);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  One_Product_Details(slug: product.slug,
                                      productId: product.productSlNo.toString()),
                            ),
                          );
                        },
                        // child: authType == "reseller" ? MyCustomCardScreen(
                        //     quantity: "1",
                        //     image: "$imageUrl${product.mainImage}",
                        //     name: product.productName,
                        //     brandName: product.relationbrand?.brandName,
                        //     description: product.longDescription,
                        //     discountPrice: product.productWholesaleRate.toString(),
                        //     sellingPrice: product.productWholesaleRate.toString(),
                        //     productCode: product.productCode,
                        //     id: int.tryParse(product.productSlNo.toString()),
                        //     slug: product.slug,
                        //     stock: product.getCurrentStock(),
                        //     discount: "",
                        //   ): MyCustomCardScreen(
                        //     quantity: "1",
                        //     image: "$imageUrl${product.mainImage}",
                        //     name: product.productName,
                        //     brandName: product.relationbrand?.brandName,
                        //     description: product.longDescription,
                        //     discountPrice: hasDiscount
                        //         ? product.onlineAfterDiscountAmount.toString()
                        //         : product.productOnlineRate.toString(),
                        //     sellingPrice: hasDiscount
                        //         ? product.productOnlineRate.toString()
                        //         : "",
                        //     productCode: product.productCode,
                        //     id: int.tryParse(product.productSlNo.toString()),
                        //     slug: product.slug,
                        //     stock: product.getCurrentStock(),
                        //     discount: hasDiscount ? product.onlineDiscount.toString(): "",
                        //   ),
                      );
                    },
                    childCount: list.length,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: BigBuyFooter()),
            ],
          );
        },
      ),
    );
  }
}







// import 'package:al_barakah_e_mart/all_api_provider/brand_wise_products.dart';
// import 'package:al_barakah_e_mart/custom/custom_card/my_custom_card_screen.dart';
// import 'package:al_barakah_e_mart/footer_section/about_section.dart';
// import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class SubBrandsProduct extends StatefulWidget {
//   const SubBrandsProduct({Key? key, required this.brandsId, this.brandsName}): super(key: key);
//   final String? brandsId;
//   final String? brandsName;
//   @override
//   State<SubBrandsProduct> createState() => _SubBrandsProductState();
// }

// class _SubBrandsProductState extends State<SubBrandsProduct> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // SubcategoryProvider.isLoading = true;
//     // Provider.of<SubcategoryProvider>(context,listen: false).brandList = [];
//     BrandWiseProductsProvider.isBrandWiseProductsLoading = true;
//     Provider.of<BrandWiseProductsProvider>(context,listen: false).brandWiseProductlist = [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     //final All_Sub_Category_ProductList = Provider.of<All_SubCategory_Product_Provider>(context);
//     //final subCategoryProductList = Provider.of<SubcategoryProvider>(context).brandList;
//    // final subBrandsProductList = Provider.of<GetBrandWiseProvider>(context).dataList;
//     final allBrandWiseProductsData = Provider.of<BrandWiseProductsProvider>(context).brandWiseProductlist;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: scaffoldColor,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             size: 25,
//             color: Colors.black87,
//           ),
//         ),
//         title: Text(
//           "${widget.brandsName} Products",
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontStyle: FontStyle.italic,
//             letterSpacing: 1,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: BrandWiseProductsProvider.isBrandWiseProductsLoading == true
//               ? const Center(child: CircularProgressIndicator(),)
//             : allBrandWiseProductsData.isNotEmpty
//               ? CustomScrollView(
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                   bottom: 10,
//                   left: 10,
//                   right: 10,
//                 ),
//                 sliver: SliverGrid(
//                   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 300,
//                     mainAxisSpacing: 16,
//                     crossAxisSpacing: MediaQuery.of(context).size.width * 0.04,
//                     mainAxisExtent: 275,
//                   ),
//                   delegate: SliverChildBuilderDelegate((context, index) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => One_Product_Details(
//                                 slug: allBrandWiseProductsData[index].slug),
//                             ));
//                       },
//                         child: MyCustomCardScreen(
//                           quantity: "1",
//                           image: "$BaseUrl${allBrandWiseProductsData[index].mainImage}",
//                           name: allBrandWiseProductsData[index].productName,
//                           description: allBrandWiseProductsData[index].longDescription,
//                           discountPrice: allBrandWiseProductsData[index].onlineDiscount,
//                           productCode: allBrandWiseProductsData[index].productCode,
//                           id: allBrandWiseProductsData[index].productSlNo,
//                           slug: allBrandWiseProductsData[index].slug,
//                         )
//                       ///===old===
//                       // child: CustomCardPage(
//                       //   qty: "1",
//                       //   mainImage: "${BaseUrl}${allBrandWiseProductsData[index].image}",
//                       //   productName: allBrandWiseProductsData[index].name,
//                       //   productDescription: allBrandWiseProductsData[index].description,
//                       //   salePrice: allBrandWiseProductsData[index].sellingPrice,
//                       //   productCode: allBrandWiseProductsData[index].productCode,
//                       //   productSlNo: "${allBrandWiseProductsData[index].id}",
//                       //   slug: allBrandWiseProductsData[index].slug,
//                       //   mainPrice: '',
//                       //   cashbackPercent: '',
//                       //   colorDataModel: [],
//                       //   sizeDataModel: [],
//                       // ),
//                     );
//                   }, childCount: allBrandWiseProductsData.length),
//                 ),
//               ),
//               const SliverToBoxAdapter(child: BigBuyFooter()),
//             ],
//           ): Center(child: Text("Product not found",style: TextStyle(
//               color: Colors.red.shade600, fontSize: 16,fontWeight: FontWeight.bold
//           ),),)
//       ),
//     );
//   }
// }
















// import 'package:al_barakah_e_mart/all_api_provider/brand_wise_products.dart';
// import 'package:al_barakah_e_mart/custom/custom_card/my_custom_card_screen.dart';
// import 'package:al_barakah_e_mart/footer_section/about_section.dart';
// import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class SubBrandsProduct extends StatefulWidget {
//   const SubBrandsProduct({Key? key, required this.brandsId, this.brandsName})
//       : super(key: key);
//   final String? brandsId;
//   final String? brandsName;
//   @override
//   State<SubBrandsProduct> createState() => _SubBrandsProductState();
// }

// class _SubBrandsProductState extends State<SubBrandsProduct> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // SubcategoryProvider.isLoading = true;
//     // Provider.of<SubcategoryProvider>(context,listen: false).brandList = [];
//     BrandWiseProductsProvider.isBrandWiseProductsLoading = true;
//     Provider.of<BrandWiseProductsProvider>(context,listen: false).brandWiseProductlist = [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     //final All_Sub_Category_ProductList = Provider.of<All_SubCategory_Product_Provider>(context);
//     //final subCategoryProductList = Provider.of<SubcategoryProvider>(context).brandList;
//    // final subBrandsProductList = Provider.of<GetBrandWiseProvider>(context).dataList;
//     final allBrandWiseProductsData = Provider.of<BrandWiseProductsProvider>(context).brandWiseProductlist;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: scaffoldColor,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             size: 25,
//             color: Colors.black87,
//           ),
//         ),
//         title: Text(
//           "${widget.brandsName} Products",
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontStyle: FontStyle.italic,
//             letterSpacing: 1,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: BrandWiseProductsProvider.isBrandWiseProductsLoading == true
//               ? const Center(child: CircularProgressIndicator(),)
//             : allBrandWiseProductsData.isNotEmpty
//               ? CustomScrollView(
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.only(
//                   top: 10,
//                   bottom: 10,
//                   left: 10,
//                   right: 10,
//                 ),
//                 sliver: SliverGrid(
//                   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 300,
//                     mainAxisSpacing: 16,
//                     crossAxisSpacing: MediaQuery.of(context).size.width * 0.04,
//                     mainAxisExtent: 275,
//                   ),
//                   delegate: SliverChildBuilderDelegate((context, index) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => One_Product_Details(
//                                 slug: allBrandWiseProductsData[index].slug),
//                             ));
//                       },
//                         child: MyCustomCardScreen(
//                           quantity: "1",
//                           image: "$BaseUrl${allBrandWiseProductsData[index].image}",
//                           name: allBrandWiseProductsData[index].name,
//                           description: allBrandWiseProductsData[index].description,
//                           discountPrice: allBrandWiseProductsData[index].discountPrice,
//                           productCode: allBrandWiseProductsData[index].productCode,
//                           id: allBrandWiseProductsData[index].id,
//                           slug: allBrandWiseProductsData[index].slug,
//                         )
//                       ///===old===
//                       // child: CustomCardPage(
//                       //   qty: "1",
//                       //   mainImage: "${BaseUrl}${allBrandWiseProductsData[index].image}",
//                       //   productName: allBrandWiseProductsData[index].name,
//                       //   productDescription: allBrandWiseProductsData[index].description,
//                       //   salePrice: allBrandWiseProductsData[index].sellingPrice,
//                       //   productCode: allBrandWiseProductsData[index].productCode,
//                       //   productSlNo: "${allBrandWiseProductsData[index].id}",
//                       //   slug: allBrandWiseProductsData[index].slug,
//                       //   mainPrice: '',
//                       //   cashbackPercent: '',
//                       //   colorDataModel: [],
//                       //   sizeDataModel: [],
//                       // ),
//                     );
//                   }, childCount: allBrandWiseProductsData.length),
//                 ),
//               ),
//               const SliverToBoxAdapter(child: BigBuyFooter()),
//             ],
//           ): Center(child: Text("Product not found",style: TextStyle(
//               color: Colors.red.shade600, fontSize: 16,fontWeight: FontWeight.bold
//           ),),)
//       ),
//     );
//   }
// }
