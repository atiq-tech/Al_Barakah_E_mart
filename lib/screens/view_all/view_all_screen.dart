import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_provider/all_products_provider.dart';
import 'package:al_barakah_e_mart/custom/custom_card/my_custom_card_screen.dart';
import 'package:al_barakah_e_mart/footer_section/about_section.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import '../One_Product_Details/product_details_screen.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  int _visibleCount = 50;
  final int _loadStep = 50;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
    // ১. স্ক্রিন ওপেন হওয়ার সাথে সাথে ডাটা ফেচ করার জন্য কল করা হলো
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AllProductsProvider>().getAllProducts();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMore();
      }
    });
  }

  void _loadMore() {
    final provider = context.read<AllProductsProvider>();
    final total = provider.allProductslist.length;

    if (_visibleCount < total) {
      setState(() {
        _visibleCount = (_visibleCount + _loadStep).clamp(0, total);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ২. প্রোভাইডারকে লিসেন করা হচ্ছে
    final provider = Provider.of<AllProductsProvider>(context);
    final allProductListData = provider.allProductslist;
    final isLoading = provider.isProductsLoading;

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
            Navigator.pop(context); // সাধারণত ব্যাক বাটনে পপ হয়, আপনি চাইলে সার্চেও পাঠাতে পারেন
          },
          child: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // ৩. লোডিং দেখাচ্ছে কিনা চেক
          : allProductListData.isEmpty 
              ? Center(child: Text("No products found",style: AllTextStyle.nofoundTextStyle)) // ডাটা না থাকলে মেসেজ
              : CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w, top: 10.h),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                image: "$imageUrl${product.thumImage}",
                                name: product.productName,
                                description: product.productDescription,
                                discountPrice: product.productWholesaleRate.toString(),
                                sellingPrice: product.productWholesaleRate.toString(),
                                productCode: product.productCode,
                                id: int.tryParse(product.productSlNo.toString()),
                                slug: product.slug,
                                stock: product.stock,
                                discount: "",
                              )
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