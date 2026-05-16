// import 'package:tl_telecom/hive_with_cart/product.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   _CartScreenState createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   late final Box box;
//   double h1TextSize = 11.0;
//   double totalPrice = 0;
//   double shippingFee = 60;
//   double h2TextSize = 14.0;

//   @override
//   void initState() {
//     super.initState();
//     // Get reference to an already opened box
//     box = Hive.box('productBox');
//   }

//   // Delete info from people box
//   _deleteProduct(int index) {
//     box.deleteAt(index);
//     print('Product deleted from box at index: $index');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 45,
//           backgroundColor: const Color.fromARGB(255, 87, 117, 133),
//           title: const Text('Cart Info'),
//           actions: const [],
//         ),
//         body: ValueListenableBuilder(
//           valueListenable: box.listenable(),
//           builder: (context, Box box, widget) {
//             if (box.isEmpty) {
//               return const Center(
//                 child: Text('No Product in Cart'),
//               );
//             } else {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: box.length,
//                       itemBuilder: (context, index) {
//                         var currentBox = box;
//                         var productData = currentBox.getAt(index)!;
//                         return Column(
//                           children: [
//                             SizedBox(
//                               height: 90,
//                               child: Card(
//                                 elevation: 5,
//                                 color: Colors.white,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       flex: 1,
//                                       child: Container(
//                                         padding: const EdgeInsets.only(),
//                                         child: Image.network(
//                                           productData.colorDataModel,
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       flex: 3,
//                                       child: Container(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         decoration: BoxDecoration(
//                                             color: Colors.blueGrey[100],
//                                             borderRadius: const BorderRadius.only(
//                                                 topRight: Radius.circular(20),
//                                                 bottomRight:
//                                                     Radius.circular(20))),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "${productData.productName}",
//                                               style: TextStyle(
//                                                 color: Colors.black54,
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: h1TextSize,
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   "৳",
//                                                   style: TextStyle(
//                                                     color: Colors.black54,
//                                                     fontSize: h2TextSize,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   "${productData.productPrice}",
//                                                   style: TextStyle(
//                                                     color: Colors.black54,
//                                                     fontSize: h2TextSize,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Text(
//                                                   "x ${productData.productQuantity}",
//                                                   style: TextStyle(
//                                                     color: Colors.black54,
//                                                     fontSize: h2TextSize,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 Text(
//                                                   "= ৳",
//                                                   style: TextStyle(
//                                                     color: Colors.black54,
//                                                     fontSize: h2TextSize,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   "${productData.productPrice * productData.productQuantity}",
//                                                   style: TextStyle(
//                                                     color: Colors.black54,
//                                                     fontSize: h2TextSize,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 SizedBox(
//                                                   height: 25,
//                                                   width: 25,
//                                                   child: FloatingActionButton(
//                                                     heroTag: null,
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         if (productData
//                                                                 .productQuantity >
//                                                             1) {
//                                                           productData
//                                                               .productQuantity--;
//                                                           ProductDetails
//                                                               existingProduct =
//                                                               box.getAt(index);

//                                                           existingProduct
//                                                                   .productQuantity =
//                                                               productData
//                                                                   .productQuantity--;

//                                                           box.putAt(index,
//                                                               existingProduct);
//                                                         }
//                                                       });
//                                                     },
//                                                     mini: true,
//                                                     shape: const CircleBorder(),
//                                                     backgroundColor:
//                                                         Colors.black12,
//                                                     child: Icon(
//                                                       Icons.remove,
//                                                       color: Colors.white,
//                                                       size: 25,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 Text(
//                                                   "${productData.productQuantity}",
//                                                   style: const TextStyle(
//                                                     color: Colors.black54,
//                                                     fontSize: 20,
//                                                   ),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 5,
//                                                 ),
//                                                 SizedBox(
//                                                   height: 25,
//                                                   width: 25,
//                                                   child: FloatingActionButton(
//                                                     heroTag: null,
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         productData
//                                                             .productQuantity++;
//                                                         ProductDetails
//                                                             existingProduct =
//                                                             box.getAt(index);

//                                                         existingProduct
//                                                                 .productQuantity =
//                                                             productData
//                                                                 .productQuantity++;

//                                                         box.putAt(index,
//                                                             existingProduct);
//                                                       });
//                                                     },
//                                                     mini: true,
//                                                     shape: const CircleBorder(),
//                                                     backgroundColor:
//                                                         Colors.black12,
//                                                     child: Icon(
//                                                       Icons.add,
//                                                       color: Colors.white,
//                                                       size: 25,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                         flex: 1,
//                                         child: Container(
//                                           color: Colors.white,
//                                           child: FloatingActionButton(
//                                             heroTag: null,
//                                             onPressed: () {
//                                               _deleteProduct(index);
//                                               setState(() {
//                                                 box.length;
//                                               });
//                                             },
//                                             mini: true,
//                                             shape: const CircleBorder(),
//                                             backgroundColor: Colors.white,
//                                             child: const Icon(
//                                               Icons.delete,
//                                               color: Color.fromARGB(
//                                                   255, 231, 113, 139),
//                                             ),
//                                           ),
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             )
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 140,
//                     // color: Colors.grey.withOpacity(0.5),
//                     child: ListView.builder(
//                       itemCount: 1,
//                       itemBuilder: (BuildContext context, int index) {
//                         num totalPrice = 0;
//                         for (int i = 0; i < box.length; i++) {
//                           var productData = box.getAt(i)!;
//                           totalPrice += productData.productPrice *
//                               productData.productQuantity;
//                         }

//                         return Container(
//                           padding: const EdgeInsets.only(
//                               top: 10, left: 12, right: 12, bottom: 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Subtotal: ",
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black38),
//                                   ),
//                                   Text(
//                                     "৳$totalPrice",
//                                     style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black38),
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Text(
//                                       "Shipping cost:",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black38),
//                                     ),
//                                     Text(
//                                       "৳ $shippingFee",
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black38),
//                                     ),
//                                   ]),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "Total Price:",
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black38),
//                                   ),
//                                   Text(
//                                     "৳${(totalPrice + shippingFee).toString()}",
//                                     style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor:
//                                       const Color.fromARGB(255, 60, 84, 97),
//                                   minimumSize: const Size.fromHeight(45),
//                                 ),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return const AlertDialog(
//                                         title: Text(
//                                             "It will be done after somtimes"),
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: const Text("Checkout"),
//                               )
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
