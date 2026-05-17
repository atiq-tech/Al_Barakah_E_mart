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
  const UpdateProfile({super.key,
   // required this.userProfileModel
  });

//  final UserProfileModel userProfileModel;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  Future<void> _initializeData() async {
    customerId = "${sharedPreferences.getString('id')}";
    userName = "${sharedPreferences.getString('name')}";
    userEmail = "${sharedPreferences.getString('email')}";
    userPhone = "${sharedPreferences.getString('phone')}";
    userAddress = "${sharedPreferences.getString('address')}";
    userImage = "${sharedPreferences.getString('image')}";

    print("User all Information   customerId:$customerId");
    print("User all Information  Condition:${sharedPreferences.getString('id')}");
    print("User all Information   userName:$userName\nuserEmail:$userEmail\nuserPhone:$userPhone\nuserAddress:$userAddress\nuserImage:$userImage");
    nameController.text = userName!;
    mobileController.text = userPhone!;
    emailController.text = userEmail!;
    addressController.text = userAddress!;
  }
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


  @override
  void initState() {
    super.initState();
    _initializeData();
    // TODO: implement initState
    // Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
    ///====old====
    addressController.text = userName!;
    mobileController.text = userPhone!;
    emailController.text = userEmail!;
    addressController.text = userAddress!;
    print("userName $userName");
  }
  String? selectedGender;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final customerId = "${sharedPreferences.getString('id')}";
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const MainScreen()));
            // Navigator.pop(context);
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
            if (customerId == "null" ||customerId == "" ||customerId.isEmpty) {
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                    },
                    child: const Text("Sign in Please")),
              );
          }
          else {
          return SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: Container(
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(15.r)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name',style: AllTextStyle.LoginHeadTitle),
                          SizedBox(height: 6.h),
                          SizedBox(
                            height: 40.h,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.only(left: 10.w),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: "Enter name",
                                hintStyle: TextStyle(fontSize: 14.sp),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          ///Email
                          Text('Email',style: AllTextStyle.LoginHeadTitle),
                          SizedBox(height: 6.h),
                          SizedBox(
                            height: 40.h,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                filled: true,
                                //enabled: false,
                                contentPadding: EdgeInsets.only(left: 10.w),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: "Enter email",
                                hintStyle: TextStyle(fontSize: 14.sp),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          ///Mobile
                           Text('Phone',style: AllTextStyle.LoginHeadTitle),
                          SizedBox(height: 6.h),
                          SizedBox(
                            height: 40.h,
                            child: TextFormField(
                              controller: mobileController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                // enabled: false,
                                contentPadding: EdgeInsets.only(left: 10.w),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: "Enter mobile",
                                hintStyle: TextStyle(fontSize: 14.sp),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(double.infinity, 30.h),
                              padding: EdgeInsets.all(5.r),
                              backgroundColor: applineColor,
                            ),
                            onPressed: () async {
                              if (nameController.text.isEmpty) {
                                Utils.showTopSnackBar(context, "Name can't be empty");
                                return;
                              }
                              setState(() {
                                isLoading = true;
                              });
                              var res = await ProfileChangeApi.changeProfile(nameController.text);
                              setState(() {
                                isLoading = false;
                              });

                              if (res == 'Profile updated successfully') {
                                CustomSnackBar.showTopSnackBar(context, res);
                              } else {
                                Utils.showTopSnackBar(context, res);
                              }
                            },
                            child: isLoading
                                ? SizedBox(height: 18.h,width: 18.w,child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2))
                                : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Text("SAVE CHANGE",style: AllTextStyle.saveButtonTextStyle),
                                  ),
                          ),
                        ),
                        
                        ],
                      ),
                    ),
                  ))
              );
            }
         }),
    );
  }

  XFile? imageFile;
  File? file;
  chooseImageFrom() async {
    ImagePicker picker = ImagePicker();
    imageFile = await picker.pickImage(source: ImageSource.gallery);
    file = File("${imageFile?.path}");
    setState(() {});
  }
  String? firstPickedDate;
  void selectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatDate(selectedDate);
        print("Firstdateee $firstPickedDate");
      });
    }
  }
}
