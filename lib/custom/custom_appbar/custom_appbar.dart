import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Custom_Appbar extends StatelessWidget {
    const Custom_Appbar({Key? key,required this.onPressed,required this.End_Add_To_Cart_Drawer}) : super(key: key);

  final VoidCallback? onPressed,End_Add_To_Cart_Drawer;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 0),
      sliver: SliverAppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: onPressed, icon: Icon(Icons.menu,size: 25.r,color: Colors.black87),
        ),
        title: Text("TL Telecom",style: GoogleFonts.poppins(
          fontSize: 18.sp,
          fontStyle: FontStyle.italic,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),),
        pinned: true,
        actions: [
          IconButton(
          iconSize: 28.sp,
          icon: Icon(Icons.search,size: 25.r,color: Colors.black87),
          onPressed: () {},
        ),
          IconButton(
            iconSize: 28.sp,
            icon: Icon(Icons.shopping_cart,size: 25.r,color: Colors.black87),
            onPressed:  End_Add_To_Cart_Drawer,
          ),
        ],
      ),
    );
  }
}
