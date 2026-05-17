import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BigBuyFooter extends StatefulWidget {
   const BigBuyFooter({super.key});
  @override
  State<BigBuyFooter> createState() => _BigBuyFooterState();
}

class _BigBuyFooterState extends State<BigBuyFooter> {
  List itemColors = [Colors.green, Colors.purple, Colors.blue];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width ;
    var screenWidthh = MediaQuery.of(context).size.width/35;
    return Container(
      padding:const EdgeInsets.all(0.0),
      decoration: const BoxDecoration(
      color: Color(0xff221F1F),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w),
            child: Text("Al Barakah E-mart",
              style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ))),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text("152/2k Green Road, Dhanmondi, Dhaka-1205 Mobile : 01717202623",
            textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ))),
          ),
          // GestureDetector(
          //   onTap: () => _launchPhone("+8801711514200"),
          //   child: Container(
          //     height: 35.h,
          //     width: 220.w,
          //     padding: EdgeInsets.only(left: 15.w),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(100.r),
          //       border: Border.all(color: Colors.white)
          //     ),
          //     child: Row(children: [
          //       Icon(Icons.call,size: 18.sp,color: Colors.white),
          //       SizedBox(width: 10.w),
          //       Container(
          //         height: 20.h,
          //         width: 1.w,
          //         color: Colors.white
          //       ),
          //       SizedBox(width: 10.w),
          //       GestureDetector(
          //         onTap: () => _launchPhone("+8801711514200"),
          //         child: Text(
          //           "+8801711514200",
          //           style: GoogleFonts.poppins(
          //           textStyle: TextStyle(
          //             fontSize: 14.sp ,
          //             color: tcolor,
          //           ),
          //         ),
          //         ),
          //       ),
          //     ],),
          //   ),
          // ),
          // SizedBox(height: 10.w),
          // GestureDetector(
          //   onTap: () {
          //     launchWebUrl(url: "https://tltelecom.com/find-our-store");
          //   },
          //   child: Container(
          //     width: 220.w,
          //     padding: EdgeInsets.only(left: 15.w),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(100.r),
          //       border: Border.all(color: Colors.white)
          //     ),
          //     child: Row(children: [
          //       Icon(Icons.location_pin,size: 18.sp,color: Colors.white),
          //       SizedBox(width: 10.w),
          //       Container(
          //         height: 20.h,
          //         width: 1.w,
          //         color: Colors.white
          //       ),
          //       SizedBox(width: 10.w),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Store Locator",
          //             style: GoogleFonts.poppins(
          //             textStyle: TextStyle(
          //               fontSize: 10.sp ,
          //               color: tcolor,
          //             ),
          //           ),
          //           ),
          //           Text(
          //             "Find Our Stores",
          //             style: GoogleFonts.poppins(
          //             textStyle: TextStyle(
          //               fontSize: 12.sp ,
          //               color: tcolor,
          //             ),
          //           ),
          //           ),
          //         ],
          //       ),
          //     ],),
          //   ),
          // ),
          SizedBox(height: 10.w),
          Text("Social Link",
          textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ))),
          SizedBox(height: 0.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              socialCircleIcon(
                imagePath: "images/fb.png",
                url: "https://www.facebook.com/tltelecom",
                radius: 15.r,
              ),
              SizedBox(width: 10.w),
              socialCircleIcon(
                imagePath: "images/youtube.png",
                url: "https://www.youtube.com/tltelecom",
                radius: 15.r,
              ),
              SizedBox(width: 10.w),
              socialCircleIcon(
                imagePath: "images/linkedin.png",
                url: "https://www.linkdin.com/tltelecom",
                radius: 15.r,
              ),
              SizedBox(width: 10.w),
              socialCircleIcon(
                imagePath: "images/instagram.png",
                url: "https://www.instagram.com/tltelecom",
                radius: 15.r,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w,right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Information Link',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: screenWidth / 30,
                              fontWeight: FontWeight.w500,
                               color: Colors.white,
                            ),
                          ),
                        ),
                        footerTextLink(
                          title: 'About Us',
                          url: 'https://www.albarakahemart.com/about-us',
                          fontSize: screenWidthh,
                          color: tcolor,
                          height: height,
                        ),

                        footerTextLink(
                          title: 'Contact Us',
                          url: 'https://www.albarakahemart.com/contact',
                          fontSize: screenWidthh,
                          color: tcolor,
                          height: height,
                        ),
                        footerTextLink(
                          title: 'Our Management',
                          url: 'https://www.albarakahemart.com/about-us#management',
                          fontSize: screenWidthh,
                          color: tcolor,
                          height: height,
                        ),

                        footerTextLink(
                          title: 'Our Mission & Vision',
                          url: 'https://www.albarakahemart.com/about-us#mission',
                          fontSize: screenWidthh,
                          color: tcolor,
                          height: height,
                        ),
                      ],
                    ),
                  ),
                  //------------------ My Account ----------------
                  Container(
                    margin: EdgeInsets.only(left: 20.w,right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Us',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: screenWidth / 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Phone: 017#########',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: screenWidthh,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'Email: @gmail.com',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: screenWidthh,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: appBarColor,
                        //     borderRadius: BorderRadius.circular(5.r),
                        //     border: Border.all(color: Colors.white)
                        //   ),
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                        //     child: Text(
                        //      "Deliveryman Login",
                        //       style: GoogleFonts.poppins(
                        //         textStyle: TextStyle(
                        //           fontSize: screenWidthh,
                        //           color: tcolor,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Text(""),
                        SizedBox(height: 5.h),
                        Text("")
                      ],
                    ),
                  ),
                 ],
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffBDBDBD),
            child: Column(
              children: [
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Design & Developed By ',
                      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: screenWidth / 40,color: appBarColor),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launchWebUrl(url: "http://linktechbd.com/");
                      },
                      child: Text(
                        'Link-Up Technology Ltd',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(decoration: TextDecoration.underline,fontSize: screenWidth / 40,color: Colors.blue.shade700),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:3.h),
                Text(
                  'All Rights Researved ©2026 Al Barakah E-mart. All rights reserved.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(textStyle: TextStyle(fontSize:screenWidth / 40,color: appBarColor)),
                ),
                SizedBox(height: 55.h)
              ],
            ),
          )
        ],
      ),
    );
  }

  double height = 20.h;
  Color  tcolor = Colors.white;
  Color  ccolor = Colors.black;
  launchWebUrl({url}) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
 void _launchPhone(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(uri);
  }

  Widget socialCircleIcon({
  required String imagePath,
  required String url,
  required double radius,
  Color backgroundColor = const Color.fromARGB(255, 59, 53, 51),
  EdgeInsets padding = const EdgeInsets.all(6),
}) {
  return GestureDetector(
    onTap: () {
      launchWebUrl(url: url);
    },
    child: CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      child: Padding(
        padding: padding,
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
Widget footerTextLink({
  required String title,
  required String url,
  required double fontSize,
  required Color color,
  double height = 20,
}) {
  return SizedBox(
    height: height,
    child: GestureDetector(
      onTap: () {
        launchWebUrl(url: url);
      },
      child: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: fontSize,
            color: color,
          ),
        ),
      ),
    ),
  );
 }
}














// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

// class BigBuyFooter extends StatefulWidget {
//    const BigBuyFooter({super.key});
//   @override
//   State<BigBuyFooter> createState() => _BigBuyFooterState();
// }

// class _BigBuyFooterState extends State<BigBuyFooter> {
//   List itemColors = [Colors.green, Colors.purple, Colors.blue];

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width ;
//     var screenWidthh = MediaQuery.of(context).size.width/35;
//     return Container(
//       padding:const EdgeInsets.all(0.0),
//       decoration: const BoxDecoration(
//       color: Color(0xff221F1F),
//         // image: DecorationImage(
//         //   image: AssetImage('images/fbg.jpg'), // Replace with your image asset path
//         //   fit: BoxFit.cover,
//         // ),
//       ),
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 10),
//           Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   "images/tmlogo.png",
//                   width: screenWidth / 9,
//                 ),
//                 const SizedBox(width: 5),
//                 const Text("TL Telecom Shop",
//                   style: TextStyle(color: Colors.orange,fontSize: 16.0,fontWeight: FontWeight.w500),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),

//           Container(
//             padding: const EdgeInsets.all(10),
//             child: const Text("The idea goes back to 1972, when the King of Bhutan, Jigme Singye Wangchuck, said that we should measure a country's progress by its happiness...",
//               style: TextStyle(color: Colors.white),
//               textAlign: TextAlign.center,
//             ),
//           ),

//           // SizedBox(
//           //   height: 100,
//           //     width: double.infinity,
//           //     child: CarouselSlider(
//           //       items: List.generate(sliderImages.length, (index) {
//           //         return SizedBox(
//           //           // height: 0,
//           //           width: double.infinity,
//           //           child: CustomImage(
//           //             path: "$baseUrl/uploads/brands/${sliderImages[index].image}",
//           //             fit: BoxFit.cover,
//           //           ),
//           //         );
//           //       }),
//           //       options: CarouselOptions(
//           //         viewportFraction: 0.4,
//           //         initialPage: 0,
//           //         enableInfiniteScroll: true,
//           //         reverse: false,
//           //         autoPlay: true,
//           //         autoPlayInterval: const Duration(seconds: 1),
//           //         autoPlayAnimationDuration: const Duration(milliseconds: 700),
//           //         autoPlayCurve: Curves.fastOutSlowIn,
//           //         enlargeCenterPage: true,
//           //         enlargeFactor: 0.5,
//           //         scrollDirection: Axis.horizontal,
//           //       ),
//           //     )
//           // ),

//           // Container(margin: const EdgeInsets.only(left: 20),
//           //   child: Align(
//           //     alignment: Alignment.centerLeft,
//           //     child: Text(
//           //       'Social Media',
//           //       style: GoogleFonts.poppins(
//           //         textStyle: TextStyle(
//           //           fontSize: screenWidth / 24,
//           //           color:Colors.white,
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           // const SizedBox(
//           //   height: 5.0,
//           // ),
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //   children: [
//           //     GestureDetector(
//           //       onTap: () {
//           //         launchWebUrl(url: "https://www.facebook.com/bigbuy.bangladesh.official");
//           //       },
//           //       child: Image.asset(
//           //         "images/fb.png",
//           //         width: screenWidth / 11,
//           //       ),
//           //     ),
//           //     const SizedBox(
//           //       width: 3.0,
//           //     ),
//           //     GestureDetector(
//           //       onTap: () {
//           //         launchWebUrl(url: "https://bestbazarshop.com/www.youtube.com/@BestBazer");
//           //       },
//           //       child: Image.asset(
//           //         "images/youtube.png",
//           //         width: screenWidth / 11,
//           //       ),
//           //     ),
//           //     const SizedBox(
//           //       width: 3.0,
//           //     ),
//           //     GestureDetector(
//           //       onTap: () {
//           //         launchWebUrl(url: "https://twitter.com/bigbuy_store/");
//           //       },
//           //       child: Image.asset(
//           //         "images/twitter.png",
//           //         width: screenWidth / 11,
//           //       ),
//           //     ),
//           //     ///===old===
//           //     // const SizedBox(
//           //     //   width: 3.0,
//           //     // ),
//           //     // GestureDetector(
//           //     //   onTap: () {
//           //     //     launchWebUrl(url: "https://www.linkedin.com/company/bigbuy/");
//           //     //   },
//           //     //   child: Image.asset(
//           //     //     "images/linkedin.png",
//           //     //     width: screenWidth / 11,
//           //     //   ),
//           //     // ),
//           //     const SizedBox(
//           //       width: 3.0,
//           //     ),
//           //     GestureDetector(
//           //       onTap: () {
//           //         launchWebUrl(url: "https://www.instagram.com/bigbuy_official/");
//           //       },
//           //       child: Image.asset(
//           //         "images/instagram.png",
//           //         width: screenWidth / 11,
//           //       ),
//           //     ),
//           //     ///===old===
//           //     // const SizedBox(
//           //     //   width: 3.0,
//           //     // ),
//           //     // GestureDetector(
//           //     //   onTap: () {
//           //     //     launchWebUrl(url: "https://www.pinterest.com/bigbuy_store/");
//           //     //   },
//           //     //   child: Image.asset(
//           //     //     "images/pinterest.png",
//           //     //     width: screenWidth / 11,
//           //     //   ),
//           //     // ),
//           //   ],
//           // ),
//           // SizedBox(height: 20,),
//           /*Container(
//             margin: const EdgeInsets.only(
//               left: 20
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               'Got Question? Call us 24/7',
//               style: GoogleFonts.poppins(
//                 textStyle: TextStyle(
//                   fontSize: screenWidth / 25,
//                   color: tcolor,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 5.0,
//           ),
//           Container(
//             margin: const EdgeInsets.only(
//               left: 20,
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               '01944996633',
//               style: GoogleFonts.poppins(
//                 textStyle: TextStyle(
//                   fontSize: screenWidth / 25,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Container(
//             margin: const EdgeInsets.only(
//               left: 20,
//             ),
//             child: Text(
//               'Payment Method',
//               style: GoogleFonts.poppins(
//                 textStyle: TextStyle(
//                   fontSize: screenWidth / 25,
//                   color:tcolor,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 5.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Image.asset(
//                 "images/visa.png",
//                 width: screenWidth / 11,
//               ),
//               const SizedBox(
//                 width: 5.0,
//               ),
//               Image.asset(
//                 "images/mastercard.jpg",
//                 width: screenWidth / 11,
//               ),
//               const SizedBox(
//                 width: 5.0,
//               ),
//               Image.asset(
//                 "images/paypal.png",
//                 width: screenWidth / 11,
//               ),
//               const SizedBox(
//                 width: 5.0,
//               ),
//               Image.asset(
//                 "images/american_express.png",
//                 width: screenWidth / 11,
//               ),
//               const SizedBox(
//                 width: 5.0,
//               ),
//               Image.asset(
//                 "images/apple_pay.png",
//                 width: screenWidth / 11,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),*/
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
//             child: Column(
//               children: [
//                 Text("Stay Connected",
//                   style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                     fontSize: screenWidth / 30,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.orange,
//                   ),
//                 ),),
//                 const SizedBox(height: 10),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(child: Text("TL TELECOM Ltd Wholesale Dealer",
//                       style: GoogleFonts.poppins(
//                         textStyle: TextStyle(
//                           fontSize: screenWidthh ,
//                           color: tcolor,
//                         ),
//                       ),
//                     ),
//                     ),
//                     Expanded(child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             launchUrl(Uri(
//                               scheme: 'mailto',
//                               path: 'Bestbazarshope@Gmail.Com',
//                               // query: 'subject=App Feedback&body=App Version 3.23',
//                             ));
//                           },
//                           child: Text("Email: tltelecom@gmail.com",
//                             style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                               fontSize: screenWidthh ,
//                               color: tcolor,
//                             ),
//                           ),),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             launchUrl(Uri(
//                               scheme: "tel",
//                               path: "+8801728677276"
//                               ));
//                           },
//                           child: Text("+8801728677276",
//                             style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                               fontSize: screenWidthh ,
//                               color: tcolor,
//                             ),
//                           ),),
//                         ),
//                         // GestureDetector(
//                         //   onTap: () {
//                         //     launchUrl(Uri(
//                         //         scheme: "tel",
//                         //         path: "+880 1944996633"
//                         //     ));
//                         //   },
//                         //   child: Text("+880 1944996633",
//                         //     style: GoogleFonts.poppins(
//                         //     textStyle: TextStyle(
//                         //       fontSize: screenWidthh ,
//                         //       color: tcolor,
//                         //     ),
//                         //   ),),
//                         // ),
//                       ],
//                     ))
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Container(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                   Container(
//                     margin: const EdgeInsets.only(
//                       left: 20,
//                       right: 20,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'About Us',
//                           style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                               fontSize: screenWidth / 30,
//                               fontWeight: FontWeight.w400,
//                                color: Colors.orange,
//                             ),
//                           ),
//                         ),

//                         Container(
//                           height: height,
//                           child: GestureDetector(
//                             onTap: () {
//                               launchWebUrl(url: "https://tltelecom.com/about");
//                             },
//                             child: Text(
//                               'About Us',
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontSize: screenWidthh ,
//                                   color: tcolor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         Container(
//                           height: height,
//                           child: GestureDetector(
//                             onTap: () {
//                               launchWebUrl(url: "https://bestbazarshop.com/");
//                             },
//                             child: Text(
//                               'FAQ',
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontSize: screenWidthh ,
//                                   color: tcolor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         Container(
//                           height: height,
//                           child: GestureDetector(
//                             onTap: () {
//                               launchWebUrl(url: "https://bestbazarshop.com/contact-us");
//                             },
//                             child: Text(
//                               'Contact us',
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontSize: screenWidthh ,
//                                   color: tcolor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   //------------------ My Account ----------------
//                   Container(
//                     margin: const EdgeInsets.only(left: 20,right: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Policy',
//                           style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                               fontSize: screenWidth / 30,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.orange,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: height,
//                           child: GestureDetector(
//                             onTap: () {
//                               launchWebUrl(url: "https://bestbazarshop.com/customer/login");
//                             },
//                             child: Text(
//                               'Sign In',
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontSize: screenWidthh ,
//                                   color: tcolor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: height,
//                           child: GestureDetector(
//                             onTap: () {
//                               launchWebUrl(url: "https://bestbazarshop.com/product/carts");
//                             },
//                             child: Text(
//                               'View Cart',
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontSize: screenWidthh ,
//                                   color: tcolor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: height,
//                           child:  GestureDetector(
//                             onTap: () {
//                               launchWebUrl(url: "https://bestbazarshop.com/contact-us");
//                             },
//                             child: Text(
//                               'Help',
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontSize: screenWidthh ,
//                                   color:  tcolor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                       ],
//                     ),
//                   ),
//                   //----------------Support Section--------------
//                   Container(
//                     margin: const EdgeInsets.only(left: 20,right: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'SUPPORT',
//                           style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                               fontSize: screenWidth / 30,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.orange,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Text(
//                               "Hot Line:",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () => _launchPhone("${01711514200}"),
//                               child: Text(
//                                 "${01711514200}",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           height: height,
//                           child: GestureDetector(
//                             onTap: () {
//                               launchWebUrl(url: "https://bestbazarshop.com/product/carts");
//                             },
//                             child: Text(
//                               'View Cart',
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontSize: screenWidthh ,
//                                   color: tcolor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: height,
//                           child:  GestureDetector(
//                             onTap: () {
//                               launchWebUrl(url: "https://bestbazarshop.com/contact-us");
//                             },
//                             child: Text(
//                               'Help',
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontSize: screenWidthh ,
//                                   color:  tcolor,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                       ],
//                     ),
//                   ),
//                 ],),
//               ],
//             ),
//           ),
//           Container(
//             child: Column(
//               children: [
//                 const Divider(
//                   color: Colors.white,
//                 ),
//                 const SizedBox(
//                   height: 5.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Design & Developed By ',
//                       style: GoogleFonts.poppins(
//                         textStyle: TextStyle(
//                           fontSize: screenWidth / 40,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         launchWebUrl(url: "http://linktechbd.com/");
//                       },
//                       child: Text(
//                         'Link-Up Technology Ltd',
//                         style: GoogleFonts.poppins(
//                           textStyle: TextStyle(
//                             decoration: TextDecoration.underline,
//                             fontSize: screenWidth / 40,
//                             color: Colors.green.shade400,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height:3),
//                 Text(
//                   'Copyright © Best Bazar Shop All Right Reserved.',
//                   style: GoogleFonts.poppins(
//                     textStyle: const TextStyle(
//                       fontSize: 10,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );

//   }

//   double height=20;
//   Color  tcolor=Colors.white;
//   Color  ccolor=Colors.black;
//   launchWebUrl({url}) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri,mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//  void _launchPhone(String phoneNumber) async {
//     final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
//     await launchUrl(uri);
//   }
// }
