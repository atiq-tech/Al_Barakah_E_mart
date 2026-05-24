import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
import 'package:al_barakah_e_mart/provider/token_provider/token_provider.dart';
import 'package:al_barakah_e_mart/screens/checkOut/checkout_from_details_screen.dart';
import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final userToken =  Provider.of<TokenProvider>(context).tokenData;
    final cartProvider = Provider.of<AddToCartProvider>(context);
    final cartList = cartProvider.cart;
    final total = cartProvider.totalCartValue;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: EdgeInsets.all(10.r),
        child: cartList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/cart.png", width: 55.sp, height: 55.sp),
                    SizedBox(height: 10.h),
                    Text("Your cart is Empty", style: AllTextStyle.nofoundTextStyle),
                    SizedBox(height: 6.h),
                    Text(
                      "Must add items on the cart before you proceed to check out",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.robotoSlab(fontSize: 13.sp),
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));  
                      },
                      child: Card(
                        elevation: 5,
                        color: appBarColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          child: const Text("Return Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        )),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shopping Cart", style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w800)),
                      TextButton(
                        onPressed: () {
                          Utils.showCustomDialog(
                            context,
                            child: Container(
                              height: 130.h,
                              padding: EdgeInsets.all(10.r),
                              child: Column(
                                children: [
                                  Text("Are you sure?",style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5.h),
                                  Text(
                                    "Do you want to remove all of the cart items? Once you remove all, you can add again from product list.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 28.h,
                                        width: 100.w,
                                        child: ElevatedButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("No"),
                                        ),
                                      ),
                                      SizedBox(width: 15.w),
                                      SizedBox(
                                        height: 28.h,
                                        width: 100.w,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            cartProvider.clearCart();
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                          child: const Text("Yes"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: const Text("Remove All", style: TextStyle(color: Colors.red)),
                      ),
                   
                    ],
                  ),
                  Expanded(
                  child: Column(
                    children: [
                      /// CART LIST
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: ListView.separated(
                            itemCount: cartList.length,
                            separatorBuilder: (_, __) => Divider(height: 1,color: Colors.grey.shade300),
                            itemBuilder: (context, index) {
                              final item = cartList[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// IMAGE
                                    Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.r),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5.r),
                                        child: CustomImage(
                                          path: item.image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    /// DETAILS
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          /// NAME + DELETE
                                          Row(
                                            crossAxisAlignment:  CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.productName ?? "",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12.sp,
                                                    fontWeight:FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  cartProvider.removeProduct(item);
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.black,
                                                  size: 20.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 1.h),
                                          /// QTY + PRICE
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              /// QUANTITY BUTTON
                                              Container(
                                                height: 25.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:BorderRadius.circular(5.r),
                                                  border: Border.all(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        if (item.quantity! > 1) {
                                                          cartProvider.updateProduct(
                                                            item,
                                                            item.quantity! - 1,
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 30.w,
                                                        alignment: Alignment.center,
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 18.sp,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 40.w,
                                                      alignment:Alignment.center,
                                                      color: Colors.grey.shade100,

                                                      child: Text("${item.quantity}",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        cartProvider.updateProduct(
                                                          item,
                                                          item.quantity! + 1,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 30.w,
                                                        alignment:Alignment.center,
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 18.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              /// PRICE
                                              Text("৳${item.discountPrice} × ${item.quantity} = ৳${item.discountPrice! * item.quantity!}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11.sp,
                                                  fontWeight:FontWeight.w600,
                                                  color: Colors.teal.shade900,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      /// BOTTOM TOTAL
                      Container(
                        padding: EdgeInsets.only(left: 15.w,right: 60.w,bottom: 15.h),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "= ৳ $total",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            SizedBox(
                              width: double.infinity,
                              height: 35.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appBarColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8.r),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CheckoutScreen(
                                        addToCart: cartList,
                                        from: 'cart',
                                        quantity: 1,
                                        token: userToken,
                                        total: "$total",
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Proceed To Checkout",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h)
                    ],
                  ),
                ),  
                ],
              ),
      ),
    );
  }
}












///-----it is my new code------
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
// import 'package:al_barakah_e_mart/screens/checkOut/checkout_from_details_screen.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';
// import 'package:al_barakah_e_mart/utils/utils.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<AddToCartProvider>(context);
//     final cartList = cartProvider.cart;
//     final total = cartProvider.totalCartValue;

//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: cartList.isEmpty
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset("images/cart.png", width: 55.sp, height: 55.sp),
//                     Text("Your cart is Empty", style: AllTextStyle.nofoundTextStyle),
//                     Text(
//                       "Must add items on the cart before you proceed to check out",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.robotoSlab(fontSize: 11.sp),
//                     ),
//                   ],
//                 ),
//               )
//             : Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("MY CART", style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w800)),
//                       TextButton(
//                         onPressed: () {
//                           Utils.showCustomDialog(
//                             context,
//                             child: Container(
//                               height: 200,
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 children: [
//                                   const Text("Are you sure?",
//                                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                   const SizedBox(height: 20),
//                                   const Text(
//                                     "Do you want to remove all of the cart items? Once you remove all, you can add again from product list.",
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   const SizedBox(height: 20),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SizedBox(
//                                         height: 40,
//                                         width: 80,
//                                         child: ElevatedButton(
//                                           onPressed: () => Navigator.pop(context),
//                                           child: const Text("No"),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 20),
//                                       SizedBox(
//                                         height: 40,
//                                         width: 80,
//                                         child: ElevatedButton(
//                                           onPressed: () {
//                                             cartProvider.clearCart();
//                                             Navigator.pop(context);
//                                           },
//                                           style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                                           child: const Text("Yes"),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         child: const Text("Remove All", style: TextStyle(color: Colors.red)),
//                       ),
//                     ],
//                   ),
//                   /// ===== SCROLLABLE CONTENT =====
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           /// ===== CART TABLE =====
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(6),
//                               boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
//                             ),
//                             child: Column(
//                               children: [
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(5.r),
//                                     child: DataTable(
//                                       headingRowHeight: 20.h,
//                                       dataRowHeight: 40.h,
//                                       headingRowColor: MaterialStateProperty.all(Colors.orange.shade300),
//                                       border: TableBorder.all(color: Colors.grey.shade400, width: 1.w),
//                                       columns: [
//                                         DataColumn(label: Center(child: Text("Image", style: AllTextStyle.tableHeadTextStyle))),
//                                         DataColumn(
//                                             label: Center(child: Text("Product Name", style: AllTextStyle.tableHeadTextStyle))),
//                                         DataColumn(label: Center(child: Text("Model", style: AllTextStyle.tableHeadTextStyle))),
//                                         DataColumn(label: Center(child: Text("Quantity", style: AllTextStyle.tableHeadTextStyle))),
//                                         DataColumn(label: Center(child: Text("Unit Price", style: AllTextStyle.tableHeadTextStyle))),
//                                         DataColumn(label: Center(child: Text("Total", style: AllTextStyle.tableHeadTextStyle))),
//                                         DataColumn(label: Center(child: Text("Action", style: AllTextStyle.tableHeadTextStyle))),
//                                       ],
//                                       rows: List.generate(
//                                         cartList.length,
//                                         (index) {
//                                           final item = cartList[index];
//                                           return DataRow(
//                                             cells: [
//                                               DataCell(
//                                                 Center(
//                                                   child: SizedBox(
//                                                     height: 50.h,
//                                                     width: 50.w,
//                                                     child: CustomImage(path: item.image, fit: BoxFit.contain),
//                                                   ),
//                                                 ),
//                                               ),
//                                               DataCell(
//                                                 Text(
//                                                   item.productName ?? "",
//                                                   maxLines: 2,
//                                                   overflow: TextOverflow.ellipsis,
//                                                   style: TextStyle(fontSize: 12.sp),
//                                                 ),
//                                               ),
//                                               DataCell(
//                                                 Column(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text("Brand: New Brand",
//                                                         style: TextStyle(color: Colors.orange, fontSize: 12.sp)),
//                                                     Text("New Model", style: TextStyle(fontSize: 12.sp)),
//                                                   ],
//                                                 ),
//                                               ),
//                                               DataCell(
//                                                 Row(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     _qtyBtn(Icons.remove, () {
//                                                       if (item.quantity! > 1) {
//                                                         cartProvider.updateProduct(item, item.quantity! - 1);
//                                                       }
//                                                     }),
//                                                     Padding(
//                                                       padding: EdgeInsets.symmetric(horizontal: 5.w),
//                                                       child: Text("${item.quantity}",
//                                                           style: const TextStyle(fontWeight: FontWeight.bold)),
//                                                     ),
//                                                     _qtyBtn(Icons.add, () {
//                                                       cartProvider.updateProduct(item, item.quantity! + 1);
//                                                     }),
//                                                   ],
//                                                 ),
//                                               ),
//                                               DataCell(
//                                                 Center(
//                                                   child: Text("${item.discountPrice}",
//                                                       style: TextStyle(fontSize: 12.sp)),
//                                                 ),
//                                               ),
//                                               DataCell(
//                                                 Text("${item.discountPrice! * item.quantity!}",
//                                                     style: TextStyle(fontSize: 12.sp)),
//                                               ),
//                                               DataCell(
//                                                 GestureDetector(
//                                                   onTap: () => cartProvider.removeProduct(item),
//                                                   child: Center(
//                                                     child: Icon(Icons.delete, size: 18.sp, color: Colors.orange),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 /// TOTAL
//                                 Container(
//                                   alignment: Alignment.centerRight,
//                                   padding: const EdgeInsets.all(12),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       _totalRow("Sub-Total:", total),
//                                       _totalRow("Delivery Charge:", 0),
//                                       _totalRow("Total Discount:", 0),
//                                       Divider(height: 1),
//                                       _totalRow("Total:", total, isBold: true),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           /// ===== COUPON ROW =====
//                           Card(
//                             elevation: 3,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 2,
//                                         child: SizedBox(
//                                           height: 25.h,
//                                           child: TextField(
//                                             decoration: InputDecoration(
//                                               hintText: "Promo/Coupon Code",
//                                               hintStyle: TextStyle(
//                                                 fontSize: 12.sp,
//                                                 color: Colors.grey.shade500,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               filled: true,
//                                               fillColor: Colors.white,
//                                               contentPadding:
//                                                   EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
//                                               border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(6.r),
//                                                 borderSide: BorderSide(color: Colors.grey.shade400),
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(6.r),
//                                                 borderSide: BorderSide(color: Colors.grey.shade400),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(6.r),
//                                                 borderSide: BorderSide(color: Colors.orange),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: Card(
//                                           elevation: 5,
//                                           child: Container(
//                                             height: 25.h,
//                                             decoration: BoxDecoration(
//                                                 color: Colors.orange,
//                                                 borderRadius: BorderRadius.circular(5.r)),
//                                             child: Center(
//                                                 child: Text("APPLY COUPON",
//                                                     style: TextStyle(
//                                                         fontSize: 10.sp,
//                                                         color: Colors.white,
//                                                         fontWeight: FontWeight.bold))),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 6.h),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 2,
//                                         child: SizedBox(
//                                           height: 25.h,
//                                           child: TextField(
//                                             decoration: InputDecoration(
//                                               hintText: "Gift Voucher Code",
//                                               hintStyle: TextStyle(
//                                                 fontSize: 12.sp,
//                                                 color: Colors.grey.shade500,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               filled: true,
//                                               fillColor: Colors.white,
//                                               contentPadding:
//                                                   EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
//                                               border: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(6.r),
//                                                 borderSide: BorderSide(color: Colors.grey.shade400),
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(6.r),
//                                                 borderSide: BorderSide(color: Colors.grey.shade400),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderRadius: BorderRadius.circular(6.r),
//                                                 borderSide: BorderSide(color: Colors.orange),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 1,
//                                         child: Card(
//                                           elevation: 5,
//                                           child: Container(
//                                             height: 25.h,
//                                             decoration: BoxDecoration(
//                                                 color: Colors.blueGrey,
//                                                 borderRadius: BorderRadius.circular(5.r)),
//                                             child: Center(
//                                                 child: Text("APPLY VOUCHER",
//                                                     style: TextStyle(
//                                                         fontSize: 10.sp,
//                                                         color: Colors.white,
//                                                         fontWeight: FontWeight.bold))),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Card(
//                                   elevation: 5,
//                                   color: Colors.orange,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(100.r)),
//                                   child: Container(
//                                     height: 35.h,
//                                     decoration: BoxDecoration(
//                                         color: Colors.orange,
//                                         borderRadius: BorderRadius.circular(100.r)),
//                                     child: Center(
//                                         child: Text("Continue Shopping", style: AllTextStyle.tableHeadTextStyle)),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 20.h),
//                               Expanded(
//                                 flex: 1,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => CheckoutScreen(
//                                           addToCart: cartList,
//                                           from: 'cart',
//                                           quantity: 1,
//                                           token: "",
//                                           total: "$total",
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Card(
//                                     elevation: 5,
//                                     shape:
//                                         RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
//                                     color: Colors.indigo,
//                                     child: Container(
//                                       height: 35.h,
//                                       decoration: BoxDecoration(
//                                           color: Colors.indigo,
//                                           borderRadius: BorderRadius.circular(100.r)),
//                                       child: Center(
//                                           child: Text("Check Out", style: AllTextStyle.tableHeadTextStyle)),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20.h),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }

//   /// ===== SMALL WIDGETS =====
//   Widget _qtyBtn(IconData icon, VoidCallback onTap) {
//     return Card(
//       elevation: 3,
//       color: Colors.orange.shade200,
//       shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
//       child: InkWell(
//         onTap: onTap,
//         child: Padding(
//           padding: const EdgeInsets.all(5),
//           child: Icon(icon, size: 14.r),
//         ),
//       ),
//     );
//   }

//   Widget _totalRow(String title, num value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(title,
//               style: TextStyle(
//                   fontWeight: isBold ? FontWeight.bold : FontWeight.w500, fontSize: 12.sp)),
//           SizedBox(width: 4.w),
//           Text("$value",
//               style: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
//                   fontSize: 12.sp)),
//         ],
//       ),
//     );
//   }
// }
















// import 'package:al_barakah_e_mart/main.dart';
// import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
// import 'package:al_barakah_e_mart/provider/cart_remove_provider.dart';
// import 'package:al_barakah_e_mart/provider/company_profile_provider.dart';
// import 'package:al_barakah_e_mart/provider/token_provider/token_provider.dart';
// import 'package:al_barakah_e_mart/provider/user_profile_provider.dart';
// import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
// import 'package:al_barakah_e_mart/screens/auth/pages/signin_page.dart';
// import 'package:al_barakah_e_mart/screens/checkOut/checkout_from_details_screen.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';
// import 'package:al_barakah_e_mart/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:provider/provider.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   Future<void> _initializeData() async {

//     customerId = "${sharedPreferences.getString('id')}";
//     userName = "${sharedPreferences.getString('name')}";
//   }
//   String? userName = "";
//   String? customerId = "";
//   late final Box box;
//   double h1TextSize = 11.0;
//   double totalPrice = 0;
//   double shippingFee = 60;
//   double h2TextSize = 14.0;

//   @override
//   void initState() {
//     _initializeData();
//     // TODO: implement initState
//     super.initState();
//     Provider.of<TokenProvider>(context, listen: false).getToken();
//     Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
//     Provider.of<CompanyProfileProvider>(context, listen: false).getCompanyProfile();
//   }

//   int qtn = 0;

//   @override
//   Widget build(BuildContext context) {
//     final customerId = "${sharedPreferences.getString('id')}";
//     final addtocarprovider = Provider.of<AddToCartProvider>(context, listen: true);
//     final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;

//     final userToken =  Provider.of<TokenProvider>(context).tokenData;
//     final userProfileModel = Provider.of<UserProfileProvider>(context, listen: true).userProfileResponseModel;
//     final companyProfileModel = Provider.of<CompanyProfileProvider>(context, listen: true).companyProfileModel;

//     return Container(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 60),
//       child: addToCartProviderList.isEmpty
//           ? const Center(child: Text("No items available",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),)
//           : Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("MY CART",style: GoogleFonts.robotoSlab(fontWeight: FontWeight.w800)),
//                     TextButton(
//                         onPressed: () {
//                           // addtocarprovider.clearCart();
//                           // Provider.of<AddtoCartProvider>(context,
//                           //     listen: false)
//                           //     .clear();
//                           Utils.showCustomDialog(context,
//                               child: Container(
//                                 height: 200,
//                                 padding: const EdgeInsets.all(10),
//                                 child: Column(
//                                   children: [
//                                     const Text("Are you sure?",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                     const SizedBox(height: 20),
//                                     const Text(
//                                       "Do you what to remove all of the cart items?"
//                                       " Once you remove all this item you can add"
//                                       " again from product list.",
//                                       textAlign: TextAlign.center,
//                                     ),
//                                     const SizedBox(height: 20),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         SizedBox(
//                                           height: 40,
//                                           width: 80,
//                                           child: ElevatedButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: const Text("No"),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 20),
//                                         SizedBox(
//                                           height: 40,
//                                           width: 80,
//                                           child: ElevatedButton(
//                                             onPressed: () {
//                                               addtocarprovider.clearCart();
//                                               Provider.of<RemoveCartProvider>(context, listen: false).clear();
//                                               Navigator.pop(context);
//                                             },
//                                             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                                             child: const Text("Yes"),
//                                           ),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ));
//                         },
//                         child: const Text("Remove All",style: TextStyle(color: Colors.red)))
//                   ],
//                 ),
//                 Expanded(
//                   child: ListView.separated(
//                     itemBuilder: (context, index) {
//                       return Consumer<AddToCartProvider>(
//                         builder: (context, value, child) {
//                           return Stack(
//                             children: [
//                               Card(
//                                 child: ListTile(
//                                   onTap: () {
//                                     Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(slug: addToCartProviderList[index].slug!),));
//                                   },
//                                   leading: Container(
//                                     height: 75,
//                                     width: 55,
//                                     decoration: const BoxDecoration(color: Colors.pink),
//                                     child: CustomImage(
//                                       path: "${addToCartProviderList[index].image}",
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                   title: Text("${value.cart[index].productName}",style: const TextStyle(fontSize: 13.0,color: Colors.black,fontWeight: FontWeight.w500)),
//                                  // subtitle: Text("${value.cart[index].salePrice}"),
//                                   subtitle: Text(
//                                     "৳ ${value.cart[index].discountPrice}",
//                                   ),
//                                   trailing: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         IconButton(
//                                           icon: const Icon(Icons.add_circle),
//                                           onPressed: () {
//                                             value.updateProduct(
//                                                 value.cart[index],
//                                                 value.cart[index].quantity! + 1);
//                                             // model.removeProduct(model.cart[index]);
//                                           },
//                                         ),
//                                         Text("${value.cart[index].quantity}",
//                                           style: const TextStyle(fontSize: 14),
//                                         ),
//                                         IconButton(
//                                           icon: const Icon(Icons.remove_circle),
//                                           onPressed: () {
//                                             print('fasfjkjaskf ${value.cart[index].quantity}');
//                                             if(value.cart[index].quantity!>0){
//                                               value.updateProduct(
//                                                 value.cart[index],
//                                                 value.cart[index].quantity! - 1,
//                                               );
//                                             }else{

//                                             }
//                                             // model.removeProduct(model.cart[index]);
//                                           },
//                                         ),
//                                       ]),
//                                 ),
//                               ),
//                               Positioned(
//                                 right: 10,
//                                 top: 8,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     value.removeProduct(value.cart[index]);
//                                   },
//                                   child: const Icon(
//                                     Icons.delete,
//                                     size: 20,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return const SizedBox(
//                         height: 15,
//                       );
//                     },
//                     itemCount: addToCartProviderList.length,
//                   ),
//                 ),
//                 Container(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Total: ৳${Provider.of<AddToCartProvider>(context, listen: true)
//                               .totalCartValue}",
//                       style: const TextStyle(
//                           fontSize: 18.0, fontWeight: FontWeight.bold),
//                     ),
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 40,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black54
//                   ),
//                     child: const Text("CheckOut",style: TextStyle(color: Colors.white,letterSpacing: 2.0,fontWeight:FontWeight.w900)),
//                     onPressed: () {
//                      if(customerId == "null" ||customerId == "" ||customerId.isEmpty) {
//                        Utils.errorSnackBarWithButton(context, "Sign In Please",() {
//                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage(),));
//                        },);
//                       }
//                       else{
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) =>
//                                CheckoutScreen(
//                                  addToCart: addToCartProviderList,
//                                  from: 'cart',
//                                  quantity: 1,
//                                  ///===old===
//                                  // userProfileModel: userProfileModel!.userProfileModel,
//                                  //companyProfileModel: companyProfileModel!,
//                                  token: userToken,
//                                  total: "${Provider.of<AddToCartProvider>(context, listen: true).totalCartValue}",
//                                ),
//                          ),
//                        );
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 40.0,)
//               ],
//             ),
//     );
//   }

//   int count = 0;
// }
