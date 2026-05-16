import 'dart:convert';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.customerId, required this.otpResponse});
  final String customerId;
  final String otpResponse;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  final otpCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isBtnLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD4EAFF),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text("Confirm Phone",style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),textAlign: TextAlign.center,),
                  const Divider(color: Colors.black,),

                  const SizedBox(height: 30,),

                  const Text(
                    "By submitting your OTP you can verify your phone number to login",
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30,),

                  SizedBox(
                    // height: 48,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: otpCtrl,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Enter otp",
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
                          return "Please Enter OTP";
                        }
                        else{
                          otpCtrl.text = value.toString().trim();
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 20,),

                  SizedBox(
                    height: 45,
                    width: 150,
                    child: ElevatedButton(onPressed: () {
                      if(formKey.currentState!.validate()){
                        if(otpCtrl.text == widget.otpResponse){
                          setState(() {
                            isBtnLoading = true;
                          });
                          verifyMobile();
                        }else{
                          Utils.errorSnackBar(context, "OTP doesn't matched");
                        }
                      }
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffD4EAFF),
                        foregroundColor: Colors.red.shade700,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.red.shade700),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        elevation: 0,
                      ), child: isBtnLoading ? const CircularProgressIndicator() : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Verify"),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward,size: 18,)
                        ],
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

  verifyMobile()async{

    String link = "$baseUrl/api/v1/otp_verify";
    try {
      final formData = FormData.fromMap({
        "otp": widget.otpResponse.trim(),
        "send_otp": otpCtrl.text.trim(),
        "customer_id": widget.customerId.trim()
      });
      final response = await Dio().post(link, data: formData);
      var item = jsonDecode(response.data);
      print('verify phone $item');
      if (item["success"] == true) {
        setState(() {
          isBtnLoading = false;
          otpCtrl.text = "";
        });
        Utils.showSnackBar(context, "${item['data']}");
        Navigator.pop(context);
        // Navigator.pop(context);
      }
      else{
        setState(() {
          isBtnLoading = false;
        });
        Utils.errorSnackBar(context, "${item['otp_data']}");
      }
    } catch (e) {
      setState(() {
        isBtnLoading = false;
      });
      print("Error message $e");
      Utils.errorSnackBar(context, "$e}");
    }

  }

}