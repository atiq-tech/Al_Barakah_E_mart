import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/api_integration/me/change_profile_api.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../screens/auth/pages/signin_page.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String? userName = "";
  String? userEmail = "";
  String? userPhone = "";
  String? userAddress = "";
  String? userImage = "";
  String? customerId = "";

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  bool isLoading = false;
  File? file; // গ্যালারি থেকে সিলেক্ট করা ইমেজ ফাইল রাখার জন্য

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    setState(() {
      customerId = "${sharedPreferences.getString('id')}";
      userName = sharedPreferences.getString('name') ?? "";
      userEmail = sharedPreferences.getString('email') ?? "";
      userPhone = sharedPreferences.getString('phone') ?? "";
      userAddress = sharedPreferences.getString('address') ?? "";
      userImage = sharedPreferences.getString('image') ?? "";

      nameController.text = userName!;
      mobileController.text = userPhone!;
      emailController.text = userEmail!;
      addressController.text = userAddress!;
    });
    print("customer image===$userImage");
  }

  // গ্যালারি থেকে ইমেজ সিলেক্ট করার মেথড
  Future<void> chooseImageFrom() async {
    ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (imageFile != null) {
      setState(() {
        file = File(imageFile.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentCustomerId = "${sharedPreferences.getString('id')}";
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Update Profile",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontStyle: FontStyle.italic,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: scaffoldColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (currentCustomerId == "null" || currentCustomerId.isEmpty) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                },
                child: const Text("Sign in Please"),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Container(
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey.shade100),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔥 ১. প্রোফাইল পিকচার সিলেক্টর সেকশন (নতুন)
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: file != null
                                  ? FileImage(file!) as ImageProvider
                                  : (userImage != null && userImage!.isNotEmpty
                                      ? NetworkImage("${imageUrl}$userImage")
                                      : const AssetImage("images/placeholder.png")),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: chooseImageFrom,
                                child: CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: appBarColor,
                                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Name Field
                      Text('Name', style: AllTextStyle.LoginHeadTitle),
                      SizedBox(height: 6.h),
                      SizedBox(
                        height: 45.h,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 10.w),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: "Enter name",
                            hintStyle: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Email Field
                      Text('Email', style: AllTextStyle.LoginHeadTitle),
                      SizedBox(height: 6.h),
                      SizedBox(
                        height: 45.h,
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 10.w),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: "Enter email",
                            hintStyle: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Phone Field
                      Text('Phone', style: AllTextStyle.LoginHeadTitle),
                      SizedBox(height: 6.h),
                      SizedBox(
                        height: 45.h,
                        child: TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 10.w),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: "Enter mobile",
                            hintStyle: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // 🔥 ২. Address Field (নতুন যুক্ত করা হয়েছে)
                      Text('Address', style: AllTextStyle.LoginHeadTitle),
                      SizedBox(height: 6.h),
                      SizedBox(
                        height: 45.h,
                        child: TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 10.w),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: "Enter address",
                            hintStyle: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // 🔥 ৩. আপডেট করা সেভ বাটন মেথড কল
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 40.h),
                            padding: EdgeInsets.all(5.r),
                            backgroundColor: appBarColor,
                          ),
                          onPressed: () async {
                            if (nameController.text.trim().isEmpty) {
                              Utils.showTopSnackBar(context, "Name can't be empty");
                              return;
                            }
                            if (mobileController.text.trim().isEmpty) {
                              Utils.showTopSnackBar(context, "Phone number can't be empty");
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });

                            // আমাদের নতুন তৈরি করা FormData এপিআই মেথডটি এখানে সব ডাটা পাঠাবে
                            var res = await ProfileChangeApi.changeProfile(
                              name: nameController.text.trim(),
                              mobile: mobileController.text.trim(),
                              email: emailController.text.trim(),
                              address: addressController.text.trim(),
                              imageFile: file, // এটি সিলেক্ট করা ফাইলটি পাস করবে (নাল হতে পারে)
                            );

                            setState(() {
                              isLoading = false;
                            });

                            // সফলভাবে রেসপন্স হ্যান্ডেল করা
                            if (res == 'Profile Update successfully' || res == 'Profile updated successfully') {
                              CustomSnackBar.showTopSnackBar(context, res);
                              _initializeData(); // শেয়ার্ড প্রেফারেন্সের নতুন ডাটা রি-লোডের জন্য
                            } else {
                              Utils.showTopSnackBar(context, res);
                            }
                          },
                          child: isLoading
                              ? SizedBox(
                                  height: 18.h,
                                  width: 18.w,
                                  child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text("SAVE CHANGE", style: AllTextStyle.saveButtonTextStyle),
                                ),
                        ),
                      ),
                      SizedBox(height: 100.h)
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
















// import 'dart:io';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:al_barakah_e_mart/api_integration/me/change_profile_api.dart';
// import 'package:al_barakah_e_mart/main.dart';
// import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
// import 'package:al_barakah_e_mart/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../screens/auth/pages/signin_page.dart';

// class UpdateProfile extends StatefulWidget {
//   const UpdateProfile({super.key,
//    // required this.userProfileModel
//   });

// //  final UserProfileModel userProfileModel;

//   @override
//   State<UpdateProfile> createState() => _UpdateProfileState();
// }

// class _UpdateProfileState extends State<UpdateProfile> {
//   Future<void> _initializeData() async {
//     customerId = "${sharedPreferences.getString('id')}";
//     userName = "${sharedPreferences.getString('name')}";
//     userEmail = "${sharedPreferences.getString('email')}";
//     userPhone = "${sharedPreferences.getString('phone')}";
//     userAddress = "${sharedPreferences.getString('address')}";
//     userImage = "${sharedPreferences.getString('image')}";

//     print("User all Information   customerId:$customerId");
//     print("User all Information  Condition:${sharedPreferences.getString('id')}");
//     print("User all Information   userName:$userName\nuserEmail:$userEmail\nuserPhone:$userPhone\nuserAddress:$userAddress\nuserImage:$userImage");
//     nameController.text = userName!;
//     mobileController.text = userPhone!;
//     emailController.text = userEmail!;
//     addressController.text = userAddress!;
//   }
//   String? userName = "";
//   String? userEmail = "";
//   String? userPhone = "";
//   String? userAddress = "";
//   String? userImage = "";
//   String? customerId = "";

//   final nameController = TextEditingController();
//   final mobileController = TextEditingController();
//   final emailController = TextEditingController();
//   final addressController = TextEditingController();


//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//     // TODO: implement initState
//     // Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
//     ///====old====
//     addressController.text = userName!;
//     mobileController.text = userPhone!;
//     emailController.text = userEmail!;
//     addressController.text = userAddress!;
//     print("userName $userName");
//   }
//   String? selectedGender;
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final customerId = "${sharedPreferences.getString('id')}";
//    return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const MainScreen()));
//             // Navigator.pop(context);
//           },
//           child: const Icon(Icons.arrow_back),
//         ),
//         title: Text(
//           "Update Profile",
//           style: GoogleFonts.poppins(
//             fontSize: 18.sp,
//             fontStyle: FontStyle.italic,
//             letterSpacing: 1,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//         backgroundColor: scaffoldColor,
//         body: LayoutBuilder(
//           builder: (context, constraints) {
//             if (customerId == "null" ||customerId == "" ||customerId.isEmpty) {
//               return Center(
//                 child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
//                     },
//                     child: const Text("Sign in Please")),
//               );
//           }
//           else {
//           return SingleChildScrollView(
//               child: Padding(
//                   padding: EdgeInsets.all(10.r),
//                   child: Container(
//                     padding: EdgeInsets.all(15.r),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.blueGrey),
//                         borderRadius: BorderRadius.circular(15.r)),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Name',style: AllTextStyle.LoginHeadTitle),
//                           SizedBox(height: 6.h),
//                           SizedBox(
//                             height: 40.h,
//                             child: TextFormField(
//                               controller: nameController,
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 contentPadding: EdgeInsets.only(left: 10.w),
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(),
//                                 hintText: "Enter name",
//                                 hintStyle: TextStyle(fontSize: 14.sp),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return null;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 10.h),
//                           ///Email
//                           Text('Email',style: AllTextStyle.LoginHeadTitle),
//                           SizedBox(height: 6.h),
//                           SizedBox(
//                             height: 40.h,
//                             child: TextFormField(
//                               controller: emailController,
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 //enabled: false,
//                                 contentPadding: EdgeInsets.only(left: 10.w),
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(),
//                                 hintText: "Enter email",
//                                 hintStyle: TextStyle(fontSize: 14.sp),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return null;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 10.h),
//                           ///Mobile
//                            Text('Phone',style: AllTextStyle.LoginHeadTitle),
//                           SizedBox(height: 6.h),
//                           SizedBox(
//                             height: 40.h,
//                             child: TextFormField(
//                               controller: mobileController,
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 // enabled: false,
//                                 contentPadding: EdgeInsets.only(left: 10.w),
//                                 fillColor: Colors.white,
//                                 border: OutlineInputBorder(),
//                                 hintText: "Enter mobile",
//                                 hintStyle: TextStyle(fontSize: 14.sp),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return null;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 10.h),
//                           Align(
//                           alignment: Alignment.centerRight,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               fixedSize: Size(double.infinity, 30.h),
//                               padding: EdgeInsets.all(5.r),
//                               backgroundColor: applineColor,
//                             ),
//                             onPressed: () async {
//                               if (nameController.text.isEmpty) {
//                                 Utils.showTopSnackBar(context, "Name can't be empty");
//                                 return;
//                               }
//                               setState(() {
//                                 isLoading = true;
//                               });
//                               var res = await ProfileChangeApi.changeProfile(nameController.text);
//                               setState(() {
//                                 isLoading = false;
//                               });

//                               if (res == 'Profile updated successfully') {
//                                 CustomSnackBar.showTopSnackBar(context, res);
//                               } else {
//                                 Utils.showTopSnackBar(context, res);
//                               }
//                             },
//                             child: isLoading
//                                 ? SizedBox(height: 18.h,width: 18.w,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2))
//                                 : Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 10.w),
//                                     child: Text("SAVE CHANGE",style: AllTextStyle.saveButtonTextStyle),
//                                   ),
//                           ),
//                         ),
                        
//                         ],
//                       ),
//                     ),
//                   ))
//               );
//             }
//          }),
//     );
//   }

//   XFile? imageFile;
//   File? file;
//   chooseImageFrom() async {
//     ImagePicker picker = ImagePicker();
//     imageFile = await picker.pickImage(source: ImageSource.gallery);
//     file = File("${imageFile?.path}");
//     setState(() {});
//   }
//   String? firstPickedDate;
//   void selectedDate() async {
//     final selectedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(1950),
//         lastDate: DateTime(2050));
//     if (selectedDate != null) {
//       setState(() {
//         firstPickedDate = Utils.formatDate(selectedDate);
//         print("Firstdateee $firstPickedDate");
//       });
//     }
//   }
// }
