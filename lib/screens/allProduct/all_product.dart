
import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../all_api_model/all_products_model.dart';
import '../../footer_section/about_section.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({Key? key, required this.productDataModel, required this.productName}) : super(key: key);
  final String productName;
  final List<AllProductModel> productDataModel;
  ///====
  // final String productName;
  // final List<ProductDataModel> productDataModel;


  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {

  @override
  Widget build(BuildContext context) {
    // final allProductList = Provider.of<All_Product_Provider>(context).allproductlist;
    final addToCart = Provider.of<AddToCartProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // scrolledUnderElevation: 0,
        backgroundColor: scaffoldColor,
        foregroundColor: Colors.black,
        title: Text(widget.productName,
          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        leading: GestureDetector(onTap: () {
          // MainController().naveListener.sink.add(0);
          Navigator.pop(context);
        },child: const Icon(Icons.arrow_back_outlined)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 0,
              left: 10,
              right: 10,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 16,
                crossAxisSpacing: MediaQuery.of(context).size.width*0.04,
                mainAxisExtent: 275,
              ),
              delegate: SliverChildBuilderDelegate((context, index){
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(
                      slug: widget.productDataModel[index].slug,
                      productId: widget.productDataModel[index].productSlNo.toString(),
                    ),));
                  },
                  child: Card(
                    elevation: 8.0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)
                        )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 230, 230, 230),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFeeeeee),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 200,
                                  child: CustomImage(
                                    path: "$baseUrl/uploads/products/small_image/${widget.productDataModel[index].mainImage}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                // Visibility(
                                //   visible: widget.productDataModel[index].cashbackPercent!='0.00',
                                //   child: Positioned(
                                //       top: 10,
                                //       right: 10,
                                //       child: Container(
                                //         color: Colors.blue,
                                //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                //         child: Text(
                                //           "${widget.productDataModel[index].cashbackPercent}%",
                                //           style: const TextStyle(fontSize: 12,color: Colors.white),),
                                //       )),
                                // ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.productDataModel[index].productName,
                                  overflow: TextOverflow.ellipsis,
                                  //my change
                                  style: const TextStyle(
                                    color: Color(0xFF212121),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    Text(
                                      'Code: ${widget.productDataModel[index].productCode}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF212121)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'MRP: ${widget.productDataModel[index].onlineDiscount}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.blue,
                                  ),
                                ),
                                // Visibility(
                                //   visible: widget.productDataModel[index].cashbackAmount!="0.00",
                                //   child: Text(
                                //     'Cashback: ${widget.productDataModel[index].cashbackAmount}',
                                //     style: const TextStyle(
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.w300,
                                //         color: Colors.red
                                //     ),
                                //   ),
                                // ),
                                const SizedBox(height: 3),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              addToCart.addProduct(
                                                AddToCartModel(
                                                    id: int.parse("${widget.productDataModel[index].productSlNo}"),
                                                    productName: widget.productDataModel[index].productName,
                                                    brandName:  widget.productDataModel[index].relationbrand?.brandName,
                                                    image: widget.productDataModel[index].mainImage,
                                                    quantity: int.parse("${widget.productDataModel[index].brand}"),
                                                    slug: widget.productDataModel[index].slug,
                                                    discountPrice: double.parse(widget.productDataModel[index].onlineDiscount)
                                                )
                                                // AddToCartModel(
                                                //   id: int.parse(widget.productDataModel[index].productSlNo).toInt(),
                                                //   productName: widget.productDataModel[index].productName,
                                                //   image: widget.productDataModel[index].mainImage,
                                                //   mainPrice: double.parse(widget.productDataModel[index].mainPrice).toDouble(),
                                                //   salePrice: double.parse(widget.productDataModel[index].salePrice).toDouble(),
                                                //   purchaseRate: widget.productDataModel[index].purchaseRate,
                                                //   cashBackAmount: widget.productDataModel[index].cashbackAmount,
                                                //   cashBackPercent: widget.productDataModel[index].cashbackPercent,
                                                //   quantity: int.parse(widget.productDataModel[index].qty),
                                                //   slug: "${widget.productDataModel[index].slug}", discountPrice: '',
                                                //
                                                // ),
                                              );
                                              Utils.showSnackBar(context, "Product added to Cart");
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              // color: Colors.pink,
                                                borderRadius: BorderRadius.circular(5),
                                                border:
                                                Border.all(width: 1, color: Colors.pink)),
                                            child: const Text(
                                              "Add cart",
                                              style: TextStyle(color: Colors.pink),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(
                                              slug: widget.productDataModel[index].slug,
                                              productId: widget.productDataModel[index].productSlNo.toString(),
                                              )));
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: const Color(0xff3399FF),
                                                  width: 1,
                                                )),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Buy now",
                                              style: TextStyle(color: Color(0xff3399FF)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },childCount: widget.productDataModel.length),),
          ),
          const SliverToBoxAdapter(
            child: BigBuyFooter(),
          ),
        ],
      )

      // body: FutureBuilder(
      //   future: Provider.of<all_product_provider>(context, listen: false).getAllProduct(context),
      //   builder: (context, snapshot) {
      //     if(snapshot.hasData){
      //       return CustomScrollView(
      //         slivers: [
      //           SliverPadding(
      //             padding: const EdgeInsets.only(
      //               top: 10,
      //               bottom: 0,
      //               left: 10,
      //               right: 10,
      //             ),
      //             sliver: SliverGrid(
      //               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //                 maxCrossAxisExtent: 300,
      //                 mainAxisSpacing: 16,
      //                 crossAxisSpacing: MediaQuery.of(context).size.width*0.04,
      //                 mainAxisExtent: 250,
      //               ),
      //               delegate: SliverChildBuilderDelegate((context, index){
      //                 return InkWell(
      //                   onTap: () {
      //                     Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(
      //                       slug: snapshot.data![index].slug,
      //                     ),));
      //                   },
      //                   child: Card(
      //                     elevation: 8.0,
      //                     shape: const RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.only(
      //                             topRight: Radius.circular(20),
      //                             topLeft: Radius.circular(20)
      //                         )
      //                     ),
      //                     child: Container(
      //                       decoration: BoxDecoration(
      //                           color: const Color.fromARGB(255, 230, 230, 230),
      //                           borderRadius: BorderRadius.circular(10)),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Container(
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(20),
      //                               color: const Color(0xFFeeeeee),
      //                             ),
      //                             child: Stack(
      //                               children: [
      //                                 Container(
      //                                   height: 150,
      //                                   width: 200,
      //                                   child: CustomImage(
      //                                     path: "$baseUrl/uploads/products/small_image/${snapshot.data![index].mainImage}",
      //                                     fit: BoxFit.fill,
      //                                   ),
      //                                 ),
      //                                 Visibility(
      //                                   visible: snapshot.data![index].cashbackPercent!='0.00',
      //                                   child: Positioned(
      //                                       top: 10,
      //                                       right: 10,
      //                                       child: Container(
      //                                         color: Colors.blue,
      //                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      //                                         child: Text(
      //                                           "${snapshot.data![index].cashbackPercent}%",
      //                                           style: const TextStyle(fontSize: 12,color: Colors.white),),
      //                                       )),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           const SizedBox(height: 9),
      //                           Container(
      //                             padding: const EdgeInsets.only(left: 3, right: 3),
      //                             child: Column(
      //                               mainAxisAlignment: MainAxisAlignment.start,
      //                               crossAxisAlignment: CrossAxisAlignment.start,
      //                               children: [
      //                                 Text(
      //                                   snapshot.data![index].productName,
      //                                   overflow: TextOverflow.ellipsis,
      //                                   //my change
      //                                   style: const TextStyle(
      //                                     color: Color(0xFF212121),
      //                                     fontWeight: FontWeight.w500,
      //                                     fontSize: 12,
      //                                   ),
      //                                 ),
      //                                 const SizedBox(height: 5),
      //                                 Row(
      //                                   children: [
      //                                     const Text(
      //                                       'Price :',
      //                                       style: TextStyle(
      //                                           fontSize: 12,
      //                                           fontWeight: FontWeight.bold,
      //                                           color: Color(0xFF212121)),
      //                                     ),
      //                                     Text(
      //                                       "${double.parse(snapshot.data![index].mainPrice)}",
      //                                       style: const TextStyle(
      //                                           fontSize: 13,
      //                                           fontWeight: FontWeight.w500,
      //                                           color: Color(0xFF212121)),
      //                                     ),
      //                                     const SizedBox(
      //                                       width: 5,
      //                                     ),
      //                                     // Text(
      //                                     //   '৳${allProductList[index].mainPrice}',
      //                                     //   style: const TextStyle(
      //                                     //     fontSize: 12,
      //                                     //     fontWeight: FontWeight.w300,
      //                                     //     color: Color(0xFF212121),
      //                                     //     decoration: TextDecoration.lineThrough,
      //                                     //   ),
      //                                     // ),
      //                                   ],
      //                                 ),
      //                                 const SizedBox(height: 5),
      //                                 Container(
      //                                   width: double.infinity,
      //                                   child: Row(
      //                                     children: [
      //                                       Expanded(
      //                                         child: InkWell(
      //                                           onTap: (){
      //                                             setState(() {
      //                                               addToCart.addProduct(
      //                                                 AddToCartModel(
      //                                                   id: int.parse(snapshot.data![index].productSlNo).toInt(),
      //                                                   productName: snapshot.data![index].productName,
      //                                                   image: snapshot.data![index].mainImage,
      //                                                   mainPrice: double.parse(snapshot.data![index].mainPrice).toDouble(),
      //                                                   salePrice: double.parse(snapshot.data![index].salePrice).toDouble(),
      //                                                   purchaseRate: snapshot.data![index].purchaseRate,
      //                                                   cashBackAmount: snapshot.data![index].cashbackAmount,
      //                                                   cashBackPercent: snapshot.data![index].cashbackPercent,
      //                                                   colorId: snapshot.data![index].colors[0].colorId??"",
      //                                                   sizeId: snapshot.data![index].sizeData[0].sizeId??"",
      //                                                   quantity: int.parse(snapshot.data![index].qty),
      //                                                   slug: "${snapshot.data?[index].slug}",
      //
      //                                                 ),
      //                                               );
      //                                               Utils.showSnackBar(context, "Product added to Cart");
      //                                             });
      //                                           },
      //                                           child: Container(
      //                                             height: 30,
      //                                             alignment: Alignment.center,
      //                                             decoration: BoxDecoration(
      //                                               // color: Colors.pink,
      //                                                 borderRadius: BorderRadius.circular(5),
      //                                                 border:
      //                                                 Border.all(width: 1, color: Colors.pink)),
      //                                             child: const Text(
      //                                               "Add cart",
      //                                               style: TextStyle(color: Colors.pink),
      //                                             ),
      //                                           ),
      //                                         ),
      //                                       ),
      //                                       const SizedBox(
      //                                         width: 10,
      //                                       ),
      //                                       Expanded(
      //                                         child: InkWell(
      //                                           onTap: () {
      //                                             Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(slug: snapshot.data![index].slug),));
      //                                           },
      //                                           child: Container(
      //                                             height: 30,
      //                                             decoration: BoxDecoration(
      //                                                 borderRadius: BorderRadius.circular(5),
      //                                                 border: Border.all(
      //                                                   color: const Color(0xff3399FF),
      //                                                   width: 1,
      //                                                 )),
      //                                             alignment: Alignment.center,
      //                                             child: const Text(
      //                                               "Buy now",
      //                                               style: TextStyle(color: Color(0xff3399FF)),
      //                                             ),
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 )
      //                               ],
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               },childCount: snapshot.data!.length),),
      //           ),
      //           const SliverToBoxAdapter(
      //             child: BigBuyFooter(),
      //           ),
      //         ],
      //       );
      //     }
      //     else if(snapshot.connectionState == ConnectionState.waiting){
      //       return Center(child: CircularProgressIndicator(),);
      //     }
      //     else{
      //       return SizedBox();
      //     }
      //   }
      // ),
    );
  }
}












// import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
// import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
// import 'package:al_barakah_e_mart/screens/One_Product_Details/product_details_screen.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';
// import 'package:al_barakah_e_mart/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../all_api_model/all_products_model.dart';
// import '../../footer_section/about_section.dart';

// class AllProductPage extends StatefulWidget {
//   const AllProductPage({Key? key, required this.productDataModel, required this.productName}) : super(key: key);
//   final String productName;
//   final List<AllProductModel> productDataModel;
//   ///====
//   // final String productName;
//   // final List<ProductDataModel> productDataModel;


//   @override
//   State<AllProductPage> createState() => _AllProductPageState();
// }

// class _AllProductPageState extends State<AllProductPage> {

//   @override
//   Widget build(BuildContext context) {
//     // final allProductList = Provider.of<All_Product_Provider>(context).allproductlist;
//     final addToCart = Provider.of<AddToCartProvider>(context, listen: true);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         // scrolledUnderElevation: 0,
//         backgroundColor: scaffoldColor,
//         foregroundColor: Colors.black,
//         title: Text(widget.productName,
//           style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//         leading: GestureDetector(onTap: () {
//           // MainController().naveListener.sink.add(0);
//           Navigator.pop(context);
//         },child: const Icon(Icons.arrow_back_outlined)),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverPadding(
//             padding: const EdgeInsets.only(
//               top: 10,
//               bottom: 0,
//               left: 10,
//               right: 10,
//             ),
//             sliver: SliverGrid(
//               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 300,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: MediaQuery.of(context).size.width*0.04,
//                 mainAxisExtent: 275,
//               ),
//               delegate: SliverChildBuilderDelegate((context, index){
//                 return InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(
//                       slug: widget.productDataModel[index].slug,
//                     ),));
//                   },
//                   child: Card(
//                     elevation: 8.0,
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(20),
//                             topLeft: Radius.circular(20)
//                         )
//                     ),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 230, 230, 230),
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: const Color(0xFFeeeeee),
//                             ),
//                             child: Stack(
//                               children: [
//                                 SizedBox(
//                                   height: 150,
//                                   width: 200,
//                                   child: CustomImage(
//                                     path: "$baseUrl/uploads/products/small_image/${widget.productDataModel[index].image}",
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                                 // Visibility(
//                                 //   visible: widget.productDataModel[index].cashbackPercent!='0.00',
//                                 //   child: Positioned(
//                                 //       top: 10,
//                                 //       right: 10,
//                                 //       child: Container(
//                                 //         color: Colors.blue,
//                                 //         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                                 //         child: Text(
//                                 //           "${widget.productDataModel[index].cashbackPercent}%",
//                                 //           style: const TextStyle(fontSize: 12,color: Colors.white),),
//                                 //       )),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Container(
//                             padding: const EdgeInsets.only(left: 3, right: 3),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   widget.productDataModel[index].name,
//                                   overflow: TextOverflow.ellipsis,
//                                   //my change
//                                   style: const TextStyle(
//                                     color: Color(0xFF212121),
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 3),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Code: ${widget.productDataModel[index].productCode}',
//                                       style: const TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0xFF212121)),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 3),
//                                 Text(
//                                   'MRP: ${widget.productDataModel[index].discountPrice}',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w300,
//                                     color: Colors.blue,
//                                   ),
//                                 ),
//                                 // Visibility(
//                                 //   visible: widget.productDataModel[index].cashbackAmount!="0.00",
//                                 //   child: Text(
//                                 //     'Cashback: ${widget.productDataModel[index].cashbackAmount}',
//                                 //     style: const TextStyle(
//                                 //         fontSize: 12,
//                                 //         fontWeight: FontWeight.w300,
//                                 //         color: Colors.red
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 const SizedBox(height: 3),
//                                 SizedBox(
//                                   width: double.infinity,
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: InkWell(
//                                           onTap: (){
//                                             setState(() {
//                                               addToCart.addProduct(
//                                                 AddToCartModel(
//                                                     id: int.parse("${widget.productDataModel[index].id}"),
//                                                     productName: widget.productDataModel[index].name,
//                                                     image: widget.productDataModel[index].image,
//                                                     quantity: int.parse("${widget.productDataModel[index].quantity}"),
//                                                     slug: widget.productDataModel[index].slug,
//                                                     discountPrice: double.parse(widget.productDataModel[index].discountPrice)
//                                                 )
//                                                 // AddToCartModel(
//                                                 //   id: int.parse(widget.productDataModel[index].productSlNo).toInt(),
//                                                 //   productName: widget.productDataModel[index].productName,
//                                                 //   image: widget.productDataModel[index].mainImage,
//                                                 //   mainPrice: double.parse(widget.productDataModel[index].mainPrice).toDouble(),
//                                                 //   salePrice: double.parse(widget.productDataModel[index].salePrice).toDouble(),
//                                                 //   purchaseRate: widget.productDataModel[index].purchaseRate,
//                                                 //   cashBackAmount: widget.productDataModel[index].cashbackAmount,
//                                                 //   cashBackPercent: widget.productDataModel[index].cashbackPercent,
//                                                 //   quantity: int.parse(widget.productDataModel[index].qty),
//                                                 //   slug: "${widget.productDataModel[index].slug}", discountPrice: '',
//                                                 //
//                                                 // ),
//                                               );
//                                               Utils.showSnackBar(context, "Product added to Cart");
//                                             });
//                                           },
//                                           child: Container(
//                                             height: 30,
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               // color: Colors.pink,
//                                                 borderRadius: BorderRadius.circular(5),
//                                                 border:
//                                                 Border.all(width: 1, color: Colors.pink)),
//                                             child: const Text(
//                                               "Add cart",
//                                               style: TextStyle(color: Colors.pink),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       Expanded(
//                                         child: InkWell(
//                                           onTap: () {
//                                             Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(slug: widget.productDataModel[index].slug),));
//                                           },
//                                           child: Container(
//                                             height: 30,
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(5),
//                                                 border: Border.all(
//                                                   color: const Color(0xff3399FF),
//                                                   width: 1,
//                                                 )),
//                                             alignment: Alignment.center,
//                                             child: const Text(
//                                               "Buy now",
//                                               style: TextStyle(color: Color(0xff3399FF)),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },childCount: widget.productDataModel.length),),
//           ),
//           const SliverToBoxAdapter(
//             child: BigBuyFooter(),
//           ),
//         ],
//       )

//       // body: FutureBuilder(
//       //   future: Provider.of<all_product_provider>(context, listen: false).getAllProduct(context),
//       //   builder: (context, snapshot) {
//       //     if(snapshot.hasData){
//       //       return CustomScrollView(
//       //         slivers: [
//       //           SliverPadding(
//       //             padding: const EdgeInsets.only(
//       //               top: 10,
//       //               bottom: 0,
//       //               left: 10,
//       //               right: 10,
//       //             ),
//       //             sliver: SliverGrid(
//       //               gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//       //                 maxCrossAxisExtent: 300,
//       //                 mainAxisSpacing: 16,
//       //                 crossAxisSpacing: MediaQuery.of(context).size.width*0.04,
//       //                 mainAxisExtent: 250,
//       //               ),
//       //               delegate: SliverChildBuilderDelegate((context, index){
//       //                 return InkWell(
//       //                   onTap: () {
//       //                     Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(
//       //                       slug: snapshot.data![index].slug,
//       //                     ),));
//       //                   },
//       //                   child: Card(
//       //                     elevation: 8.0,
//       //                     shape: const RoundedRectangleBorder(
//       //                         borderRadius: BorderRadius.only(
//       //                             topRight: Radius.circular(20),
//       //                             topLeft: Radius.circular(20)
//       //                         )
//       //                     ),
//       //                     child: Container(
//       //                       decoration: BoxDecoration(
//       //                           color: const Color.fromARGB(255, 230, 230, 230),
//       //                           borderRadius: BorderRadius.circular(10)),
//       //                       child: Column(
//       //                         crossAxisAlignment: CrossAxisAlignment.start,
//       //                         children: [
//       //                           Container(
//       //                             decoration: BoxDecoration(
//       //                               borderRadius: BorderRadius.circular(20),
//       //                               color: const Color(0xFFeeeeee),
//       //                             ),
//       //                             child: Stack(
//       //                               children: [
//       //                                 Container(
//       //                                   height: 150,
//       //                                   width: 200,
//       //                                   child: CustomImage(
//       //                                     path: "$baseUrl/uploads/products/small_image/${snapshot.data![index].mainImage}",
//       //                                     fit: BoxFit.fill,
//       //                                   ),
//       //                                 ),
//       //                                 Visibility(
//       //                                   visible: snapshot.data![index].cashbackPercent!='0.00',
//       //                                   child: Positioned(
//       //                                       top: 10,
//       //                                       right: 10,
//       //                                       child: Container(
//       //                                         color: Colors.blue,
//       //                                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//       //                                         child: Text(
//       //                                           "${snapshot.data![index].cashbackPercent}%",
//       //                                           style: const TextStyle(fontSize: 12,color: Colors.white),),
//       //                                       )),
//       //                                 ),
//       //                               ],
//       //                             ),
//       //                           ),
//       //                           const SizedBox(height: 9),
//       //                           Container(
//       //                             padding: const EdgeInsets.only(left: 3, right: 3),
//       //                             child: Column(
//       //                               mainAxisAlignment: MainAxisAlignment.start,
//       //                               crossAxisAlignment: CrossAxisAlignment.start,
//       //                               children: [
//       //                                 Text(
//       //                                   snapshot.data![index].productName,
//       //                                   overflow: TextOverflow.ellipsis,
//       //                                   //my change
//       //                                   style: const TextStyle(
//       //                                     color: Color(0xFF212121),
//       //                                     fontWeight: FontWeight.w500,
//       //                                     fontSize: 12,
//       //                                   ),
//       //                                 ),
//       //                                 const SizedBox(height: 5),
//       //                                 Row(
//       //                                   children: [
//       //                                     const Text(
//       //                                       'Price :',
//       //                                       style: TextStyle(
//       //                                           fontSize: 12,
//       //                                           fontWeight: FontWeight.bold,
//       //                                           color: Color(0xFF212121)),
//       //                                     ),
//       //                                     Text(
//       //                                       "${double.parse(snapshot.data![index].mainPrice)}",
//       //                                       style: const TextStyle(
//       //                                           fontSize: 13,
//       //                                           fontWeight: FontWeight.w500,
//       //                                           color: Color(0xFF212121)),
//       //                                     ),
//       //                                     const SizedBox(
//       //                                       width: 5,
//       //                                     ),
//       //                                     // Text(
//       //                                     //   '৳${allProductList[index].mainPrice}',
//       //                                     //   style: const TextStyle(
//       //                                     //     fontSize: 12,
//       //                                     //     fontWeight: FontWeight.w300,
//       //                                     //     color: Color(0xFF212121),
//       //                                     //     decoration: TextDecoration.lineThrough,
//       //                                     //   ),
//       //                                     // ),
//       //                                   ],
//       //                                 ),
//       //                                 const SizedBox(height: 5),
//       //                                 Container(
//       //                                   width: double.infinity,
//       //                                   child: Row(
//       //                                     children: [
//       //                                       Expanded(
//       //                                         child: InkWell(
//       //                                           onTap: (){
//       //                                             setState(() {
//       //                                               addToCart.addProduct(
//       //                                                 AddToCartModel(
//       //                                                   id: int.parse(snapshot.data![index].productSlNo).toInt(),
//       //                                                   productName: snapshot.data![index].productName,
//       //                                                   image: snapshot.data![index].mainImage,
//       //                                                   mainPrice: double.parse(snapshot.data![index].mainPrice).toDouble(),
//       //                                                   salePrice: double.parse(snapshot.data![index].salePrice).toDouble(),
//       //                                                   purchaseRate: snapshot.data![index].purchaseRate,
//       //                                                   cashBackAmount: snapshot.data![index].cashbackAmount,
//       //                                                   cashBackPercent: snapshot.data![index].cashbackPercent,
//       //                                                   colorId: snapshot.data![index].colors[0].colorId??"",
//       //                                                   sizeId: snapshot.data![index].sizeData[0].sizeId??"",
//       //                                                   quantity: int.parse(snapshot.data![index].qty),
//       //                                                   slug: "${snapshot.data?[index].slug}",
//       //
//       //                                                 ),
//       //                                               );
//       //                                               Utils.showSnackBar(context, "Product added to Cart");
//       //                                             });
//       //                                           },
//       //                                           child: Container(
//       //                                             height: 30,
//       //                                             alignment: Alignment.center,
//       //                                             decoration: BoxDecoration(
//       //                                               // color: Colors.pink,
//       //                                                 borderRadius: BorderRadius.circular(5),
//       //                                                 border:
//       //                                                 Border.all(width: 1, color: Colors.pink)),
//       //                                             child: const Text(
//       //                                               "Add cart",
//       //                                               style: TextStyle(color: Colors.pink),
//       //                                             ),
//       //                                           ),
//       //                                         ),
//       //                                       ),
//       //                                       const SizedBox(
//       //                                         width: 10,
//       //                                       ),
//       //                                       Expanded(
//       //                                         child: InkWell(
//       //                                           onTap: () {
//       //                                             Navigator.push(context, MaterialPageRoute(builder: (context) => One_Product_Details(slug: snapshot.data![index].slug),));
//       //                                           },
//       //                                           child: Container(
//       //                                             height: 30,
//       //                                             decoration: BoxDecoration(
//       //                                                 borderRadius: BorderRadius.circular(5),
//       //                                                 border: Border.all(
//       //                                                   color: const Color(0xff3399FF),
//       //                                                   width: 1,
//       //                                                 )),
//       //                                             alignment: Alignment.center,
//       //                                             child: const Text(
//       //                                               "Buy now",
//       //                                               style: TextStyle(color: Color(0xff3399FF)),
//       //                                             ),
//       //                                           ),
//       //                                         ),
//       //                                       ),
//       //                                     ],
//       //                                   ),
//       //                                 )
//       //                               ],
//       //                             ),
//       //                           ),
//       //                         ],
//       //                       ),
//       //                     ),
//       //                   ),
//       //                 );
//       //               },childCount: snapshot.data!.length),),
//       //           ),
//       //           const SliverToBoxAdapter(
//       //             child: BigBuyFooter(),
//       //           ),
//       //         ],
//       //       );
//       //     }
//       //     else if(snapshot.connectionState == ConnectionState.waiting){
//       //       return Center(child: CircularProgressIndicator(),);
//       //     }
//       //     else{
//       //       return SizedBox();
//       //     }
//       //   }
//       // ),
//     );
//   }
// }
