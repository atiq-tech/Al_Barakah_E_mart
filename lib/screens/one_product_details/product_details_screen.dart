import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:share_plus/share_plus.dart';
import 'package:al_barakah_e_mart/all_api_provider/products_details_provider.dart';
import 'package:al_barakah_e_mart/footer_section/about_section.dart';
import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
import 'package:al_barakah_e_mart/provider/token_provider/token_provider.dart';
import 'package:al_barakah_e_mart/screens/checkOut/checkout_from_details_screen.dart';
import 'package:al_barakah_e_mart/screens/one_product_details/product_image_section.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:al_barakah_e_mart/utils/what_up_fab.dart';
import '../../custom/custom_card/my_custom_card_screen.dart';


class One_Product_Details extends StatefulWidget {
  const One_Product_Details({Key? key, required this.slug, required this.productId}) : super(key: key);
  final String slug;
  final String productId;

  @override
  State<One_Product_Details> createState() => _One_Product_DetailsState();
}

class _One_Product_DetailsState extends State<One_Product_Details> {
  SharedPreferences? sharedPreferences;
  String? customerId = "";
  String? authType = "";

  int currentIndex = 0;
  int imageSelect = 0;
  int sizeSelect = 0;
  int sizeId = 0;
  int colorId = 0;
  int count = 1;

  bool isFavorite = false;

  Future<void> _initializeData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    customerId = sharedPreferences?.getString('id') ?? "";
    authType = "${sharedPreferences?.getString('auth_type')}";

    print("auth_type=========$authType");
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

 Color hexToColor(String? hexString) {
  // ১. যদি ডাটা নাল বা খালি থাকে তবে ডিফল্ট কালার (যেমন: সাদা বা ট্রান্সপারেন্ট)
  if (hexString == null || hexString.isEmpty) {
    return Colors.grey.shade300; 
  }

  try {
    final buffer = StringBuffer();
    // ২. হেক্স কোড থেকে # চিহ্ন সরিয়ে ফেলা
    String cleanHex = hexString.replaceFirst('#', '').trim();
    
    // ৩. যদি ৬ ডিজিট হয় (যেমন: 04ff00), তবে শুরুতে ff যোগ করা (Opacity)
    if (cleanHex.length == 6) {
      buffer.write('ff');
    }
    buffer.write(cleanHex);
    
    // ৪. ইন্টিজারে কনভার্ট করে কালার রিটার্ন করা
    return Color(int.parse(buffer.toString(), radix: 16));
  } catch (e) {
    // কোনো কারণে এরর হলে (ভুল হেক্স কোড আসলে) ডিফল্ট কালার
    return Colors.transparent;
  }
}

 var availableStock = 0;
  Response? response;
  void totalStack(String? productId) async {
  try {
    response = await Dio().post(
      "${BaseUrl}get_product_wise_stock",
      data: {"product_id": "$productId"},
    );

    if (response != null && response!.data != null) {
      setState(() {
        availableStock = int.parse(response!.data['stock'].toString());
      });
    }
    
    print("availableStock==== $availableStock");
  } catch (e) {
    print("Error fetching stock: $e");
  }
}

  @override
  void initState() {
    super.initState();
    _initializeData();

    /// ✅ SAFE provider call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsDetailsProvider>(context, listen: false)
          .getProductsDetails(widget.slug);
    });
    totalStack(widget.productId);
  }

 

  @override
  Widget build(BuildContext context) {
    final userToken =  Provider.of<TokenProvider>(context).tokenData;
    final addToCart = Provider.of<AddToCartProvider>(context, listen: true);
    final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          "Product Details",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      /// ✅ Provider Consumer
      body: Consumer<ProductsDetailsProvider>(
        builder: (context, provider, child) {
          /// Loading
          if (provider.isProductsDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final product = provider.productsDetails?.product;
          final relatedProducts = provider.productsDetails?.relatedProducts ?? [];

          /// Null safety
          if (product == null) {
            return const Center(child: Text("Product not found"));
          }
           
           return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  children: [
                    ProductImageSection(
                      product: product,
                      imageUrl: imageUrl,
                    ),
                     SizedBox(height: 10.h),
                     Container(
                        height: 50.h,
                        alignment: Alignment.centerLeft,
                        child: Text(product.productName,
                          style: GoogleFonts.abyssinicaSil(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Text("Price : ",style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            )),
                            Text(authType == "reseller" ?"৳${product.productWholesaleRate}" : "৳${product.discountPrice}",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            )),  
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // URL ebong Link ready kora
                            //final String productImageUrl = "$imageUrl${product.mainImage}";
                            final String productLink = 'https://demo-web.tltelecom.com/product/${product.slug}/${product.productCode}';

                            // Sorasori system share menu open hobe
                            Share.share(
                              //'Check out this product: ${product.productName}\n'
                              //'Image: $productImageUrl\n'
                              'Check out this product Link: $productLink',
                              subject: product.productName,
                            );
                          },
                          child: Card(
                            elevation: 5,
                            color: const Color.fromARGB(255, 3, 197, 197),
                             shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Share",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.reply_all,
                                    size: 18.sp,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ],
                      ),
                     Row(
                      children: [
                         Text("Status : ",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        )),
                       availableStock == 0 ? Text("Out of Stock",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            )):Text("In Stock",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            )),
                      ],
                    ),
                     Row(
                      children: [
                         Text("Product Code : ",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        )),
                        Text("${product.productCode}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            )),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          WhatsAppHelper.launchWhatsApp(
                            phone: "", // country code সহ
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: 110.w,
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.teal,
                                  Colors.green,
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.topLeft,
                              ),
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.white,
                                  size: 18.r,
                                ),
                                SizedBox(width: 6.w),
                                Text("Message on\nWhatsapp",style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 30.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.r),
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0), // ভেতরের বর্ডারের সাথে গ্যাপের জন্য
                          child: Container(
                            decoration: BoxDecoration(
                              // এখানে ফাংশন কল হচ্ছে
                              color: hexToColor("${product.relationcolor?.code}"),
                              borderRadius: BorderRadius.circular(2.r),
                              // যদি কোড সাদা হয়, তবে হালকা বর্ডার কালারটি বুঝতে সাহায্য করবে
                              border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 10.h),
                    //////////////////////// Description Section ////////////////
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Product Details : ",style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),),
                         Divider(
                          height: 1.h,
                          indent: 1,
                          thickness: 1,
                          color: Colors.black,
                          endIndent: 1,
                        ),
                        SizedBox(height: 10.h),
                        Container(child: Text(Bidi.stripHtmlIfNeeded(product.shortDescription??""),textAlign: TextAlign.justify,style: GoogleFonts.abyssinicaSil(fontSize: 14.sp),)),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      height: 35.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text("Quantity :  ",style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),),
                          Container(
                            height: 100.h,
                            width: 130.w,
                            child: Row(
                              children: [
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                  if (count > 1) {
                                    setState(() {
                                      count--;
                                    });
                                  }},
                                  child: Container(
                                    height: 100.h,
                                   decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                      border: Border.all(color: appbuttonColor)
                                    ), 
                                    child: Icon(Icons.remove),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                flex: 4,
                                child: Container(
                                 height: 100.h,
                                 decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                    border: Border.all(color: appbuttonColor)
                                  ), 
                                  child: Center(child: Text("$count")),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      count++;
                                    });
                                  },
                                  child: Container(
                                    height: 100.h,
                                   decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                      border: Border.all(color: appbuttonColor)
                                    ),
                                    child: Icon(Icons.add), 
                                  ),
                                ),
                              ),
                            ],),
                          ),
                        ],
                      ),
                    ),
                    ///
                  Container(
                      margin: EdgeInsets.only(left: 40.w,right: 40.w,top: 10.h),
                      height: 40.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // ✅ STOCK CHECK
                                if (availableStock == 0) {
                                   Utils.showTopSnackBar(context, "Stock Out");
                                  return;
                                }
                                setState(() {
                                  addToCart.addProduct(
                                    AddToCartModel(
                                      id: int.parse("${product.productSlNo}"),
                                      productName: product.productName,
                                      brandName: product.relationbrand?.brandName,
                                      image: "$imageUrl${product.mainImage}",
                                      quantity: count,
                                      slug: product.slug,
                                      discountPrice: authType =="reseller" ? double.parse(product.productWholesaleRate) : double.parse(product.discountPrice),
                                    ),
                                  );
                                  CustomSnackBar.showTopSnackBar(context, "Successfully Added to Cart");
                                });
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(
                                        addToCart: addToCartProviderList,
                                        from: 'cart',
                                        quantity: 1,
                                        token: userToken,
                                        total: "${Provider.of<AddToCartProvider>(context, listen: false).totalCartValue}",
                                      ),
                                    ),
                                  );

                              },
                              child: Container(
                                height: 35.h,
                                decoration: BoxDecoration(
                                  color: appbuttonColor,
                                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                ),
                                alignment: Alignment.center,
                                child: Text("Buy now",style: GoogleFonts.abyssinicaSil(
                                    fontSize: 16.sp,
                                    color: Colors.white
                                ),),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Container(
                              height: 35.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                  border: Border.all(color: appbuttonColor)
                            ),
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                if (availableStock == 0) {
                                   Utils.showTopSnackBar(context, "Stock Out");
                                  return;
                                }
                                addToCart.addProduct(
                                  AddToCartModel(
                                    id: product.productSlNo is int? product.productSlNo
                                        : int.parse(product.productSlNo.toString()),
                                    productName: product.productName ?? "",
                                    brandName: product.brand?.toString() ?? "",
                                    image: "$imageUrl${product.mainImage}",
                                    quantity: count,
                                    slug: product.slug ?? "",
                                    discountPrice: authType =="reseller" ? double.parse(product.productWholesaleRate) : double.parse(product.discountPrice),
                                  ),
                                );
                                CustomSnackBar.showTopSnackBar(context, "Successfully Added to Cart");
                              },
                              child: Text("Add to Cart",style: GoogleFonts.abyssinicaSil(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: appbuttonColor,
                              )),
                            ),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    //////////////////////// Description Section ////////////////
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Description :",style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Warranty : ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                  text: product.warranty != null 
                                      ? "${product.warranty} Days"
                                      : "",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          height: 1.h,
                          indent: 1,
                          thickness: 1,
                          color: Colors.black,
                          endIndent: 1,
                        ),
                        SizedBox(height: 10.h),
                        Container(
                            child: Text(Bidi.stripHtmlIfNeeded(product.longDescription),textAlign: TextAlign.justify,style: GoogleFonts.tajawal(fontSize: 14.sp))),    
                      ],
                    ),
                    SizedBox(height: 10.h),
                    //////////////////////// Description Section ////////////////
                    GestureDetector(
                      onTap: () {
                        showSpecificationDialog(
                          context,
                          product.specification??"",
                        );
                      },
                      child: Card(
                        elevation: 9,
                        shape: BeveledRectangleBorder(
                          side: BorderSide(color: appbuttonColor),
                          borderRadius: BorderRadius.circular(10.r)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Specification",
                            style: GoogleFonts.adamina(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),
                         //////////////////////// Related Product Section ////////////////
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Related Products : ",style: GoogleFonts.poppins(
                          fontSize: 15.h,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),),
                        Divider(
                          height: 1.h,
                          indent: 1,
                          thickness: 1,
                          color: Colors.black,
                          endIndent: 1,
                        ),
                      ],
                    ),
                    // //////////////////////// Related Product Section ////////////////
                   if (relatedProducts.isNotEmpty) 
                   Container(
                     margin: EdgeInsets.only(top: 10.h),
                     height: MediaQuery.of(context).size.height/2.5,
                     width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w,right: 10.w),
                        child: CarouselSlider(
                          items: List.generate(relatedProducts.length, (index) {
                             final product = relatedProducts[index];
                             bool hasDiscount = checkHasDiscount(product.startDate, product.endDate);
                            return Padding(
                              padding: EdgeInsets.all(5.r),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(
                                    slug: relatedProducts[index].slug,
                                    productId: relatedProducts[index].productSlNo.toString(),
                                  ),));
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
                                  discount: hasDiscount ? product.onlineDiscount.toString(): "",
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
                            //onPageChanged: callbackFunction,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              const BigBuyFooter(),
            ],
          ),
         );
        },
      ),
    );
  }
}

void showSpecificationDialog(BuildContext context, String specification) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(5.r),
          child: Column(
            children: [
              /// Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("🎆",style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
                  Text("Specification",style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.close,color: Colors.red),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              const Divider(),
              /// Content
              Expanded(
                child: SingleChildScrollView(
                  child: _buildSpecificationWidget(specification),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildSpecificationWidget(String htmlString) {
  final document = htmlParser.parse(htmlString);
  /// Table rows
  final rows = document.querySelectorAll("tr");
  /// List items
  final listItems = document.querySelectorAll("li");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// Table
      Table(
        border: TableBorder.all(color: Colors.grey.shade300),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(3),
        },
        children: rows.map((row) {
          final th = row.querySelector("th")?.text ?? "";
          final td = row.querySelector("td")?.text ?? "";

          return TableRow(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(5.r),
                child: Text(
                  th,
                  style:TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10.sp),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.r),
                child: Text(
                  td,
                  style:TextStyle(fontSize: 10.sp),
                ),
              ),
            ],
          );
        }).toList(),
      ),
      SizedBox(height: 8.h),
      /// Bullet List
      ...listItems.map(
        (item) => Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• "),
              Expanded(
                child: Text(
                  item.text,
                  style:TextStyle(fontSize: 10.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}