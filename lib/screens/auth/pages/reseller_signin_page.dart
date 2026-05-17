// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:al_barakah_e_mart/screens/auth/pages/reseller_login_page.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
// import 'package:al_barakah_e_mart/utils/utils.dart';

// class ResellerSigninPage extends StatefulWidget {
//   const ResellerSigninPage({super.key});

//   @override
//   State<ResellerSigninPage> createState() => _ResellerSigninPageState();
// }

// class _ResellerSigninPageState extends State<ResellerSigninPage> {
 
//   // Controller declaration
// final TextEditingController _nameController = TextEditingController();
// final TextEditingController _phoneController = TextEditingController();
// final TextEditingController _shopNameController = TextEditingController();
// final TextEditingController _shopPhoneController = TextEditingController();
// final TextEditingController _addressController = TextEditingController();
// final TextEditingController _nidController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();

// @override
// void dispose() {
//   _nameController.dispose();
//   _phoneController.dispose();
//   _shopNameController.dispose();
//   _shopPhoneController.dispose();
//   _addressController.dispose();
//   _nidController.dispose();
//   _emailController.dispose();
//   _passwordController.dispose();
//   super.dispose();
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: appBarColor,
//         title:Text("RESELLER REGISTRATION", style: AllTextStyle.appbarTextStyle),
//         centerTitle: true,
//         // leading: GestureDetector(
//         //   onTap: () {
//         //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
//         //   },
//         //   child: const Icon(Icons.arrow_back,color: Colors.white)),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: EdgeInsets.only(top: 20.h),
//         decoration: BoxDecoration(
//           image: DecorationImage(image: AssetImage('images/rsc.png'), fit: BoxFit.cover, opacity: 0.9),
//         ),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(10.r),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   padding: EdgeInsets.all(20.r),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.r),
//                     color: Colors.black.withOpacity(0.7),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                        Center(
//                         child: Column(
//                           children: [
//                             Text(
//                               "WANT TO BE A RESELLER ON THIS PLATFORM!",
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(height: 5.h),
//                             Text(
//                               "Register now. It's free and easy to join.",
//                               style: TextStyle(color: Colors.white, fontSize: 14.sp),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Divider(color: Colors.orange, thickness: 1.h, height: 10.h),
//                       SizedBox(height: 10.h),
//                       // Form Fields
//                      Row(
//                       children: [
//                         Expanded(child: _registerTextField("Your Name", "Enter Your Name", _nameController, isRequired: true)),
//                         SizedBox(width: 20.r),
//                         Expanded(child: _registerTextField("Your Phone", "Enter Your Phone No", _phoneController, isRequired: true)),
//                       ],
//                     ),
//                       SizedBox(height: 15.h),
//                       Row(
//                         children: [
//                           Expanded(child: _registerTextField("Shop Name", "Enter Shop Name", _shopNameController, isRequired: true)),
//                           SizedBox(width: 10.r),
//                           Expanded(child: _registerTextField("Shop Phone", "Enter Shop Phone No", _shopPhoneController, isRequired: true)),
//                         ],
//                       ),
//                       SizedBox(height: 10.h),
//                       Row(
//                         children: [
//                           Expanded(child: _registerTextField("Shop Address", "Enter Shop Address", _addressController, isRequired: true)),
//                           SizedBox(width: 10.r),
//                           Expanded(child: _registerTextField("NID Number", "Enter NID Number", _nidController, isRequired: true)),
//                         ],
//                       ),
//                       SizedBox(height: 10.h),
//                       Row(
//                         children: [
//                           Expanded(child: _registerTextField("E-Mail Address", "Enter Reseller E-Mail"  , _emailController, isRequired: true)),
//                           SizedBox(width: 10.r),
//                           Expanded(child: _registerTextField("Password", "Enter Reseller Password", _passwordController, isRequired: true, isPassword: true)),
//                         ],
//                       ),
//                       SizedBox(height: 15.h),
//                       // Submit Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 35.h,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Utils.closeKeyBoard(context);
//                               fetchResellerRegister();
//                               setState(() {
//                                 isResellerRegister = true;
//                               });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange.shade600,
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
//                           ),
//                           child: isResellerRegister
//                             ? CircularProgressIndicator(color: Colors.white)
//                             :  Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
//                         ),
//                       ),
//                       SizedBox(height: 10.h),
//                       Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text("Already have an account? ",style: TextStyle(color: Colors.white)),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ResellerLoginPage()));
//                               },
//                               child: const Text(
//                                 "Login here",
//                                 style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ),
//     );
//   }

//   emptyMethod(){
//     _nameController.text = "";
//     _emailController.text = "";
//     _phoneController.text = "";
//     _passwordController.text = "";
//     _shopNameController.text = "";
//     _shopPhoneController.text = "";
//     _addressController.text = "";
//     _nidController.text = "";
//   }
// bool isResellerRegister = false;
//   fetchResellerRegister() async {
//     if (_passwordController.text.length < 4) {
//       setState(() {
//         //isLogInSelected = true;
//       });
//       Utils.showTopSnackBar(context, "The password must be at least 4 characters.");
//     }
//     String link = "${BaseUrl}reseller_registration";
//     try {
//       final formData = FormData.fromMap({
//         "name": _nameController.text.trim(),
//         "email": _emailController.text.trim(),
//         "phone": _phoneController.text.trim(),
//         "password": _passwordController.text.trim(),
//         "password_confirmation": "",
//         "shop_name": _shopNameController.text.trim(),
//         "shop_phone": _shopPhoneController.text.trim(),
//         "shop_address": _addressController.text.trim(),
//         "nid_number": _nidController.text.trim(),
//       });
//       // --- Eikhane print kora hoyeche ---
//     print('--- Sending Data to Server ---');
//     for (var element in formData.fields) {
//       print("${element.key}: ${element.value}");
//     }
//       final response = await Dio().post(link, data: formData);
//       var item = response.data;
//       print('register data $item');
//     if(item["status"] == true){
//       setState(() {
//         isResellerRegister = true;
//       });
//       emptyMethod();
//       CustomSnackBar.showTopSnackBar(context, "${item["message"]}! Please Log in here");
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ResellerLoginPage()));
//     } else{
//       setState(() {
//         isResellerRegister = true;
//       });
//       Utils.showTopSnackBar(context, "${item["message"]}");
//     }
//     }catch(e){
//       print('$e');
//     }
//   }

//  Widget _registerTextField(String label, String hint, TextEditingController controller, {bool isRequired = false, bool isPassword = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       RichText(
//         text: TextSpan(
//           text: label,
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),
//           children: isRequired
//               ? [const TextSpan(text: ' *', style: TextStyle(color: Colors.red))]
//               : [],
//         ),
//       ),
//       SizedBox(height: 8.h),
//       SizedBox(
//         height: 35.h, 
//         child: TextField(
//           controller: controller, 
//           obscureText: isPassword,
//           style: const TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12.sp),
//             contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.r),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.r),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.r),
//               borderSide: const BorderSide(color: Colors.orange),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
//  }
// }