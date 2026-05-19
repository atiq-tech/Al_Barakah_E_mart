import 'dart:convert';
import 'package:al_barakah_e_mart/all_api_model/factory_model.dart';
import 'package:al_barakah_e_mart/all_api_provider/factory_provider.dart';
import 'package:al_barakah_e_mart/screens/auth/pages/forgot_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/app_privacy_policy_screen.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
import 'package:al_barakah_e_mart/utils/delivery_terms_and_condition_screen.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
   const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool isLogInSelected = true;
  bool isRegisterSelected = false;
  bool isSignInBtnLoading = false;
  bool isSignInGglBtnLoading = false;
  bool isSignUpBtnLoading = false;
  bool isSignObscure = true;
  bool isRegisterObscure = true;
  bool isRegisterCObscure = true;
  bool isError = false;
  String? customerType = 'regular';

  final phoneLogInCtrl = TextEditingController();
  final passLogInCtrl = TextEditingController();
  final nameRegCtrl = TextEditingController();
  final buildingRegCtrl = TextEditingController();
  final phoneRegCtrl = TextEditingController();
  final referenceRegCtrl = TextEditingController();
  final districtRegCtrl = TextEditingController();
  final thanaRegCtrl = TextEditingController();
  final areaRegCtrl = TextEditingController();
  final countryRegCtrl = TextEditingController();
  final passRegCtrl = TextEditingController();
  final streetAddressRegCtrl = TextEditingController();
  final factoryRegCtrl = TextEditingController();
  final departmentRegCtrl = TextEditingController();
  final employeeIdRegCtrl = TextEditingController();
  final nidRegCtrl = TextEditingController();
  final logInFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      Future.microtask(() {
        Provider.of<FactoryProvider>(context, listen: false).getFactory();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        backgroundColor: applineColor,
        title: Text(isLogInSelected==true?"CUSTOMER'S LOGIN":"CUSTOMER'S REGISTRATION",style: AllTextStyle.appbarTextStyle),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
          },
          child: const Icon(Icons.arrow_back,color: Colors.white)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 25.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(10.r)
                ),
                child: isLogInSelected==true? Image.asset("images/lbg.jpg",width: 180.w,height: 110.h,fit: BoxFit.fill):Image.asset("images/rbgr.png",width: 180.w,height: 110.h,fit: BoxFit.fill)
              ),
              
              SizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogInSelected = true;
                        isRegisterSelected = false;
                      });
                    },
                    child: Column(
                      children: [
                        Text("Login",style: TextStyle(
                          fontSize: 20.sp,fontWeight: FontWeight.bold,
                          color: isLogInSelected ? applineColor : Colors.black
                        ),textAlign: TextAlign.center,),
                        isLogInSelected ? Divider(color: applineColor,thickness: 2): Divider(color: appBarColor,thickness: 2)
                      ],
                    ),
                  )),
                  Expanded(child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogInSelected = false;
                        isRegisterSelected = true;
                      });
                    },
                    child: Column(
                      children: [
                        Text("Registration",style: TextStyle(
                          fontSize: 20.sp,fontWeight: FontWeight.bold,
                            color: isRegisterSelected ? applineColor : Colors.black
                        ),textAlign: TextAlign.center,),
                        isRegisterSelected ? Divider(color: applineColor,thickness: 2): Divider(color: appBarColor,thickness: 2)
                      ],
                    ),
                  ))
                ],
              ),
              SizedBox(height: 10.h),
              LayoutBuilder(builder: (context, constraints) {
                if(isLogInSelected){
                  return Form(
                    key: logInFormKey,
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Column(
                        children: [
                          ///Phone
                          SizedBox(height: 5.h),
                          Align(alignment: Alignment.centerLeft, child: Text("Phone",style:AllTextStyle.LoginHeadTitle)),
                          SizedBox(height: 6.h),
                          Visibility(
                            child: SizedBox(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: phoneLogInCtrl,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: "Enter phone number",
                                  hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.h),
                                    border: TextFieldInputBorder.focusEnabledBorder,
                                    focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                    enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100.r),
                                    borderSide: const BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if(value==''){
                                    return "Please Phone Number";
                                  }
                                  else{
                                    phoneLogInCtrl.text = value.toString().trim();
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          ///Password
                          SizedBox(height: 16.h),
                          Align(alignment: Alignment.centerLeft, child: Text("Password",style:AllTextStyle.LoginHeadTitle)),
                          SizedBox(height: 6.h),
                          SizedBox(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passLogInCtrl,
                              textInputAction: TextInputAction.done,
                              obscureText: isSignObscure,
                              decoration: InputDecoration(
                                hintText: "Enter your password",
                                hintStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.h),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignObscure = !isSignObscure;
                                    });
                                  },
                                    child: Icon(isSignObscure ? Icons.visibility : Icons.visibility_off),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                border: TextFieldInputBorder.focusEnabledBorder,
                                focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.r),
                                  borderSide: const BorderSide(color: Colors.red),
                                ),
                              ),
                              validator: (value) {
                                if(value==''){
                                  return "Please Enter Your Password";
                                }
                                else{
                                  passLogInCtrl.text = value.toString().trim();
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 30.h),
                          Visibility(
                            visible: isError,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Text("Invalid Phone Number or Password",style: TextStyle(color: Colors.red,fontSize: 16.sp)),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              if(logInFormKey.currentState!.validate()){
                                setState(() {
                                  isSignInBtnLoading = true;
                                });
                                Utils.closeKeyBoard(context);
                                fetchLogin();
                              }
                            },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appBarColor,
                                foregroundColor: Colors.red.shade700,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.r)
                                ),
                                elevation: 5,
                              ), child: isSignInBtnLoading ? const CircularProgressIndicator(color: Colors.white) :
                                   Text("Login",style: AllTextStyle.tableHeadTextStyle),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                              },
                              child: Text("  Forgot Password?",style: TextStyle(
                                color: applineColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp
                              )),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "By creating an account, you agree to the AL Barakah E-mart ",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 10.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: appBarColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const PrivacyPolicyScreen(),
                                        ),
                                      );
                                    },
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 10.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                TextSpan(
                                  text: "Delivery Terms & Conditions",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: appBarColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const DeliveryTermsScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                  );
                }
                else if(isRegisterSelected){
                  return Form(
                    key: signUpFormKey,
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Column(
                        children: [
                           Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Customer Type :", style: AllTextStyle.LoginHeadTitle),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      customerType = "regular";
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Radio(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                            fillColor: MaterialStateColor.resolveWith((states) => Colors.teal.shade900),
                                            value: "regular",
                                            groupValue: customerType,
                                            onChanged: (value) {
                                              setState(() {
                                                customerType = value.toString();
                                              });
                                            }),
                                      ),
                                      Text("Regular",style: AllTextStyle.LoginHeadTitle),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                       customerType = "member";
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Radio(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                            fillColor: MaterialStateColor.resolveWith((states) => Colors.teal.shade900),
                                            value: "member",
                                            groupValue: customerType,
                                            onChanged: (value) {
                                              setState(() {
                                                customerType = value.toString();
                                              });
                                            }),
                                      ),
                                      Text("Member",style: AllTextStyle.LoginHeadTitle),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                            children: [
                              Expanded(flex: 6,child: Text("Name",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: nameRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Enter name",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          customerType=="member" ? SizedBox(height: 3.h):SizedBox(height: 0.h),
                          customerType=="member" ? Row(
                            children: [
                              Expanded(flex: 6,child: Text("Factory",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Consumer<FactoryProvider>(
                                  builder: (context, provider, child) {
                                    final factoryList = provider.factoryList;

                                    return TypeAheadField<FactoryModel>(
                                      suggestionsCallback: (pattern) {
                                        return factoryList.where((item) {
                                          final name = item.branchName.toString().toLowerCase();
                                          return name.contains(pattern.toLowerCase());
                                        }).toList();
                                      },

                                      itemBuilder: (context, FactoryModel suggestion) {
                                        return ListTile(
                                          title: Text("${suggestion.branchName}"),
                                          subtitle: Text("${suggestion.branchId}"),
                                        );
                                      },

                                      onSelected: (FactoryModel suggestion) {
                                        factoryRegCtrl.text = suggestion.branchName ?? "";
                                        FocusScope.of(context).unfocus();
                                      },

                                      builder: (context, controller, focusNode) {
                                        return TextField(
                                          controller: factoryRegCtrl,
                                          focusNode: focusNode,
                                          style: AllTextStyle.dropDownlistStyle,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(left: 5.w),
                                            hintText: "Select factory",
                                            hintStyle: AllTextStyle.dropDownlistStyle,
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: InputBorder.none,
                                            focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                            enabledBorder: TextFieldInputBorder.focusEnabledBorder,
                                            suffixIcon: factoryRegCtrl.text.isEmpty
                                                ? null
                                                : GestureDetector(
                                                    onTap: () {
                                                      factoryRegCtrl.clear();
                                                    },
                                                    child: const Icon(Icons.close, size: 16),
                                                  ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )
                                ),
                              ),
                            ],
                          ):SizedBox(height: 0.h),
                          customerType=="member" ? SizedBox(height: 3.h):SizedBox(height: 0.h),
                          customerType=="member" ? Row(
                            children: [
                              Expanded(flex: 6,child: Text("Department",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: departmentRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Select department",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ):SizedBox(height: 0.h),
                          customerType=="member" ? SizedBox(height: 3.h):SizedBox(height: 0.h),
                          customerType=="member" ? Row(
                            children: [
                              Expanded(flex: 6,child: Text("Building",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: buildingRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Building name",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ):SizedBox(height: 0.h),
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Phone",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: phoneRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Enter phone number",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          customerType =="regular" ? Row(
                            children: [
                              Expanded(flex: 6,child: Text("Reference",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: referenceRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Enter Reference Name",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ):SizedBox(height: 0.h),
                          ///phone
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Password",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: passRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Enter password",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          customerType=="member" ? SizedBox(height: 3.h):SizedBox(height: 0.h),
                          customerType=="member" ? Row(
                            children: [
                              Expanded(flex: 6,child: Text("Employee ID",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: employeeIdRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Employee ID",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ):SizedBox(height: 0.h),
                          customerType=="member" ? SizedBox(height: 3.h):SizedBox(height: 0.h),
                          customerType=="member" ? Row(
                            children: [
                              Expanded(flex: 6,child: Text("National ID No",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: nidRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "National ID No",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ):SizedBox(height: 0.h),
                          SizedBox(height: 3.h),
                           Row(
                            children: [
                              Expanded(flex: 6,child: Text("District",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: districtRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Select district",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                           Row(
                            children: [
                              Expanded(flex: 6,child: Text("Thana",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: thanaRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Select thana",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Area",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 30.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: areaRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Select area",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ///phone
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Expanded(flex: 6,child: Text("Address",style:AllTextStyle.LoginHeadTitle)),
                              const Expanded(flex: 1, child: Text(":")),
                              Expanded(
                                flex: 13,
                                child: SizedBox(
                                  height: 40.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    style: AllTextStyle.dropDownlistStyle,
                                    controller: streetAddressRegCtrl,
                                    decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                      hintText: "Street address",
                                      hintStyle: AllTextStyle.dropDownlistStyle,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder:TextFieldInputBorder.focusEnabledBorder,
                                      enabledBorder:TextFieldInputBorder.focusEnabledBorder
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ), 
                          SizedBox(height: 20.h),
                          SizedBox(
                            height: 40.h,
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              if(signUpFormKey.currentState!.validate()){
                                  setState(() {
                                    isSignUpBtnLoading = true;
                                  });
                                  Utils.closeKeyBoard(context);
                                  fetchRegistration();
                              }
                            },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appBarColor,
                                foregroundColor: Colors.red.shade700,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.r)
                                ),
                                elevation: 5,
                              ), child: isSignUpBtnLoading ? const CircularProgressIndicator() :
                                 Text("Sign Up",style: AllTextStyle.tableHeadTextStyle),

                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "By creating an account, you agree to the AL Barakah E-mart ",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 10.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: GoogleFonts.aBeeZee(
                                  fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: appBarColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const PrivacyPolicyScreen(),
                                        ),
                                      );
                                    },
                                ),
                                TextSpan(
                                  text: " and ",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 10.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                TextSpan(
                                  text: "Delivery Terms & Conditions",
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: appBarColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const DeliveryTermsScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                  );
                }
                else{
                  return const SizedBox();
                }
              },)
            ],
          ),
        ),
      ),
    );
  }
  
  fetchLogin() async {
  SharedPreferences? sharedPreferences;
  String link = "${BaseUrl}customer/login";
  
  try {
    final formData = FormData.fromMap({
      "login": phoneLogInCtrl.text.trim(),
      "password": passLogInCtrl.text.trim()
    });
    
    final response = await Dio().post(link, data: formData);
    var item = response.data;
    
    // Success Case (Status 200)
    if (item["status"] == true) {
      setState(() { isSignInBtnLoading = false; });

      var customer = item["data"]["customer"];
      String userName = "${customer["Customer_Name"] ?? ""}";

      GetStorage().write("name", userName);

      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('token', "${item["data"]["access_token"]}");
      sharedPreferences.setString('name', "${customer["Customer_Name"] ?? ""}");
      sharedPreferences.setString('email', "${customer["Customer_Email"] ?? ""}");
      sharedPreferences.setString('phone', "${customer["Customer_Phone"] ?? ""}");
      sharedPreferences.setString('address', "${customer["Customer_Address"] ?? ""}");
      sharedPreferences.setString('image', "${customer["image_name"] ?? ""}");
      sharedPreferences.setString('id', "${customer["Customer_SlNo"]}");
      sharedPreferences.setString('auth_type', "${customer["auth_type"]}");
      
      CustomSnackBar.showTopSnackBar(context, "Reseller Login successfully!");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } 
  } on DioError catch (e) {
    // এখানে 401 বা অন্যান্য এরর হ্যান্ডেল হবে
    setState(() { isSignInBtnLoading = false; });
    
    if (e.response != null) {
      // এপিআই থেকে আসা মেসেজটি এখানে ধরা হবে
      var errorData = e.response?.data;
      String errorMessage = errorData["message"] ?? "Something went wrong";
      Utils.showTopSnackBar(context, errorMessage);
      print("API Error Message: $errorMessage");
    } else {
      Utils.showTopSnackBar(context, "Connection Error!");
    }
  } catch (e) {
    setState(() { isSignInBtnLoading = false; });
    print("General Error: $e");
  }
}

  fetchRegistration() async {
    if (passRegCtrl.text.length < 4) {
      setState(() {
        isSignUpBtnLoading = false;
        isLogInSelected = true;
      });
      Utils.showSnackBar(context, "The password must be at least 4 characters.");
    }
    String link = "${BaseUrl}customer_registration";
    print('--- Registration Data ---link: $link');
    try {
      final formData = FormData.fromMap({
        "name": nameRegCtrl.text.trim(),
        //"last_name": lastNameRegCtrl.text.trim(),
        //"email": emailRegCtrl.text.trim(),
        "phone": phoneRegCtrl.text.trim(),
        "password": passRegCtrl.text.trim(),
        //"password_confirmation": passCRegCtrl.text.trim(),
      });
    print('--- Sending Data to Server ---');
    for (var element in formData.fields) {
      print("${element.key}: ${element.value}");
    }
      final response = await Dio().post(link, data: formData);
      var item = response.data;
      print('register data $item');
    if(item["status"] == true){
      setState(() {
        isSignUpBtnLoading = false;
        isLogInSelected = true;
      });
      emptyMethod();
      CustomSnackBar.showTopSnackBar(context, item["message"]);
    } else{
      setState(() {
        isSignUpBtnLoading = false;
        isLogInSelected = true;
      });
      Utils.showTopSnackBar(context, "User Not created successfully");
    }
    }catch(e){
      print('$e');
    }
  }

  emptyMethod(){
    nameRegCtrl.text = "";
    areaRegCtrl.text = "";
    districtRegCtrl.text = "";
    employeeIdRegCtrl.text = "";
    phoneRegCtrl.text = "";
    passRegCtrl.text = "";
    departmentRegCtrl.text = "";
    thanaRegCtrl.text = "";
    nidRegCtrl.text = "";
    buildingRegCtrl.text = "";
    streetAddressRegCtrl.text = "";
    factoryRegCtrl.text = "";
  }

  ///....... Google Login .......
  void loginWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      signInOption: SignInOption.standard,
      scopes: ['email'],
    );

    try{
      await googleSignIn.signIn().then((GoogleSignInAccount? acc) async {
        GoogleSignInAuthentication auth = await acc!.authentication;

        print('sgjliklsdfg ${auth.accessToken}');

          print(acc.email);
          print(acc.displayName);
          print(acc.photoUrl);

        if (auth.accessToken != "null"
            ||auth.accessToken != null
            || auth.accessToken != "") {
          setState(() {
            isSignInGglBtnLoading = true;
          });
          final body = FormData.fromMap({
            'id': acc.id,
            'name': acc.displayName,
            'email': acc.email,
            'access_token': auth.accessToken
          });

          SharedPreferences? sharedPreferences;
          String link = "$baseUrl/api/v1/google_login_api";
          final response = await Dio().post(link, data: body);
          var item = jsonDecode(response.data);
          print('sgjliklsdfg $item');

          if(item["message"] == "Login Successfully"){
            setState(() {
              isSignInGglBtnLoading = false;
            });
            sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString('token', "${item["token"]}");
            print('asdgasdgsdg ${sharedPreferences.getString('token')}');
            Utils.showSnackBar(context, item["message"]);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen(),));
          }
          else{
            setState(() {
              isSignInGglBtnLoading = false;
            });
            Utils.showSnackBar(context, item["message"]);
          }
        }
        else{
          Utils.errorSnackBar(context, "Something went wrong");
        }
      });
    }catch(e){
      setState(() {
        isSignInGglBtnLoading = false;
      });
      print('asdfkjhlasd Error $e');
    }
  }
}