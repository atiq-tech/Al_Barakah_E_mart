
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_provider/parent_cate_product_provider.dart';
import 'package:al_barakah_e_mart/footer_section/about_section.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../custom/custom_card/my_custom_card_screen.dart';

class SubCategoryIndividualProducts extends StatefulWidget {
  const SubCategoryIndividualProducts({Key? key, required this.categoryId, this.categoryName}) : super(key: key);
  final String? categoryId;
  final String? categoryName;
  @override
  State<SubCategoryIndividualProducts> createState() => _SubCategoryIndividualProductsState();
}

class _SubCategoryIndividualProductsState extends State<SubCategoryIndividualProducts> {

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

  @override
  void initState() {
    _initializeData();
    // TODO: implement initState
    super.initState();
    ParentCateProductProvider.isParentCateProductLoading = true;
    Provider.of<ParentCateProductProvider>(context,listen: false).getParentCateProduct(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final allParentCateProductData = Provider.of<ParentCateProductProvider>(context).parentCateProductlist;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,size: 25.r,color: Colors.black87),
        ),
        title: Text("${widget.categoryName}",style: AllTextStyle.getTitleTextStyle()),
      ),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ParentCateProductProvider.isParentCateProductLoading == true
              ? const Center(child: CircularProgressIndicator(),)
              : allParentCateProductData.isNotEmpty
              ? CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(10.r),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: MediaQuery.of(context).size.width * 0.04,
                    mainAxisExtent: 275,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = allParentCateProductData[index];
                        //bool hasDiscount = checkHasDiscount(product.startDate, product.endDate);
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(
                            builder: (context) => One_Product_Details(
                                slug: allParentCateProductData[index].slug,
                                productId: allParentCateProductData[index].productSlNo.toString(),
                                ),
                        ));
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
                  }, childCount: allParentCateProductData.length),
                ),
              ),
              const SliverToBoxAdapter(child: BigBuyFooter()),
            ],
          ) : Center(child: Text("Product not found",style: AllTextStyle.nofoundTextStyle))
      ),
    );
  }
}
