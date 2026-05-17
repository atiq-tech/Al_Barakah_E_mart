
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:al_barakah_e_mart/custom_text_field/mycustom_text_form_field.dart';
import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
import 'package:al_barakah_e_mart/provider/cart_remove_provider.dart';
import 'package:al_barakah_e_mart/screens/auth/pages/signin_page.dart';
import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key,
      required this.quantity,
      this.sizeId,
      this.colorId,
      required this.from,
      this.addToCart,
      this.total,
      required this.token});
  final int quantity;
  final String? sizeId;
  final String? colorId;
  final String from;
  final String token;
  final String? total;
  final List<AddToCartModel>? addToCart;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedMethod = "cash";
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userAddress = "";
  String userImage = "";
  SharedPreferences? sharedPreferences;
  Future<void> _initializeData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userName = "${sharedPreferences?.getString('name')}";
    userEmail = "${sharedPreferences?.getString('email')}";
    userPhone = "${sharedPreferences?.getString('phone')}";
    userAddress = "${sharedPreferences?.getString('address')}";
    userImage = "${sharedPreferences?.getString('image')}";

   _shipperNameController.text = userName;
    _shipperPhoneController.text = userPhone;
    _emailController.text = userEmail;
    _shipperAddressController.text = userAddress;
  }
  
  final _formKey = GlobalKey<FormState>();

  final _shipperNameController = TextEditingController();
  final _shipperPhoneController = TextEditingController();
  final _shipperAddressController = TextEditingController();
  //final _couponCodeController = TextEditingController();
  final _emailController = TextEditingController();
  final areaController = TextEditingController();

  String? selectedArea;
  double? deliveryCharge = 0;
  double walletAdjustAmount = 0;
  double walletAdjustPercent = 0;
  double payable = 0;

  late final Box box;
  bool isWalletAdjusted = false;
  bool isLoading = false;

Future<void> placeOrder(BuildContext context) async {
  setState(() {
    isLoading = true;
  });

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String link = "${BaseUrl}customer_order_store";

  try {
    Map<String, dynamic> body = {
      "data": {
        "payment_method": selectedMethod,
        "name": _shipperNameController.text.trim(),
        "phone": _shipperPhoneController.text.trim(),
        "email": _emailController.text.trim(),
        "address": _shipperAddressController.text.trim(),
        "coupon": "",
        "voucher": "",
        "subtotal": widget.total.toString(),
        "discount": "0",
        "discount_type": "fixed",
        "total": widget.total.toString(),
        "agree": "1"
      },
      "cart": widget.from == 'cart'
          ? List.generate(widget.addToCart!.length, (index) {
              var item = widget.addToCart![index];

              return {
                "id": item.id.toString(),
                "name": item.productName ?? "",
                "price": item.discountPrice.toString(),
                "brand_name": item.brandName ?? "",
                "quantity": item.quantity.toString(),
                "total": (double.parse(item.discountPrice.toString()) *
                        int.parse(item.quantity.toString()))
                    .toStringAsFixed(2),
                "main_image": item.image ?? "",
                "options": [
                  {
                    "color": "0",
                    "storage": null,
                    "network": null,
                    "region": null,
                    "size": null
                  }
                ]
              };
            })
          : [
              {
                "quantity": widget.quantity.toString(),
              }
            ]
    };

    /// 🔥🔥 FULL DEBUG PRINT START 🔥🔥

    print("========== ORDER BODY DEBUG START ==========");

    print("---- DATA SECTION ----");
    body["data"].forEach((key, value) {
      print("$key : $value");
    });

    print("---- CART SECTION ----");

    for (int i = 0; i < body["cart"].length; i++) {
      print("Item Index: $i");

      body["cart"][i].forEach((key, value) {
        if (key == "options") {
          print("  $key :");
          for (var option in value) {
            option.forEach((k, v) {
              print("     $k : $v");
            });
          }
        } else {
          print("  $key : $value");
        }
      });

      print("----------------------");
    }

    print("========== ORDER BODY DEBUG END ==========");

    /// 🔥🔥 FULL DEBUG PRINT END 🔥🔥

    Response response = await Dio().post(
      link,
      data: body,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${sharedPreferences.getString("token")}",
        },
      ),
    );

    var res = response.data;
    print("orderPlace response==== $res");

    if (res != null && res['status'] == "success") {
      CustomSnackBar.showTopSnackBar(context, "Order Placed Successfully!");

      if (widget.from == 'cart') {
        Provider.of<AddToCartProvider>(context, listen: false).clearCart();
        Provider.of<RemoveCartProvider>(context, listen: false).clear();
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      Utils.showTopSnackBar(context, res['message'] ?? "Try again!");
    }
  } catch (e) {
    print("Error =====> $e");
    Utils.showTopSnackBar(context, "Something went wrong!");
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  var vat;
  double subTotal = 0.0;
  double totalAmmount = 0.0;
  var total;

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;
    totalAmmount = addToCartProviderList.map((e) => e.discountPrice).fold(0.0, (p, element) => p+double.parse("$element"));
    double h2TextSize = 12.sp;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(onTap: () {Navigator.pop(context);},
        child: const Icon(Icons.arrow_back)),
        foregroundColor: Colors.black,
        backgroundColor: scaffoldColor,
        title: Text('Checkout Page',style: AllTextStyle.getTitleTextStyle()),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("Image",textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ), Expanded(
                    flex: 4,
                    child: Text("Name",textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("Qty",textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("Price",textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text("Total",textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Divider(),
              widget.from == "cart"
                  ? Column(
                      children: List.generate(
                      widget.addToCart!.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade50,
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(color: Colors.blueGrey.shade100)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                flex: 2,
                                child:Padding(
                                  padding: EdgeInsets.all(2.r),
                                  child: CustomImage(
                                    path:"${widget.addToCart![index].image}",
                                  ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: SizedBox(
                                    child: Text(
                                      "${widget.addToCart![index].productName}",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    child: Text(
                                      "${widget.addToCart![index].quantity}",
                                      style: TextStyle(
                                      fontSize:12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                     child: Text(
                                      "${widget.addToCart![index].discountPrice}",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    child: Text(
                                      "${widget.addToCart![index].discountPrice! * double.parse("${widget.addToCart![index].quantity}")}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87),
                                    )),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            child: Text(
                              "${widget.quantity}",
                              style: TextStyle(
                                fontSize: h2TextSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "BDT",
                                style: TextStyle(
                                    fontSize: h2TextSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38),
                              ),
                              Text(
                                "$subTotal",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: h2TextSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
              const Divider(),
              //       Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Expanded(
              //             flex: 3,
              //             child: SizedBox(
              //               height: 30.h,
              //               width: MediaQuery.of(context).size.width,
              //               child: MyCustomTextFormField().getCustomEditTextArea(
              //                   hintValue: 'Coupon Code',
              //                   validation: true,
              //                   controller: _couponCodeController,
              //                   keyboardType: TextInputType.text,
              //                   validationErrorMsg: 'error_msg'),
              //             ),
              //           ),
              //           SizedBox(width: 5.w),
              //           Expanded(
              //             child: Container(
              //               height: 30.h,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(100.r),
              //                 color: appbuttonColor,
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.2),
              //                     blurRadius: 10,
              //                     spreadRadius: 1,
              //                     offset: const Offset(0, 4),
              //                   ),
              //                 ],
              //                ),
              //               child: Center(child: Text("Apply",style: AllTextStyle.tableHeadTextStyle)),
              //             ),
              //           ),
              //         ],
              //       ),
              // const Divider(),
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal: ", style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold)),
                        Text(
                          "BDT ${widget.total}",
                          style: TextStyle(fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery Charge :",
                          style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "(will be added)",
                          style: TextStyle(
                              fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Discount :",
                          style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "BDT  0",
                          style: TextStyle(
                              fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount:", style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold)),
                        Text(
                          "BDT ${widget.total}",
                          style: TextStyle(fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Text(
                "Payment Method",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              /// Cash on Delivery
              Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    value: "cash",
                    groupValue: selectedMethod,
                    dense: true,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Cash on Delivery",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp,color: selectedMethod=="cod"? Colors.green:Colors.black),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value!;
                      });
                    },
                  ),
                ),

                Expanded(
                  child: RadioListTile(
                    value: "online",
                    groupValue: selectedMethod,
                    dense: true,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      "Online Payment",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp,color: selectedMethod=="online"? Colors.green:Colors.black),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedMethod = value!;
                      });
                    },
                  ),
                ),

              ],
            ),
              /// Conditional Show
              if (selectedMethod == "cash")
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "Please Call For 01711514200",style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontStyle: FontStyle.italic
                    )
                  ),
                ),
              if (selectedMethod == "online")
                Container(
                  padding: EdgeInsets.only(bottom: 4.h,top: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CustomImage(
                            path:"images/bkash.png",
                            width: 20.w,
                          ),
                          const SizedBox(width: 4),
                          Text("bKash:\n01711514200",style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontStyle: FontStyle.italic
                          )),
                        ],
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: [
                          CustomImage(
                            path:"images/nagod.png",
                            width: 20.w,
                          ),
                          const SizedBox(width: 4),
                          Text("Nagad:\n01711514200",style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontStyle: FontStyle.italic
                          )),
                        ],
                      ),
                      const SizedBox(width: 4),
                      Row(
                        children: [
                          CustomImage(
                            path:"images/rocket.png",
                            width: 20.w,
                          ),
                          const SizedBox(width: 4),
                          Text("Rocket:\n01711514200",style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontStyle: FontStyle.italic
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(height: 10.h),
              //Shipping Information Section
              Text('Billing details',style: TextStyle( fontSize: h2TextSize, fontWeight: FontWeight.bold,color: Colors.black)),
              Container(
                margin: EdgeInsets.only(top: 15.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 15.h),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 231, 231, 231),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     Text("Your Name *", style: TextStyle(fontSize: h2TextSize)),
                                      SizedBox(height: 5.h),
                                      SizedBox(
                                        height: 30.h,
                                        width: MediaQuery.of(context).size.width/2.3,
                                        child: MyCustomTextFormField().getCustomEditTextArea(
                                            hintValue: 'Name',
                                            validation: true,
                                            controller: _shipperNameController,
                                            keyboardType: TextInputType.text,
                                            validationErrorMsg: 'error_msg'),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 5.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Phone number *", style: TextStyle(fontSize: h2TextSize)),
                                      SizedBox(height: 5.h),
                                      SizedBox(
                                        height: 30.h,
                                        width: MediaQuery.of(context).size.width/2.3,
                                        child: MyCustomTextFormField().getCustomEditTextArea(
                                            hintValue: 'Phone number',
                                            validation: true,
                                            controller: _shipperPhoneController,
                                            keyboardType: TextInputType.phone,
                                            validationErrorMsg: 'error_msg'),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email *", style: TextStyle(fontSize: h2TextSize)),
                                  SizedBox(height: 5.h),
                                  Container(
                                    height: 30.h,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(right: 35.h),
                                    child: MyCustomTextFormField().getCustomEditTextArea(
                                        hintValue: 'Enter email',
                                        validation: true,
                                        controller: _emailController,
                                        keyboardType: TextInputType.text,
                                        validationErrorMsg: 'error_msg'),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Shipping Adreess *", style: TextStyle(fontSize: h2TextSize)),
                                SizedBox(height: 5.h),
                                SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width,
                                  child: MyCustomTextFormField().getCustomEditTextArea(
                                      hintValue: 'Shipping Adreess',
                                      validation: true,
                                      controller: _shipperAddressController,
                                      keyboardType: TextInputType.text,
                                      validationErrorMsg: 'error_msg'),
                                )
                              ],
                            ),
                            SizedBox(height: 15.h),
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.only(top:5.h,bottom: 10.h),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: applineColor,
                                  minimumSize: Size.fromHeight(35.h),
                                ),
                                onPressed: () {

                                  /// 🔥 1️⃣ First Check → User Logged In or Not
                                  if (widget.token == "" || widget.token.isEmpty) {

                                    Utils.errorSnackBarWithButton(
                                      context,
                                      "Sign In Please",
                                      () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const SignInPage(),
                                          ),
                                        );
                                      },
                                    );
                                    return; 
                                  }

                                  /// 🔥 2️⃣ Then Check Mobile
                                  if (_shipperPhoneController.text.trim().isEmpty) {
                                    Utils.showTopSnackBar(context, "Please Enter Mobile");
                                    return;
                                  }

                                  /// 🔥 3️⃣ Everything OK → Place Order
                                  setState(() {
                                    isLoading = true;
                                  });

                                  placeOrder(context);
                                },
                                child: isLoading
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        "PLACE ORDER",
                                        style: AllTextStyle.tableHeadTextStyle,
                                      ),
                              ),
                            ),
                           SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
