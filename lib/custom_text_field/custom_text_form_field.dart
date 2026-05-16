import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   const CustomTextFormField({Key? key,this.maxLines,this.prefixIcon,this.Textdata,this.hintText,required this.controller,required this.validator}) : super(key: key);
  final Widget? prefixIcon;
   final String? Textdata,hintText;
   final TextEditingController controller;
   final FormFieldValidator ? validator;
   final int ? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$Textdata",
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white54,
          ),
          padding: const EdgeInsets.only(
            left: 10
          ),
          alignment: Alignment.center,
          child: TextFormField(
            validator: validator,
            controller:controller ,
            maxLines:maxLines ,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: prefixIcon,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black87,),
            ),
          ),
        ),

      ],
    );
  }
}
