import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainController {
  static final MainController _singleton = MainController._internal();

  factory MainController() {
    return _singleton;
  }

  MainController._internal();

  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // final pageController = PageController();

  // final customPopupMenuController = CustomPopupMenuController();

  final naveListener = StreamController<int>.broadcast();

  Future<bool> onBackPressed(BuildContext context,int index) async {
    if (index > 0) {
      naveListener.sink.add(0);
      return false;
    }
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
        title: Text('Are you sure you want to close application?',style: TextStyle(
          color: Colors.black87,
          fontSize: 11.sp,
          fontWeight: FontWeight.w400),),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No',
                style: TextStyle(
                    // color: redColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Yes',
                style: TextStyle(
                    // color: redColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              )),
        ],
      ),
    )) ?? false;
  }
}
