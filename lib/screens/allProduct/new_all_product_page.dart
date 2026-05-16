import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_provider/searching_wise_products_provider.dart';
import 'package:al_barakah_e_mart/footer_section/about_section.dart';
import 'package:al_barakah_e_mart/screens/search/search_screen.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../custom/custom_card/my_custom_card_screen.dart';
import '../One_Product_Details/product_details_screen.dart';

class NewAllProductPage extends StatefulWidget {
  const NewAllProductPage({super.key});

  @override
  State<NewAllProductPage> createState() => _NewAllProductPageState();
}

class _NewAllProductPageState extends State<NewAllProductPage> {

  int _visibleCount = 50;
  final int _loadStep = 50;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SearchingWiseProductsProvider.isSearchingWiseProductsloading = true;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMore();
      }
    });
  }

  void _loadMore() {
    final total = context.read<SearchingWiseProductsProvider>()
        .searchingWiseProductslist
        .length;

    if (_visibleCount < total) {
      setState(() {
        _visibleCount = (_visibleCount + _loadStep).clamp(0, total);
      });
    }
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
  Widget build(BuildContext context) {
    final allProductListData = Provider.of<SearchingWiseProductsProvider>(context).searchingWiseProductslist;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: scaffoldColor,
        foregroundColor: Colors.black,
        title: Text(
          "All Products",
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchScreen()));
          },
          child: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SearchingWiseProductsProvider.isSearchingWiseProductsloading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(
                      bottom: 60.h, left: 10.w, right: 10.w, top: 10.h),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 185,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 16,
                      mainAxisExtent: 270,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: _visibleCount > allProductListData.length
                          ? allProductListData.length
                          : _visibleCount,
                      (context, index) {
                        final product = allProductListData[index];
                        bool hasDiscount = checkHasDiscount(product.startDate, product.endDate);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      One_Product_Details(
                                        slug: product.slug,
                                        productId: product.productSlNo.toString(),
                              )),
                            );
                          },
                          child: MyCustomCardScreen(
                            quantity: "1",
                            image: "$imageUrl${product.mainImage}",
                            name: product.productName,
                            brandName: product.relationbrand?.brandName,
                            description: product.longDescription,
                            discountPrice: hasDiscount
                                ? product.onlineAfterDiscountAmount.toString()
                                : product.productOnlineRate.toString(),
                            sellingPrice: hasDiscount
                                ? product.productOnlineRate.toString()
                                : "",
                            productCode: product.productCode,
                            id: int.tryParse(product.productSlNo.toString()),
                            slug: product.slug,
                            stock: product.getCurrentStock(),
                            discount: hasDiscount ? product.onlineDiscount.toString(): "",
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: BigBuyFooter()),
              ],
            ),
    );
  }
}













// import 'package:al_barakah_e_mart/all_api_provider/searching_wise_products_provider.dart';
// import 'package:al_barakah_e_mart/footer_section/about_section.dart';
// import 'package:al_barakah_e_mart/screens/search/search_screen.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../custom/custom_card/my_custom_card_screen.dart';
// import '../One_Product_Details/product_details_screen.dart';

// class NewAllProductPage extends StatefulWidget {
//   const NewAllProductPage({super.key});
//   // final String productName;
//   // final List<ProductDataModel> productDataModel;
//   @override
//   State<NewAllProductPage> createState() => _NewAllProductPageState();
// }

// class _NewAllProductPageState extends State<NewAllProductPage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     SearchingWiseProductsProvider.isSearchingWiseProductsloading = true;

//   }
//   @override
//   Widget build(BuildContext context) {
//     final allProductListData=Provider.of<SearchingWiseProductsProvider>(context).searchingWiseProductslist;
//     print("searchWiseProduct lenght is=== ${allProductListData.length}");
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         // scrolledUnderElevation: 0,
//         backgroundColor: scaffoldColor,
//         foregroundColor: Colors.black,
//         title: const Text("All Products",
//           style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
//         leading: GestureDetector(onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen(
//           ),));
//          // Navigator.pop(context);
//         },child: const Icon(Icons.arrow_back_outlined)),
//       ),
//         body:SearchingWiseProductsProvider.isSearchingWiseProductsloading == true
//             ? const Center(child: CircularProgressIndicator())
//             : CustomScrollView(
//           slivers: [
//              SliverPadding(
//               padding: const EdgeInsets.only(bottom: 60, left: 10,right: 10,top: 10),
//               sliver: SliverGrid(
//                 gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 185,
//                   mainAxisSpacing: 24,
//                   crossAxisSpacing: 16,
//                   mainAxisExtent: 270,
//                 ),
//                 delegate: SliverChildBuilderDelegate(
//                   childCount: allProductListData.length,
//                       (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(
//                           slug: allProductListData[index].slug,
//                         ),));
//                       },
//                         child: MyCustomCardScreen(
//                           quantity: "1",
//                           image: "$BaseUrl${allProductListData[index].image}",
//                           name: allProductListData[index].name,
//                           description: allProductListData[index].description,
//                           discountPrice: allProductListData[index].discountPrice,
//                           productCode: allProductListData[index].productCode,
//                           id: allProductListData[index].id,
//                           slug: allProductListData[index].slug,
//                         )
//                       ///====old====
//                       // child: CustomCardPage(
//                       //   qty: "1",
//                       //   mainImage:"${BaseUrl}${allProductListData[index].image}" ,
//                       //   productName:allProductListData[index].name,
//                       //   productDescription:allProductListData[index].description ,
//                       //   salePrice: allProductListData[index].sellingPrice,
//                       //   productCode: allProductListData[index].productCode,
//                       //   productSlNo: "${allProductListData[index].id}",
//                       //   slug: allProductListData[index].slug,
//                       //   mainPrice: '',
//                       //   cashbackPercent: '',
//                       //   colorDataModel: [],
//                       //   sizeDataModel: [],
//                       // ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SliverToBoxAdapter(
//               child: BigBuyFooter(),
//             ),
//           ],
//         ),
//     );
//   }
// }
