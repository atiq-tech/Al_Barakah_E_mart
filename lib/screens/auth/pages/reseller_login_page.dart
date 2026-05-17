// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:al_barakah_e_mart/screens/auth/pages/reseller_signin_page.dart';
// import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
// import 'package:al_barakah_e_mart/utils/utils.dart';

// class ResellerLoginPage extends StatefulWidget {
//   const ResellerLoginPage({super.key});

//   @override
//   State<ResellerLoginPage> createState() => _ResellerLoginPageState();
// }

// class _ResellerLoginPageState extends State<ResellerLoginPage> {

//   final TextEditingController _phoneControllerLogin = TextEditingController();
//   final TextEditingController _passwordControllerLogin = TextEditingController();

//   bool _isResellerLogin = false;

//   /// 🔥 NEW: password visibility state
//   bool _isPasswordVisible = false;

//   @override
//   void dispose() {
//     _phoneControllerLogin.dispose();
//     _passwordControllerLogin.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: appBarColor,
//         title: Text("RESELLER LOGIN", style: AllTextStyle.appbarTextStyle),
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
//           },
//           child: const Icon(Icons.arrow_back,color: Colors.white)),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: EdgeInsets.only(top: 30.h),
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('images/rsc.png'),
//               fit: BoxFit.cover,
//               opacity: 0.9),
//         ),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(10.r),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(20.r),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.r),
//                     color: Colors.black.withOpacity(0.7),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       /// TEXT
//                       Center(
//                         child: Column(
//                           children: [
//                             Text(
//                               "Happy to see you sir!",
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.orange,
//                               ),
//                             ),
//                             SizedBox(height: 5.h),
//                             Text(
//                               "Login here to access your seller account.",
//                               style: TextStyle(color: Colors.white, fontSize: 14.sp),
//                             ),
//                           ],
//                         ),
//                       ),

//                       Divider(color: Colors.orange, thickness: 1.h),

//                       SizedBox(height: 10.h),

//                       /// PHONE
//                       _loginTextField(
//                         "Phone",
//                         "Enter Your Phone Number",
//                         _phoneControllerLogin,
//                         isRequired: true,
//                       ),

//                       SizedBox(height: 15.h),

//                       /// PASSWORD (UPDATED)
//                       _loginTextField(
//                         "Password",
//                         "Enter Your Password",
//                         _passwordControllerLogin,
//                         isRequired: true,
//                         isPassword: true,
//                       ),

//                       SizedBox(height: 15.h),

//                       /// BUTTON
//                       SizedBox(
//                         width: double.infinity,
//                         height: 35.h,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               _isResellerLogin = true;
//                             });
//                             Utils.closeKeyBoard(context);
//                             fetchResellerLogin();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange.shade600,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5.r)),
//                           ),
//                           child: _isResellerLogin
//                               ? const CircularProgressIndicator(color: Colors.white)
//                               : Text("Submit",
//                               style: TextStyle(color: Colors.white, fontSize: 16.sp)),
//                         ),
//                       ),

//                       SizedBox(height: 10.h),

//                       /// REGISTER
//                       Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text("Already have an account? ",
//                                 style: TextStyle(color: Colors.white)),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ResellerSigninPage()),
//                                 );
//                               },
//                               child: const Text(
//                                 "Register here",
//                                 style: TextStyle(
//                                     color: Colors.orange,
//                                     fontWeight: FontWeight.bold),
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
//         ),
//       ),
//     );
//   }

//   /// 🔥 UPDATED TEXTFIELD
//   Widget _loginTextField(
//       String label,
//       String hint,
//       TextEditingController controller,
//       {bool isRequired = false, bool isPassword = false}) {

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [

//         RichText(
//           text: TextSpan(
//             text: label,
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12),
//             children: isRequired
//                 ? [const TextSpan(text: ' *', style: TextStyle(color: Colors.red))]
//                 : [],
//           ),
//         ),

//         SizedBox(height: 8),

//         SizedBox(
//           height: 45,
//           child: TextField(
//             controller: controller,

//             /// 🔥 PASSWORD TOGGLE LOGIC
//             obscureText: isPassword ? !_isPasswordVisible : false,

//             style: const TextStyle(color: Colors.white),

//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),

//               /// 🔥 EYE ICON
//               suffixIcon: isPassword
//                   ? IconButton(
//                 icon: Icon(
//                   _isPasswordVisible
//                       ? Icons.visibility
//                       : Icons.visibility_off,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     _isPasswordVisible = !_isPasswordVisible;
//                   });
//                 },
//               )
//                   : null,

//               contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 0),

//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),

//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),

//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//                 borderSide: const BorderSide(color: Colors.orange),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   fetchResellerLogin() async {
//   SharedPreferences? sharedPreferences;
//   String link = "${BaseUrl}customer/login";
  
//   try {
//     final formData = FormData.fromMap({
//       "login": _phoneControllerLogin.text.trim(),
//       "password": _passwordControllerLogin.text.trim()
//     });
    
//     final response = await Dio().post(link, data: formData);
//     var item = response.data;
    
//     // Success Case (Status 200)
//     if (item["status"] == true) {
//       setState(() { _isResellerLogin = false; });

//       var customer = item["data"]["customer"];
//       String userName = "${customer["Customer_Name"] ?? ""}";

//       GetStorage().write("name", userName);

//       sharedPreferences = await SharedPreferences.getInstance();
//       sharedPreferences.setString('token', "${item["data"]["access_token"]}");
//       sharedPreferences.setString('name', "${customer["Customer_Name"] ?? ""}");
//       sharedPreferences.setString('email', "${customer["Customer_Email"] ?? ""}");
//       sharedPreferences.setString('phone', "${customer["Customer_Phone"] ?? ""}");
//       sharedPreferences.setString('address', "${customer["Customer_Address"] ?? ""}");
//       sharedPreferences.setString('image', "${customer["image_name"] ?? ""}");
//       sharedPreferences.setString('id', "${customer["Customer_SlNo"]}");
//       sharedPreferences.setString('auth_type', "${customer["auth_type"]}");
      
//       CustomSnackBar.showTopSnackBar(context, "Reseller Login successfully!");
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
//     } 
//   } on DioError catch (e) {
//     // এখানে 401 বা অন্যান্য এরর হ্যান্ডেল হবে
//     setState(() { _isResellerLogin = false; });
    
//     if (e.response != null) {
//       // এপিআই থেকে আসা মেসেজটি এখানে ধরা হবে
//       var errorData = e.response?.data;
//       String errorMessage = errorData["message"] ?? "Something went wrong";
//       Utils.showTopSnackBar(context, errorMessage);
//       print("API Error Message: $errorMessage");
//     } else {
//       Utils.showTopSnackBar(context, "Connection Error!");
//     }
//   } catch (e) {
//     setState(() { _isResellerLogin = false; });
//     print("General Error: $e");
//   }
// }
// }









// // class _ResellerLoginPageState extends State<ResellerLoginPage> {
// //   final TextEditingController _phoneControllerLogin = TextEditingController();
// //   final TextEditingController _passwordControllerLogin = TextEditingController();
 
// // @override
// // void dispose() {
// //   _phoneControllerLogin.dispose();
// //   _passwordControllerLogin.dispose();
// //   super.dispose();
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: appBarColor,
// //         title: Text("RESELLER LOGIN", style: AllTextStyle.appbarTextStyle),
// //         centerTitle: true,
// //       //   leading: GestureDetector(
// //       //     onTap: () {
// //       //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
// //       //     },
// //       //     child: const Icon(Icons.arrow_back,color: Colors.white)),
// //       ),
// //       body: Container(
// //         height: double.infinity,
// //         width: double.infinity,
// //         padding: EdgeInsets.only(top: 30.h),
// //         decoration: BoxDecoration(
// //           image: DecorationImage(image: AssetImage('images/rsc.png'), fit: BoxFit.cover, opacity: 0.9),
// //         ),
// //         child: SingleChildScrollView(
// //           padding: EdgeInsets.all(10.r),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Expanded(
// //                 flex: 1,
// //                 child: Container(
// //                   padding: EdgeInsets.all(20.r),
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(10.r),
// //                     color: Colors.black.withOpacity(0.7),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                        Center(
// //                         child: Column(
// //                           children: [
// //                             Text(
// //                               "Happy to see you sir!",
// //                               style: TextStyle(
// //                                 fontSize: 18.sp,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Colors.orange,
// //                               ),
// //                               textAlign: TextAlign.center,
// //                             ),
// //                             SizedBox(height: 5.h),
// //                             Text(
// //                               "Login here to access your seller account.",
// //                               style: TextStyle(color: Colors.white, fontSize: 14.sp),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       Divider(color: Colors.orange, thickness: 1.h, height: 10.h),
// //                       SizedBox(height: 10.h),
// //                       // Form Fields
// //                       Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start, // Sob kichu bam dik theke shuru hobe
// //                         children: [
// //                           // E-Mail/Phone Field
// //                           _loginTextField(
// //                             "Phone", 
// //                             "Enter Your Phone Number", 
// //                             _phoneControllerLogin, 
// //                             isRequired: true
// //                           ),
                          
// //                           SizedBox(height: 15.h), // Duito field-er majhe vertical gap
                          
// //                           // Password Field
// //                           _loginTextField(
// //                             "Password", 
// //                             "Enter Your Password", 
// //                             _passwordControllerLogin, 
// //                             isRequired: true, 
// //                             isPassword: true
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: 15.h),
// //                       // Submit Button
// //                       SizedBox(
// //                         width: double.infinity,
// //                         height: 35.h,
// //                         child: ElevatedButton(
// //                           onPressed: () {
// //                             setState(() {
// //                               _isResellerLogin = true;
// //                             });
// //                             Utils.closeKeyBoard(context);
// //                             fetchResellerLogin();
// //                           },
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: Colors.orange.shade600,
// //                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
// //                           ),
// //                           child: _isResellerLogin ? const CircularProgressIndicator(color: Colors.white) : Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
// //                         ),
// //                       ),
// //                       SizedBox(height: 10.h),
// //                       Center(
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             const Text("Already have an account? ",style: TextStyle(color: Colors.white)),
// //                             GestureDetector(
// //                               onTap: () {
// //                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ResellerSigninPage())); 
// //                               },
// //                               child: const Text(
// //                                 "Register here",
// //                                 style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //   bool _isResellerLogin = false;
// //   fetchResellerLogin() async {
// //   SharedPreferences? sharedPreferences;
// //   String link = "${BaseUrl}customer/login";
// //   try {
// //     final formData = FormData.fromMap({
// //       "login": _phoneControllerLogin.text.trim(),
// //       "password": _passwordControllerLogin.text.trim()
// //     });
// //     final response = await Dio().post(link, data: formData);
// //     var item = response.data;
// //     print('sgjliklsdfg $item');
    
// //     if (item["error"] == "Unauthorized") {
// //       setState(() {
// //         _isResellerLogin = false;
// //       });
// //       Utils.errorSnackBar(context, "User Not Found");
// //     } 
// //     else if (item["status"] == true) {
// //       setState(() {
// //         _isResellerLogin = false;
// //       });

// //       // === Corrected: use "customer" instead of "user"
// //       var customer = item["data"]["customer"];
// //       String userName = "${customer["Customer_Name"] ?? ""}";

// //       // Save in GetStorage if needed
// //       GetStorage().write("name", userName);

// //       // Save in SharedPreferences
// //       sharedPreferences = await SharedPreferences.getInstance();
// //       sharedPreferences.setString('token', "${item["data"]["access_token"]}");
// //       sharedPreferences.setString('name', "${customer["Customer_Name"] ?? ""}");
// //       sharedPreferences.setString('email', "${customer["Customer_Email"] ?? ""}");
// //       sharedPreferences.setString('phone', "${customer["Customer_Phone"] ?? ""}");
// //       sharedPreferences.setString('address', "${customer["Customer_Address"] ?? ""}");
// //       sharedPreferences.setString('image', "${customer["image_name"] ?? ""}");
// //       sharedPreferences.setString('id', "${customer["Customer_SlNo"]}");
// //       sharedPreferences.setString('auth_type', "${customer["auth_type"]}");
// //       Utils.showSnackBar(context, "Reseller Login successfully!");
// //       // Navigate to dashboard
// //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
      
    
// //     } else {
// //       setState(() {
// //         _isResellerLogin = true;
// //       });
// //     }
// //   } catch (e) {
// //     setState(() {
// //       _isResellerLogin = false;
// //     });
// //     print("Error message $e");
// //   }
// // }

// // ///==== Login TextField Widget ====///
// // Widget _loginTextField(
// //     String label, 
// //     String hint, 
// //     TextEditingController controller, // Notun parameter
// //     {bool isRequired = false, bool isPassword = false}) {
// //   return Column(
// //     crossAxisAlignment: CrossAxisAlignment.start, // Label ebong field bam dik theke shuru hobe
// //     mainAxisSize: MainAxisSize.min,
// //     children: [
// //       // Label Part
// //       RichText(
// //         text: TextSpan(
// //           text: label,
// //           style: TextStyle(
// //             color: Colors.white, 
// //             fontWeight: FontWeight.bold, 
// //             fontSize: 12
// //           ),
// //           children: isRequired ? [const TextSpan(text: ' *', style: TextStyle(color: Colors.red))]
// //               : [],
// //         ),
// //       ),
// //       SizedBox(height: 8), // Label ar TextField-er majhe gap
      
// //       // TextField Part
// //       SizedBox(
// //         height: 45, // 30.h ektu choto hoye jay, standard 45-50 rakha bhalo
// //         child: TextField(
// //           controller: controller, // Controller ekhane set kora holo
// //           obscureText: isPassword,
// //           style: const TextStyle(color: Colors.white), // User ja likhbe seta white hobe
// //           decoration: InputDecoration(
// //             hintText: hint,
// //             hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
// //             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(5),
// //               borderSide: BorderSide(color: Colors.grey.shade300),
// //             ),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(5),
// //               borderSide: BorderSide(color: Colors.grey.shade300),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(5),
// //               borderSide: const BorderSide(color: Colors.orange), // Focus korle orange border
// //             ),
// //           ),
// //         ),
// //       ),
// //     ],
// //   );
// // }
// // }