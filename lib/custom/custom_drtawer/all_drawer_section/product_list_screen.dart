import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/all_products_provider.dart';
import 'package:al_barakah_e_mart/screens/one_product_details/product_details_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  TextEditingController searchController = TextEditingController();

  List filteredList = [];
  List displayList = [];

  int currentPage = 1;
  final int perPage = 50;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final provider = Provider.of<AllProductsProvider>(context, listen: false);
      await provider.getAllProducts();
      filteredList = provider.allProductslist;
      loadInitialData();
    });
  }

  /// 🔥 Initial Load
  void loadInitialData() {
    setState(() {
      currentPage = 1;
      displayList = filteredList.take(perPage).toList();
    });
  }
 bool isLoadMoreLoading = false;
  void loadMoreData() async {
  setState(() {
    isLoadMoreLoading = true; // 🔥 loading start
  });

  await Future.delayed(const Duration(milliseconds: 800)); // fake delay (UI এর জন্য)

  final nextItems = filteredList.skip(currentPage * perPage).take(perPage).toList();
  setState(() {
    currentPage++;
    displayList.addAll(nextItems);
    isLoadMoreLoading = false; // 🔥 loading stop
  });
}

  /// 🔍 Search
  void filterProducts(String query) {
    final provider = Provider.of<AllProductsProvider>(context, listen: false);
    final allProducts = provider.allProductslist;

    filteredList = allProducts.where((product) {
      final name = product.productName?.toLowerCase() ?? "";
      final brand = product.relationbrand?.brandName?.toLowerCase() ?? "";
      final category = product.category?.productCategoryName?.toLowerCase() ?? "";

      return name.contains(query.toLowerCase()) ||
          brand.contains(query.toLowerCase()) ||
          category.contains(query.toLowerCase());
    }).toList();

    loadInitialData();
  }

  Color getColor(Set<WidgetState> states) => Colors.grey.shade100;
  Color getColors(Set<WidgetState> states) => Colors.white;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          "Product List",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: Column(
        children: [

          /// 🔍 SEARCH
          Padding(
            padding: EdgeInsets.all(10.r),
            child: SizedBox(
              height: 28.h,
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  filterProducts(value);
                },
                decoration: InputDecoration(
                  hintText: "Search product...",
                  hintStyle: TextStyle(fontSize: 12.sp),
                  prefixIcon: Icon(Icons.search,size: 16.r),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.close,size: 16.r,color: Colors.red),
                    onPressed: () {
                      searchController.clear();
                      filterProducts("");
                    },
                  )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ),
            ),
          ),

          /// 📦 TABLE
          Expanded(
          child: Consumer<AllProductsProvider>(
            builder: (context, provider, child) {
              if (provider.isProductsLoading) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.indigo.shade900),
                );
              }

              if (displayList.isEmpty) {
                return Center(
                  child: Text("No Data Found",style: AllTextStyle.nofoundTextStyle),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: EdgeInsets.all(10.r),
                          child: DataTable(
                            columnSpacing: 25.w,
                            headingRowHeight: 25.h,
                            dataRowHeight: 40.h,
                            headingRowColor:
                            WidgetStateProperty.resolveWith((states) => Colors.indigo.shade900),
                            border: TableBorder.all(color: Colors.blueGrey.shade100,width: 1.w),
                            columns: const [
                              DataColumn(label: Text('SI.', style: TextStyle(color: Colors.white))),
                              DataColumn(label: Text('Image', style: TextStyle(color: Colors.white))),
                              DataColumn(label: Text('Product Name', style: TextStyle(color: Colors.white))),
                              DataColumn(label: Text('Price', style: TextStyle(color: Colors.white))),
                              DataColumn(label: Text('Brand', style: TextStyle(color: Colors.white))),
                              DataColumn(label: Text('Category', style: TextStyle(color: Colors.white))),
                              DataColumn(label: Text('Action', style: TextStyle(color: Colors.white))),
                            ],
                            rows: List.generate(
                              displayList.length,
                                  (index) {
                                final product = displayList[index];

                                return DataRow(
                                  color: index % 2 == 0
                                      ? WidgetStateProperty.resolveWith(getColor)
                                      : WidgetStateProperty.resolveWith(getColors),
                                  cells: [

                                    DataCell(Center(child: Text("${index + 1}"))),

                                    DataCell(
                                      product.mainImage != null &&
                                          product.mainImage!.isNotEmpty
                                          ? Image.network(
                                        "$imageUrl${product.mainImage!}",
                                        width: 40.w,
                                        height: 40.h,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.image),
                                      ): const Icon(Icons.image),
                                    ),
                                    DataCell(
                                      Text(product.productName ?? "",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    DataCell(Text(product.productWholesaleRate?.toString() ?? "")),
                                    DataCell(Text(product.relationbrand?.brandName ?? "")),
                                    DataCell(Text(product.category?.productCategoryName ?? "")),
                                    DataCell(
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) => One_Product_Details(
                                              slug: product.slug,
                                              productId: product.productSlNo,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          elevation: 5,
                                          color: Colors.indigo.shade800,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.h,vertical: 3.h),
                                            child: Icon(
                                              Icons.visibility,
                                              size: 14.r,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (displayList.length < filteredList.length)
                  Padding(
                    padding: EdgeInsets.all(10.r),
                    child: isLoadMoreLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo.shade900,
                        ),
                      )
                    : GestureDetector(
                        onTap: loadMoreData,
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.r),
                            child: Text(
                              "Load More",
                              style: TextStyle(
                                color: Colors.pink,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),
                ],
              );
            },
          ),
        ),
        ],
      ),
    );
  }
}
