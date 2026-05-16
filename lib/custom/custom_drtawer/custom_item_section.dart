import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';

// ignore: must_be_immutable
class Custom_Item_Section extends StatelessWidget {
   Custom_Item_Section({Key? key,required this.Name,required this.onTap,required this.icon, required this.iconn}) : super(key: key);
  String ? Name;
  VoidCallback  ? onTap;
   final Widget  icon;
   Widget iconn;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          color: appBarColor,
        ),
        padding: EdgeInsets.only(left: 10.w,right: 10.w),
        height: 40.h,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                 SizedBox(width: 10.w),
                Text("$Name",style: GoogleFonts.adamina(fontSize: 13.sp,fontWeight: FontWeight.w700,color: Colors.white),),
              ],
            ),
            iconn
          ],
        ),
      ),
    );
  }
}
