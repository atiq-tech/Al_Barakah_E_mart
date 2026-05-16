import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Utils{

  static String formatDate(var date) {
    late DateTime dateTime;
    if (date is String) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = date;
    }

    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static Future showCustomDialog(
      BuildContext context, {
        Widget? child,
        bool barrierDismissible = false,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }

  static void errorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          content: Center(child: Text(errorMsg, style: const TextStyle(color: Colors.white))),
        ),
      );
  }

  static void showSnackBar(BuildContext context, String msg,
      [Color textColor = Colors.white]) {
    final snackBar =
    SnackBar(
      backgroundColor: Colors.indigo.shade600,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        content: Center(child: Text(msg, style: TextStyle(color: textColor))));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void errorSnackBarWithButton(BuildContext context, String errorMsg,VoidCallback onPress,{String actionText = 'Login',Color textColor = Colors.white}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          content: Text(errorMsg, style: const TextStyle(color: Colors.red)),
          action: SnackBarAction(
            label: actionText,
            textColor: Colors.white,
            onPressed: onPress,
          ),
        ),
      );
  }

  static void showSnackBarWithAction(
      BuildContext context, String msg, VoidCallback onPress,{String actionText = 'Active',Color textColor = Colors.white,}) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(msg, style: TextStyle(color: textColor)),
      action: SnackBarAction(
        label: actionText,
        textColor: Colors.white,
        onPressed: onPress,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static loadingDialog(
      BuildContext context, {
        bool barrierDismissible = false,
      }) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: const SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.pop(context);
    }
  }


  static Route createPageRouteTop(BuildContext context,Widget page){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 0.1);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
  static void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return _AnimatedTopSnackBar(
          message: message,
          onDismiss: () => overlayEntry.remove(),
        );
      },
    );

    overlay.insert(overlayEntry);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}


class _AnimatedTopSnackBar extends StatefulWidget {
  final String message;
  final VoidCallback onDismiss;

  const _AnimatedTopSnackBar({
    required this.message,
    required this.onDismiss,
  });

  @override
  State<_AnimatedTopSnackBar> createState() => _AnimatedTopSnackBarState();
}

class _AnimatedTopSnackBarState extends State<_AnimatedTopSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      _controller.reverse().then((value) => widget.onDismiss());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.h,
      left: 20.w,
      right: 20.w,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.red.shade800,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12.r,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
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
}



