
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/child_categories_provider.dart';
import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_individual_products.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';

class SubCategoryProduct extends StatefulWidget {
  const SubCategoryProduct({
    Key? key,
    required this.categoryId,
    this.categoryName,
  }) : super(key: key);

  final String? categoryId;
  final String? categoryName;

  @override
  State<SubCategoryProduct> createState() => _SubCategoryProductState();
}

class _SubCategoryProductState extends State<SubCategoryProduct> {

  @override
  void initState() {
     print("wwwwwwwwwwww categoryId==${widget.categoryId}");
    super.initState();
    ChildCategoriesProvider.isChildCategoriesLoading = true;

    Provider.of<ChildCategoriesProvider>(context, listen: false)
        .getChildCategories(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, size: 25.r, color: Colors.black87),
        ),
        title: Text(
          "${widget.categoryName}",
          style: AllTextStyle.getTitleTextStyle(),
        ),
      ),

      body: Consumer<ChildCategoriesProvider>(
        builder: (context, provider, _) {

          /// ===== LOADING =====
          if (ChildCategoriesProvider.isChildCategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final model = provider.childCategoriesModel;

          /// ===== EMPTY =====
          if (model == null || model.children.isEmpty) {
            return Center(
              child: Text(
                "No Sub Categories Found",
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final children = model.children;

          /// ===== GRID =====
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: children.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              mainAxisExtent: 130,
            ),
            itemBuilder: (context, index) {

              final item = children[index];
              final imagePath = item.image;

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryIndividualProducts(
                    categoryName: item.productCategoryName,
                    categoryId: "${item.productCategorySlNo}",
                  )));
                },
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: [

                      /// IMAGE
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8.r),
                          ),
                          child: imagePath != null && imagePath.toString().isNotEmpty
                              ? Image.network(
                                  "${imageUrl}$imagePath",
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                  errorBuilder: (_, __, ___) =>
                                      _noImage(),
                                )
                              : _noImage(),
                        ),
                      ),

                      /// NAME
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Center(
                            child: Text(
                              item.productCategoryName ?? "",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
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
          );
        },
      ),
    );
  }

  Widget _noImage() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined,
            size: 40, color: Colors.grey),
      ),
    );
  }
}

















// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:al_barakah_e_mart/all_api_provider/child_categories_provider.dart';
// import 'package:al_barakah_e_mart/all_api_provider/parent_cate_product_provider.dart';
// import 'package:al_barakah_e_mart/footer_section/about_section.dart';
// import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
// import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_individual_products.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../custom/custom_card/my_custom_card_screen.dart';

// class SubCategoryProduct extends StatefulWidget {
//   const SubCategoryProduct({Key? key, required this.categoryId, this.categoryName}) : super(key: key);
//   final String? categoryId;
//   final String? categoryName;
//   @override
//   State<SubCategoryProduct> createState() => _SubCategoryProductState();
// }

// class _SubCategoryProductState extends State<SubCategoryProduct> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ///====new======
//     ChildCategoriesProvider.isChildCategoriesLoading = true;
//     Provider.of<ChildCategoriesProvider>(context,listen: false).getChildCategories(widget.categoryId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final allChildCateProductData = Provider.of<ChildCategoriesProvider>(context).childCategoriesModel;
//     print("allChildCateProductData==categories==${allChildCateProductData == null ? "" : allChildCateProductData.categories.length}");
//     print("allChildCateProductData==products==${allChildCateProductData == null ? "" : allChildCateProductData.products.length}");
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: scaffoldColor,
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back,size: 25.r,color: Colors.black87),
//         ),
//         title: Text("${widget.categoryName}",style: AllTextStyle.getTitleTextStyle()),
//       ),
//       body: SizedBox(
//         height: double.infinity,
//         width: double.infinity,
//         child: ChildCategoriesProvider.isChildCategoriesLoading == true ? const Center(child: CircularProgressIndicator(),)
//               :allChildCateProductData!.products.isNotEmpty || allChildCateProductData.categories.isNotEmpty
//               ? CustomScrollView(
//               slivers: [
//             SliverPadding(
//                   padding: EdgeInsets.only(top: 5.h,left: 10.w,right: 10.w),
//                   sliver: SliverList(
//                     delegate: SliverChildBuilderDelegate((context, index) {
//                       return Column(
//                         children: [
//                           Column(
//                             children: [
//                               GridView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: allChildCateProductData.categories.length,
//                                 scrollDirection: Axis.vertical,
//                                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     crossAxisSpacing: 10.0,
//                                     mainAxisSpacing: 10.0
//                                 ),
//                                 itemBuilder: ((context, index) {
//                                   return GestureDetector(
//                                       onTap: () {
//                                         Provider.of<ParentCateProductProvider>(context,listen: false).getParentCateProduct("${allChildCateProductData.categories[index].id}");
//                                         Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryIndividualProducts(
//                                           categoryName: allChildCateProductData.categories[index].name,
//                                           categoryId: "${allChildCateProductData.categories[index].id}",
//                                         ),));
//                                       },
//                                       child: Container(
//                                         child: Column(
//                                           children: [
//                                             Expanded(
//                                               flex:1,
//                                               child: Container(
//                                                 padding: EdgeInsets.all(3.r),
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(color: Colors.grey.shade400,width: 1.3.w),
//                                                   borderRadius: BorderRadius.circular(5.r),
//                                                   color: Colors.white
//                                                 ),
//                                                 child: CustomImage(path: "$BaseUrl${allChildCateProductData.categories[index].image}",fit: BoxFit.fill),
//                                               ),
//                                             ),
//                                             Text(allChildCateProductData.categories[index].name,
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 15.sp,
//                                                     ),
//                                               overflow: TextOverflow.ellipsis,
//                                               ),
//                                             Text("${allChildCateProductData.categories[index].productsCount} Products",
//                                                 style: TextStyle(
//                                                     color: Colors.blueGrey.shade700,
//                                                     fontWeight: FontWeight.w400,
//                                                     fontSize: 12.sp,
//                                                    ),
//                                               ),
//                                           ],
//                                         ),
//                                       ));
//                                 }),
//                               )
//                             ],
//                           ),
//                          SizedBox(height: 10.h),
//                          Divider(height: 2.h,thickness: 1.5.h),
//                         ],
//                       );
//                     }, childCount: 1),
//                   ),
//                 ),
//                 SliverPadding(
//                   padding: EdgeInsets.only(bottom: 20.h, left: 10.w,right: 10.r,top: 15.h),
//                   sliver: SliverGrid(
//                     gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
//                       maxCrossAxisExtent: 185,
//                       mainAxisSpacing: 10.0,
//                       crossAxisSpacing: 10.0,
//                       mainAxisExtent: 270,
//                     ),
//                     delegate: SliverChildBuilderDelegate(
//                       childCount: allChildCateProductData.products.length,
//                           (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(
//                               slug: allChildCateProductData.products[index].slug,
//                             )));
//                           },
//                             child: MyCustomCardScreen(
//                               quantity: "1",
//                               image: "$BaseUrl${allChildCateProductData.products[index].image}",
//                               name: allChildCateProductData.products[index].name,
//                               description: allChildCateProductData.products[index].description,
//                               discountPrice: allChildCateProductData.products[index].discountPrice,
//                               productCode: allChildCateProductData.products[index].productCode,
//                               id: allChildCateProductData.products[index].id,
//                               slug: allChildCateProductData.products[index].slug,
//                             )
//                         );
//                       },
//                     ),
//                   ) ),
//             const SliverToBoxAdapter(child: BigBuyFooter()),
//           ],
//         ) : Center(child: Text("Product not found",style: AllTextStyle.nofoundTextStyle))
//       ),
//     );
//   }
// }
