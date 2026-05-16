import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:flutter/material.dart';

class MyCustomTextFormField {
  TextFormField getCustomEditTextArea(
      {String? hintValue = "",
      bool? validation,
      int? maxLineValue,
      double? h2TextSize,
      TextEditingController? controller,
      TextInputType keyboardType = TextInputType.text,
      TextStyle? textStyle,
      String? validationErrorMsg}) {
    TextFormField textFormField = TextFormField(
      keyboardType: keyboardType,
      style: const TextStyle(overflow: TextOverflow.ellipsis,fontSize: 13.0),
      maxLines: 1,
      controller: controller,
      validator: (value) {
        if (validation == true && value!.isEmpty) {
          return validationErrorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintValue,
        hintStyle: const TextStyle(fontSize: 14.0,fontWeight: FontWeight.w400),
        errorStyle: const TextStyle(fontSize: 0.01),
        contentPadding: const EdgeInsets.only(left: 10.0,right: 5.0),
        border: TextFieldInputBorder.focusEnabledBorder,
        focusedBorder: TextFieldInputBorder.focusEnabledBorder,
        enabledBorder: TextFieldInputBorder.focusEnabledBorder,
      ),
    );
    return textFormField;
  }
}
