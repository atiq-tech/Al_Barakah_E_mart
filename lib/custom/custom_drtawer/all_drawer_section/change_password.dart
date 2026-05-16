import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/api_integration/me/change_password_api.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  SharedPreferences? sharedPreferences;
  Future<void> _initializeData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    customerId = "${sharedPreferences?.getString('id')}";
    print("User Information   customerId:$customerId");

  }
  String? customerId = "";
  double textFontSize = 16.0;
  bool isLoading = false;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }
  void _toggle3() {
    setState(() {
      _obscureText3 = !_obscureText3;
    });
  }

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _initializeData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(onPressed:(){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back),
        ),
        title: Text("Change Password",style: GoogleFonts.poppins(
          fontSize: 18.sp,
          fontStyle: FontStyle.italic,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
      ),
      backgroundColor: scaffoldColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.r),
            child: Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15.r)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Old Password", style: AllTextStyle.textFieldtitleStyle),
                  SizedBox(height: 6.h),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: oldPassController,
                        obscureText: _obscureText1,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter old password",
                            hintStyle: AllTextStyle.textValueStyle,
                            contentPadding: EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0, right: 0.0),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                            enabledBorder:TextFieldInputBorder.focusEnabledBorder,
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText1 ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                _toggle1();
                              },
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'The old password field is required.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text("New Password", style: AllTextStyle.textFieldtitleStyle),
                  const SizedBox(height: 6,),
                  SizedBox(
                    child: TextFormField(
                      controller: newPassController,
                      obscureText: _obscureText2,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Enter new password",
                          hintStyle: AllTextStyle.textValueStyle,
                          contentPadding: const EdgeInsets.only(left: 10.0),
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                          enabledBorder:TextFieldInputBorder.focusEnabledBorder,
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText2 ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              _toggle2();
                            },
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'The new password field is required.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text("Confirm Password", style: AllTextStyle.textFieldtitleStyle),
                  const SizedBox(height: 6),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: confirmPassController,
                        obscureText: _obscureText3,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Enter confirm password",
                            hintStyle: AllTextStyle.textValueStyle,
                            contentPadding: const EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0, right: 0.0),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                            enabledBorder:TextFieldInputBorder.focusEnabledBorder,
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText3 ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                _toggle3();
                              },
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'The Confirm password field is required.';
                          }else if(newPassController.text!=confirmPassController.text){
                            return "Confirm Password doesn't matched";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Align(
                  alignment: Alignment.centerRight,
                  child:
                      ElevatedButton(
                        onPressed: () {
                        if(formKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });
                          PasswordChangeApi.fetchPasswordChange(
                            oldPassController.text,
                            newPassController.text,
                            context).then((value){
                            if(value!='Old password does not match.'){
                              setState(() {
                                isLoading = false;
                              });
                              CustomSnackBar.showTopSnackBar(context, value);
                              Navigator.pop(context);
                            }else{
                              setState(() {
                                isLoading = false;
                              });
                              Utils.showTopSnackBar(context, value);
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.infinity, 32.h),
                        padding: EdgeInsets.all(5.r),
                        backgroundColor: const Color(0xff84BA40)
                      ),
                      child: isLoading ? const CircularProgressIndicator(color: Colors.white,)
                      : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Text("UPDATE CHANGE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
