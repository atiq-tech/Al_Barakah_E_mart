import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AllTextStyle {
  ///table headline
  static TextStyle tableHeadTextStyle =  GoogleFonts.adamina(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  ///title====
  static TextStyle getTitleTextStyle() {
    return GoogleFonts.poppins(
      fontSize: 18.sp,
      fontStyle: FontStyle.italic,
      letterSpacing: 1,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  ///no found/records
  static TextStyle nofoundTextStyle = TextStyle(
    color: Colors.red,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  ///subTotal
  static TextStyle appbarTextStyle = GoogleFonts.poppins(
      color: Colors.white,fontSize: 14.sp,
      fontWeight: FontWeight.w600
  );
  ///Login Information text style
  static TextStyle LoginHeadTitle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 13.sp,
  );
  ///date style
  static TextStyle dateFormatStyle = TextStyle(
      fontSize: 13.sp,
      color: Colors.grey.shade800,
      fontWeight: FontWeight.w400
  );
  ///subTotal Value
  static  TextStyle subTotalValueTextStyle = const TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic
  );
  ///save button style
  static const TextStyle saveButtonTextStyle = TextStyle(
      letterSpacing: 1.0,
      color: Colors.white,
      fontWeight: FontWeight.w500
  );
  ///textField head style
  static  TextStyle textFieldHeadStyle = TextStyle(
      color: Colors.grey.shade800
  );
  ///textField head style
  static  TextStyle textFieldtitleStyle = TextStyle(
      color: Colors.black87,fontSize: 15.sp,fontWeight: FontWeight.w600
  );
  ///dropDownlist Style
  static  TextStyle dropDownlistStyle = TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: Colors.grey.shade700);
  ///dropDownlist Style
  static  TextStyle textValueStyle = TextStyle(fontSize: 13.sp, color: Color.fromARGB(255, 126, 125, 125));
}
/// decoration
class ContDecoration{
  static  BoxDecoration contDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.grey.shade800, width: 0.8.w),
  borderRadius: BorderRadius.circular(100.r),
  );
}
/// textField inputborder
class TextFieldInputBorder{
  ///focus
  static OutlineInputBorder focusEnabledBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blueGrey),
  borderRadius: BorderRadius.circular(5.r),
  );
}

getTextstyle(){
  return TextStyle(
      backgroundColor:  Colors.blue[100],
      color: Colors.black,
      decoration: TextDecoration.underline,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
  );
}

getErrorTextstyle(){
  return TextStyle(
      backgroundColor:  Colors.blue[100],
      color: Colors.red,
      decoration: TextDecoration.underline,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
  );
}

getHLTextstyle() {
  return  TextStyle(
      color: Colors.deepPurple.shade900,
      fontWeight: FontWeight.w800,
      fontSize: 16.sp,
  );
}

SizedBox sizedBoxH = SizedBox(height: 10.h);
SizedBox sizedBoxW = const SizedBox(width: 10);