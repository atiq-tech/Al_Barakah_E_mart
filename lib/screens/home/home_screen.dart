
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_provider/All_Top_Brand_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/all_searching_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/best_dealer_f_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/best_seller_f_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/brand_wise_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/categories_feature_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/device_offer_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/feature_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/gadget_offer_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_brands_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_slide_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/popular_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/products_details_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/resent_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/searching_wise_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/special_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/top_brands_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/top_rated_products_provider.dart';
import 'package:al_barakah_e_mart/custom/custom_card/my_custom_card_screen.dart';
import 'package:al_barakah_e_mart/custom/custom_section/custom_section_part.dart';
import 'package:al_barakah_e_mart/footer_section/about_section.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
import 'package:al_barakah_e_mart/screens/all_category/subCategoryProduct/sub_category_product.dart';
import 'package:al_barakah_e_mart/screens/brand_wise_product/brands_wise_allitems.dart';
import 'package:al_barakah_e_mart/screens/brand_wise_product/sub_brands_product.dart';
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
  String? authType = "";
  Future<void> _initializeData() async {
    userName = "${sharedPreferences.getString('name')}";
    customerId = "${sharedPreferences.getString('id')}";
    authType = "${sharedPreferences.getString('auth_type')}";

    print("auth_type=========$authType");
    print("User all Information   userName:$userName");

  }
  int selectIndex = 0;

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
 bool isDealer = true;
 bool isSeller = false;
 bool isGadget = true;
 bool isDevice = false;
 bool isAllTopBrandProduct = true;
 bool isTopBrandProduct = false;
  @override
  void initState() {
    _initializeData();
    SearchingWiseProductsProvider.isSearchingWiseProductsloading = true;
    Provider.of<SearchingWiseProductsProvider>(context,listen: false).getSearchingWiseProducts("");
    ///===new===
    Provider.of<GetSlidersProvider>(context, listen: false).getGetSliders();
    
    Provider.of<TopRatedProductsProvider>(context,listen: false).getTopRatedProducts();
    Provider.of<ResentProductProvider>(context,listen: false).getResentProduct();
    Provider.of<PopularProductsProvider>(context,listen: false).getPopularProducts();
    Provider.of<FeatureProductsProvider>(context,listen: false).getFeatureProducts();
    Provider.of<SpecialProductsProvider>(context,listen: false).getSpecialProducts();
    Provider.of<GetBrandsProvider>(context,listen: false).getGetBrands();
    Provider.of<TopBrandsProvider>(context,listen: false).getTopBrands();
    Provider.of<BrandWiseProductsProvider>(context,listen: false).getBrandWiseProducts("");

    // TODO: implement initState
    super.initState();
    Future.microtask(() {
    Provider.of<BestDealerFeatureProductsProvider>(context, listen: false).getBestDealerFeatureProducts();
    Provider.of<GadgetOfferProductProvider>(context, listen: false).getGadgetOfferProducts();
    Provider.of<AllTopBrandProductProvider>(context, listen: false).getAllTopBrandProducts();
    Provider.of<CategoriesFeatureProvider>(context,listen: false).getCategoriesFeature();
  });
  }
  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final allBrandsData = Provider.of<GetBrandsProvider>(context,listen: false).getBrandslist;
    final sliderImages = Provider.of<GetSlidersProvider>(context).getSliderslist;
    final allCategoriesFeaturelist = Provider.of<CategoriesFeatureProvider>(context).categoriesFeatureList;
    final allProductListData = Provider.of<SearchingWiseProductsProvider>(context).searchingWiseProductslist;
    final allTopBrandlist = Provider.of<TopBrandsProvider>(context).topBrandslist;
    print("allProductListData========      ${allProductListData.length}");
    print("sliderImages========      ${sliderImages.length}");
    print("allCategoriesFeaturelist========      ${allCategoriesFeaturelist.length}");
    print("allBrandsData========      ${allBrandsData.length}");
    print("allTopBrandlist========      ${allTopBrandlist.length}");

    const padding = EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 0);
    return RefreshIndicator(
      onRefresh: () => Provider.of<AllSearchingProductsProvider>(context,listen: false).getAllSearchingProducts(),
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers:[
          ///=====Img Slide=====
          SliverToBoxAdapter(
            child: SizedBox(
              // height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    CarouselSlider(
                      items: List.generate(sliderImages.length, (index) {
                        return SizedBox(
                          width: double.infinity,
                          child: CustomImage(
                            path: "${imageUrl}uploads/sliders/${sliderImages[index].image}",
                            fit: BoxFit.fill,
                          ),
                        );
                      }),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        enableInfiniteScroll: sliderImages.length > 1,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
                )
            ),
          ),
          ///=============Product Categories=========
          SliverPadding(
            padding: padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 5.0),
                        Divider(height: 1.0,thickness: 1.5,color: appBarColor),
                        const SizedBox(height: 2.0),
                        InkWell(
                          onTap:(){
                            MainController().naveListener.sink.add(1);
                          },
                          child: Column(
                            children: [
                              Text("Product Category",style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w700,color: appBarColor),
                              )),
                          ],),
                        ),
                        const SizedBox(height: 5.0),
                        Divider(height: 1.0,thickness: 1.5,color: appBarColor),
                        const SizedBox(height: 12.0),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: allCategoriesFeaturelist.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            mainAxisExtent: 120
                          ),
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryProduct(
                                    categoryName: allCategoriesFeaturelist[index].productCategoryName,
                                    categoryId: "${allCategoriesFeaturelist[index].productCategorySlNo}",
                                  ),));
                                },
                               child: Card(
                                elevation: 6,
                                child: Column(
                                  children: [
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.r),
                                        topRight: Radius.circular(10.r),
                                      ),
                                      child: SizedBox(
                                        height: 125.h,
                                        width: double.infinity,
                                        child: Image.network("https://soft.albarakahemart.com/uploads/category/fruit-69f8437482afe_69f8437482beb.jpg",
                                          //"$imageUrl${allCategoriesFeaturelist[index].image}",
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
                                              child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                    height: 75.h,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                                    decoration: BoxDecoration(
                                      color: appBarColor,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r),bottomRight: Radius.circular(10.r))
                                    ),
                                    child: Center(
                                     child: Text(
                                      allCategoriesFeaturelist[index].productCategoryName,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w500,
                                        color:Colors.white
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                     ),
                                     ),
                                    ),
                                  )
                                ],
                              ),
                              )
                                );
                          }),
                        )
                      ],
                    ),
                  ],
                );
              }, childCount: 1),
            ),
          ),
          ///===============TOP RATED============
          const SliverToBoxAdapter(
            child: Column(
              children: [
                Divider(height: 2.0,thickness: 2.0,color: Colors.black,endIndent: 130.0,indent: 130.0),
                SizedBox(height: 10.0),
                CustomSectionPart(firstPart: "Ready for Order"),
                SizedBox(height: 10.0),
                Divider(height: 2.0,thickness: 2.0,color: Colors.black,endIndent: 130.0,indent: 130.0),
                SizedBox(height: 15.0),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: CarouselSlider(
                items: List.generate(allProductListData.length, (index) {
                  final product = allProductListData[index];
                  bool hasDiscount = checkHasDiscount(product.startDate, product.endDate);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                         Provider.of<ProductsDetailsProvider>(context, listen: false).getProductsDetails(allProductListData[index].slug);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => One_Product_Details(
                            slug: allProductListData[index].slug,
                            productId: allProductListData[index].productSlNo.toString(),
                          ),
                        ),
                      );
                      },
                     child: authType == "reseller" ? MyCustomCardScreen(
                      quantity: "1",
                      image: "$imageUrl${product.mainImage}",
                      name: product.productName,
                      brandName: product.relationbrand?.brandName,
                      description: product.longDescription,
                      discountPrice: product.productWholesaleRate.toString(),
                      sellingPrice: product.productWholesaleRate.toString(),
                      productCode: product.productCode,
                      id: int.tryParse(product.productSlNo.toString()),
                      slug: product.slug,
                      stock: product.getCurrentStock(),
                      discount: "",
                    ) : MyCustomCardScreen(
                      quantity: "1",
                      image: "$imageUrl${product.mainImage}",
                      name: product.productName,
                      brandName: product.relationbrand?.brandName,
                      description: product.longDescription,
                      discountPrice: hasDiscount
                          ? product.onlineAfterDiscountAmount.toString()
                          : product.productOnlineRate.toString(),
                      sellingPrice: hasDiscount ? product.productOnlineRate.toString() : "",
                      productCode: product.productCode,
                      id: int.tryParse(product.productSlNo.toString()),
                      slug: product.slug,
                      stock: product.getCurrentStock(),
                      discount: hasDiscount ? product.onlineDiscount.toString() : "",
                    ),
                    ),
                  );
                }),
                options: CarouselOptions(
                  aspectRatio: 4/3,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  //enlargeCenterPage: true,
                  viewportFraction: 0.55,
                  initialPage: 1,
                  onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
          ///===============RESENT PRODRCT============
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Divider(height: 2, thickness: 2, color: Colors.green, endIndent: 100, indent: 100),
                const SizedBox(height: 10),
                const CustomSectionPart(firstPart: "Featured Products"),
                const SizedBox(height: 10),
                const Divider(height: 2, thickness: 2, color: Colors.green, endIndent: 100, indent: 100),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isDealer = true;
                          isSeller = false;
                        });

                        Provider.of<BestDealerFeatureProductsProvider>(context, listen: false)
                            .getBestDealerFeatureProducts();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDealer ? appBarColor : Colors.grey,
                      ),
                      child: const Text("Best Dealers", style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isSeller = true;
                          isDealer = false;
                        });

                        Provider.of<BestSellerFeatureProductsProvider>(context, listen: false)
                            .getBestSellerFeatureProducts();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSeller ? appBarColor : Colors.grey,
                      ),
                      child: const Text("Best Sellers", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
         isDealer
          ? Consumer<BestDealerFeatureProductsProvider>(
              builder: (context, dealerProvider, _) {
                if (dealerProvider.isLoading) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                final list = dealerProvider.bestDealerFeatureProductsList;

                if (list.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text("No Dealer Products")),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 270,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = list[index];
                        bool hasDiscount = checkHasDiscount(product.startDate, product.endDate);

                        return GestureDetector(
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
                          child: authType == "reseller" ? MyCustomCardScreen(
                            quantity: "1",
                            image: "$imageUrl${product.mainImage}",
                            name: product.productName,
                            brandName: product.relationbrand?.brandName,
                            description: product.longDescription,
                            discountPrice: product.productWholesaleRate.toString(),
                            sellingPrice: product.productWholesaleRate.toString(),
                            productCode: product.productCode,
                            id: int.tryParse(product.productSlNo.toString()),
                            slug: product.slug,
                            stock: product.getCurrentStock(),
                            discount: "",
                          ): MyCustomCardScreen(
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
                            discount: hasDiscount
                                ? product.onlineDiscount.toString()
                                : "",
                          ),
                        );
                      },
                      childCount: list.length > 12 ? 12 : list.length,
                    ),
                  ),
                );
              },
            )
          : Consumer<BestSellerFeatureProductsProvider>(
              builder: (context, sellerProvider, _) {
                if (sellerProvider.isLoading) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                final list = sellerProvider.bestSellerFeatureProductsList;

                if (list.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text("No Seller Products")),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 270,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = list[index];
                        bool hasDiscount =
                            checkHasDiscount(product.startDate, product.endDate);

                        return GestureDetector(
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
                          child: authType == "reseller" ? MyCustomCardScreen(
                            quantity: "1",
                            image: "$imageUrl${product.mainImage}",
                            name: product.productName,
                            brandName: product.relationbrand?.brandName,
                            description: product.longDescription,
                            discountPrice: product.productWholesaleRate.toString(),
                            sellingPrice: product.productWholesaleRate.toString(),
                            productCode: product.productCode,
                            id: int.tryParse(product.productSlNo.toString()),
                            slug: product.slug,
                            stock: product.getCurrentStock(),
                            discount: "",
                          ): MyCustomCardScreen(
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
                            discount: hasDiscount
                                ? product.onlineDiscount.toString()
                                : "",
                          ),
                        );
                      },
                      childCount: list.length > 12 ? 12 : list.length,
                    ),
                  ),
                );
              },
            ),
          ///===============RESENT PRODRCT============
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Divider(height: 2, thickness: 2, color: Colors.green, endIndent: 100, indent: 100),
                const SizedBox(height: 10),
                const CustomSectionPart(firstPart: "Offer Products"),
                const SizedBox(height: 10),
                const Divider(height: 2, thickness: 2, color: Colors.green, endIndent: 100, indent: 100),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isGadget = true;
                          isDevice = false;
                        });
                        Provider.of<GadgetOfferProductProvider>(context, listen: false).getGadgetOfferProducts();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isGadget ? appBarColor : Colors.grey,
                      ),
                      child: const Text("Gadgets", style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isDevice = true;
                          isGadget = false;
                        });
                        Provider.of<DeviceOfferProductProvider>(context, listen: false).getDeviceOfferProducts();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDevice ? appBarColor : Colors.grey,
                      ),
                      child: const Text("Devices", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
         isGadget
          ? Consumer<GadgetOfferProductProvider>(
              builder: (context, gadgetProvider, _) {
                if (gadgetProvider.isLoading) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                final list = gadgetProvider.gadgetOfferProductsList;

                if (list.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text("No Gadget Products")),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 270,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = list[index];
                        bool hasDiscount = checkHasDiscount(product.startDate, product.endDate);

                        return GestureDetector(
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
                          child: authType == "reseller" ? MyCustomCardScreen(
                            quantity: "1",
                            image: "$imageUrl${product.mainImage}",
                            name: product.productName,
                            brandName: product.relationbrand?.brandName,
                            description: product.longDescription,
                            discountPrice: product.productWholesaleRate.toString(),
                            sellingPrice: product.productWholesaleRate.toString(),
                            productCode: product.productCode,
                            id: int.tryParse(product.productSlNo.toString()),
                            slug: product.slug,
                            stock: product.getCurrentStock(),
                            discount: "",
                          ): MyCustomCardScreen(
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
                            discount: hasDiscount
                                ? product.onlineDiscount.toString()
                                : "",
                          ),
                        );
                      },
                      childCount: list.length > 12 ? 12 : list.length,
                    ),
                  ),
                );
              },
            )
          : Consumer<DeviceOfferProductProvider>(
              builder: (context, deviceProvider, _) {
                if (deviceProvider.isLoading) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                final list = deviceProvider.deviceOfferProductsList;

                if (list.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(child: Text("No Device Products")),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 270,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = list[index];
                        bool hasDiscount = checkHasDiscount(product.startDate, product.endDate);

                        return GestureDetector(
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
                          child: authType == "reseller" ? MyCustomCardScreen(
                            quantity: "1",
                            image: "$imageUrl${product.mainImage}",
                            name: product.productName,
                            brandName: product.relationbrand?.brandName,
                            description: product.longDescription,
                            discountPrice: product.productWholesaleRate.toString(),
                            sellingPrice: product.productWholesaleRate.toString(),
                            productCode: product.productCode,
                            id: int.tryParse(product.productSlNo.toString()),
                            slug: product.slug,
                            stock: product.getCurrentStock(),
                            discount: "",
                          ): MyCustomCardScreen(
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
                            discount: hasDiscount
                                ? product.onlineDiscount.toString()
                                : "",
                          ),
                        );
                      },
                      childCount: list.length > 12 ? 12 : list.length,
                    ),
                  ),
                );
              },
            ),
          /// ===== Top Brand Filter + Header =====
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Divider(height: 2.0, thickness: 2.0, color: Colors.black, endIndent: 100.0, indent: 100.0),
                const SizedBox(height: 10.0),
                const CustomSectionPart(firstPart: "Top Brand Products"),
                const SizedBox(height: 10.0),
                const Divider(height: 2.0, thickness: 2.0, color: Colors.black, endIndent: 100.0, indent: 100.0),
                const SizedBox(height: 15.0),

                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allTopBrandlist.length + 1,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isAllTopBrandProduct = true;
                              isTopBrandProduct = false;
                            });
                            Provider.of<AllTopBrandProductProvider>(context, listen: false)
                                .getAllTopBrandProducts();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text("All"),
                          ),
                        );
                      }

                      final brand = allTopBrandlist[index - 1];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isAllTopBrandProduct = false;
                            isTopBrandProduct = true;
                          });
                          Provider.of<BrandWiseProductsProvider>(context,listen: false).getBrandWiseProducts("${brand.brandSiNo}");
                          print("Brand ID is===> ${brand.brandSiNo}");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(brand.brandName),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          /// ===== Products Area (SLIVER) =====
          isAllTopBrandProduct
          ? Consumer<AllTopBrandProductProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                final list = provider.allTopBrandProductsList;

                if (list.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Center(child: Text("No Product Found",style: TextStyle(color: Colors.red))),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 270,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = list[index];
                        bool hasDiscount =
                            checkHasDiscount(product.startDate, product.endDate);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    One_Product_Details(slug: product.slug,
                                        productId: product.productSlNo.toString())
                              ),
                            );
                          },
                          child: authType == "reseller" ? MyCustomCardScreen(
                            quantity: "1",
                            image: "$imageUrl${product.mainImage}",
                            name: product.productName,
                            brandName: product.relationbrand?.brandName,
                            description: product.longDescription,
                            discountPrice: product.productWholesaleRate.toString(),
                            sellingPrice: product.productWholesaleRate.toString(),
                            productCode: product.productCode,
                            id: int.tryParse(product.productSlNo.toString()),
                            slug: product.slug,
                            stock: product.getCurrentStock(),
                            discount: "",
                          ): MyCustomCardScreen(
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
                            discount: hasDiscount
                                ? product.onlineDiscount.toString()
                                : "",
                          ),
                        );
                      },
                      childCount: list.length > 12 ? 12 : list.length,
                    ),
                  ),
                );
              },
            )
          : isTopBrandProduct
          ? Consumer<BrandWiseProductsProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                final list = provider.brandWiseProductlist;

                if (list.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Center(child: Text("No Product Found",style: TextStyle(color: Colors.red))),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 270,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = list[index];
                        bool hasDiscount =
                            checkHasDiscount(product.startDate, product.endDate);

                        return GestureDetector(
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
                          child: authType == "reseller" ? MyCustomCardScreen(
                            quantity: "1",
                            image: "$imageUrl${product.mainImage}",
                            name: product.productName,
                            brandName: product.relationbrand?.brandName,
                            description: product.longDescription,
                            discountPrice: product.productWholesaleRate.toString(),
                            sellingPrice: product.productWholesaleRate.toString(),
                            productCode: product.productCode,
                            id: int.tryParse(product.productSlNo.toString()),
                            slug: product.slug,
                            stock: product.getCurrentStock(),
                            discount: "",
                          ): MyCustomCardScreen(
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
                            discount: hasDiscount
                                ? product.onlineDiscount.toString()
                                : "",
                          ),
                        );
                      },
                      childCount: list.length > 12 ? 12 : list.length,
                    ),
                  ),
                );
              },
            )
          : const SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Center(child: Text("No Product Found",style: TextStyle(color: Colors.red))),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ///===============Brands============
          SliverToBoxAdapter(
            child: Padding(
              padding:  const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
              child: Column(
                children: [
                  const Divider(color: Colors.black26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Shop By Brands",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.w600,fontSize: 18)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BrandsWiseAllItemsScreen(),
                          ));
                         },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: appbuttonColor, width: 1.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("All Brands",style: TextStyle(color: appBarColor,fontWeight: FontWeight.w600,fontSize: 12)),
                          )),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black26),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    height: 70.h,
                      width: double.infinity,
                      child: CarouselSlider(
                        items: List.generate(allBrandsData.length, (index) {
                          return SingleChildScrollView(
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<BrandWiseProductsProvider>(context,listen: false).getBrandWiseProducts("${allBrandsData[index].brandSiNo}");
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SubBrandsProduct(
                                  brandsName: allBrandsData[index].brandName,
                                  brandsId: "${allBrandsData[index].brandSiNo}",
                                ),));
                              },
                              child: SizedBox(
                                width: 70.0,
                                child: CustomImage(
                                  path: "${imageUrl}/uploads/brand/${allBrandsData[index].image}",
                                  fit: BoxFit.fill,
                                ),
                                //child: allBrandsData[index].image == '0' ? const CustomImage(path: "images/default-placeholder.png") : Image.network("${imageUrl}uploads/brand/${allBrandsData[index].image}",fit: BoxFit.fitHeight)
                              ),
                            ),
                          );
                        }),
                        options: CarouselOptions(
                          autoPlay: true,
                          //enlargeCenterPage: true,
                          viewportFraction: 0.22,
                          initialPage: 1,
                          onPageChanged: callbackFunction,
                         scrollDirection: Axis.horizontal,
                        ),
                      )
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          ///==========Footer Area=========
          const SliverToBoxAdapter(
            child: BigBuyFooter(),
          ),
        ],
      ),
    );
  }
}
