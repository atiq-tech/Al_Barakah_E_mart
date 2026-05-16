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
      backgroundColor: const Color(0xffD4EAFF),
      body: Container(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 50),
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
                child: Image.asset("images/tmlogo.png",width: 160.w,height: 80.h,fit: BoxFit.fill)
              ),
              SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Forgot Password",style: GoogleFonts.adamina(
                            fontSize: 20,fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),textAlign: TextAlign.center,),
                      ],
                    )
                  ],
                ),
                const Divider(color: Colors.black),
                 Padding(
                   padding: EdgeInsets.all(18.r),
                   child: Text(
                    "You can recover your password by submitting your registered phone number.",
                    style: GoogleFonts.adamina(),
                    textAlign: TextAlign.center,
                   ),
                 ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///Phone
                        const SizedBox(height: 5),
                        Align(alignment: Alignment.centerLeft,
                            child: Text("Mobile Number",style:AllTextStyle.LoginHeadTitle)),
                        const SizedBox(height: 6,),
                        SizedBox(
                          // height: 48,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneCtrl,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "Enter Mobile Number",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.blue),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.blue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.blue),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if(value==''){
                                return "Please Enter Mobile";
                              }
                              else{
                                phoneCtrl.text = value.toString().trim();
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 45,
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
                              backgroundColor: appbuttonColor,
                              foregroundColor: Colors.red.shade700,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              elevation: 0,
                            ), child: isGetOtpBtnLoading ? const CircularProgressIndicator() : Text("SUBMIT",style: AllTextStyle.tableHeadTextStyle),
                          ),
                        ),
                    
                      ],
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