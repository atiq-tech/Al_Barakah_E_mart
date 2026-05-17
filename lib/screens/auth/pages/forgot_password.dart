import 'package:al_barakah_e_mart/screens/auth/pages/signin_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  bool isGetOtpBtnLoading = false;
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: applineColor,
        title: Text("Forgot Password",style: AllTextStyle.appbarTextStyle),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage()));
          },
          child: const Icon(Icons.arrow_back,color: Colors.white)),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Container(
                decoration: BoxDecoration(
                  color: appBarColor,
                  borderRadius: BorderRadius.circular(10.r)
                ),
                child: Image.asset("images/lbg.jpg",width: 200.w,height: 140.h,fit: BoxFit.fill)
              ),
              SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Customer Login",style: GoogleFonts.adamina(
                            fontSize: 20.sp,fontWeight: FontWeight.bold,
                            color: appBarColor
                        ),textAlign: TextAlign.center,),
                      ],
                    )
                  ],
                ),
                const Divider(color: Colors.black),
                 Padding(
                   padding: EdgeInsets.all(5.r),
                   child: Text(
                    "You can recover your password by submitting your registered phone number.",
                    style: GoogleFonts.adamina(),
                    textAlign: TextAlign.center,
                   ),
                 ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Card(
                      elevation: 9,
                      color: const Color.fromARGB(255, 255, 210, 231),
                      child: Padding(
                        padding: EdgeInsets.all(15.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(alignment: Alignment.centerLeft, child: Text("Phone Number",style:AllTextStyle.LoginHeadTitle)),
                            SizedBox(height: 6.h),
                            SizedBox(
                              //height: 35.h,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: phoneCtrl,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: "Enter phone number",
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 0.h),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                    borderSide: const BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                    borderSide: const BorderSide(color: Colors.blue),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                    borderSide: const BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                    borderSide: const BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if(value==''){
                                    return "Please Enter Phone";
                                  }
                                  else{
                                    phoneCtrl.text = value.toString().trim();
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              height: 40.h,
                              width: double.infinity,
                              child: ElevatedButton(onPressed: () {
                                if(formKey.currentState!.validate()){
                                  setState(() {
                                    isGetOtpBtnLoading = true;
                                  });
                                  Utils.closeKeyBoard(context);
                                  //forgotPassword();
                                }
                              },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appBarColor,
                                  foregroundColor: Colors.red.shade700,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r)
                                  ),
                                  elevation: 0,
                                ), child: isGetOtpBtnLoading ? const CircularProgressIndicator() : Text("Recover",style: AllTextStyle.tableHeadTextStyle),
                              ),
                            ),
                        
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // forgotPassword()async{
  //   String link = "$baseUrl/api/v1/send_verification";
  //   try {
  //     final formData = FormData.fromMap({
  //       "bound": boundValue.trim(),
  //       "mobile": phoneCtrl.text.trim(),
  //       "email": emailCtrl.text.trim()
  //     });
  //     final response = await Dio().post(link, data: formData);
  //     var item = jsonDecode(response.data);
  //     print('send verification $item');

  //     if (item["success"] == true) {
  //       setState(() {
  //         isGetOtpBtnLoading = false;
  //         phoneCtrl.text = "";
  //         emailCtrl.text = "";
  //       });
  //       Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyScreen(
  //         customerId: item['customer_data'],
  //         otpResponse: "${item['otp_data']}".toString(),
  //         bound: boundValue,
  //       ),));
  //     }
  //     else{
  //       setState(() {
  //         isGetOtpBtnLoading = false;
  //       });
  //       Utils.errorSnackBar(context, "${item['otp_data']}");
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isGetOtpBtnLoading = false;
  //     });
  //     print("Error message $e");
  //     Utils.errorSnackBar(context, "$e}");
  //   }
  // }

}