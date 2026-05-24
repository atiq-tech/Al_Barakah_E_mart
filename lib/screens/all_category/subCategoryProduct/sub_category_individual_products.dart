
import 'package:al_barakah_e_mart/custom/custom_card/my_custom_card_screen.dart';
import 'package:al_barakah_e_mart/utils/what_up_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_provider/parent_cate_product_provider.dart';
import 'package:al_barakah_e_mart/footer_section/about_section.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubCategoryIndividualProducts extends StatefulWidget {
  const SubCategoryIndividualProducts({Key? key, required this.categoryId, this.categoryName}) : super(key: key);
  final String? categoryId;
  final String? categoryName;
  @override
  State<SubCategoryIndividualProducts> createState() => _SubCategoryIndividualProductsState();
}

class _SubCategoryIndividualProductsState extends State<SubCategoryIndividualProducts> {

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
      floatingActionButton: const CustomContactFAB(),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ParentCateProductProvider.isParentCateProductLoading == true
              ? const Center(child: CircularProgressIndicator())
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
                        child: MyCustomCardScreen(
                          quantity: "1",
                          image: "$imageUrl${product.productImage}",
                          name: product.productName,
                          description: product.productDescription,
                          discountPrice: product.productSellingPrice.toString(),
                          sellingPrice: product.productSellingPrice.toString(),
                          productCode:
                          product.productCode,
                          id: int.tryParse(product.productSlNo.toString()),
                          slug: product.slug,
                          stock: product.stock,
                          discount: "",
                        ),
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
