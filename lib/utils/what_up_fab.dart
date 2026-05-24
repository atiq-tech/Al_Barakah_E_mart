import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomContactFAB extends StatelessWidget {
  const CustomContactFAB({super.key});

  Future<void> _launchWhatsApp() async {
    final String phoneNumber = "+8801717-202623"; 
    final String message = "Hello, Al Barakah E-Mart!";
    final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("WhatsApp open kora jachhe na");
    }
  }

  Future<void> _makePhoneCall() async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: '+8801717202623',
  );

  try {
    await launchUrl(
      phoneUri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    debugPrint("Call kora jachhe na: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: "whatsapp_fab",
          backgroundColor: const Color(0xFF25D366),
          shape: const CircleBorder(), 
          onPressed: _launchWhatsApp,
          child: Image.asset('images/wp.png',fit: BoxFit.contain),
        ),
        SizedBox(height: 10.h),
        FloatingActionButton(
          heroTag: "phone_fab",
          backgroundColor: Colors.blue.shade600,
          shape: const CircleBorder(), 
          onPressed: _makePhoneCall,
          child: Icon(Icons.phone, color: Colors.white,size: 30.r),
        ), 
      ],
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CustomContactFAB extends StatelessWidget {
//   const CustomContactFAB({super.key});

//   // WhatsApp e message pathanor function
//   Future<void> _launchWhatsApp() async {
//     // 8801xxxxxxxxx eibhabe desher code shoh number diben spaces chara
//     final String phoneNumber = "+8801717-202623"; 
//     final String message = "Hello, Al Barakah E-Mart!";
//     final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

//     if (await canLaunchUrl(whatsappUrl)) {
//       await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint("WhatsApp open kora jachhe na");
//     }
//   }

//   // Direct phone call korar function
//   Future<void> _makePhoneCall() async {
//     final Uri phoneUrl = Uri.parse("tel:+8801717-202623"); // Aponar number eikhane bhashan
//     if (await canLaunchUrl(phoneUrl)) {
//       await launchUrl(phoneUrl);
//     } else {
//       debugPrint("Call kora jachhe na");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // 1. WhatsApp Button
//         FloatingActionButton.small(
//           heroTag: "whatsapp_fab", // Unique tag hote hobe animation crash eror eriye cholte
//           backgroundColor: const Color(0xFF25D366), // WhatsApp Green Color
//           onPressed: _launchWhatsApp,
//           child: const Icon(Icons.chat, color: Colors.white), // Athoba custom WhatsApp image pack use korte paren
//         ),
//         SizedBox(height: 10.h),
        
//         // 2. Phone Call Button
//         FloatingActionButton(
//           heroTag: "phone_fab", // Unique tag
//           backgroundColor: Colors.blue.shade600,
//           onPressed: _makePhoneCall,
//           child: const Icon(Icons.phone, color: Colors.white),
//         ),
//         // Bottom Navbar thakar karone ektu niche space rakha bhalo
//         SizedBox(height: 5.h), 
//       ],
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';

// class WhatsAppFAB extends StatelessWidget {
//   const WhatsAppFAB({super.key, this.phone});
 
//   /// country code সহ number দিন (8801xxxxxxx)
//   final String? phone;
 
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       elevation: 9,
//       backgroundColor: Colors.transparent,
//       onPressed: () {
//         WhatsAppHelper.launchWhatsApp(phone: phone);
//       },
//       child: ClipOval(
//         child: Image.asset(
//           'assets/icons/wup.png',
//           width: 56.w,
//           height: 56.h,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }
 
// class WhatsAppHelper {
//   static Future<void> launchWhatsApp({String? phone}) async {
//     final String url = phone == null || phone.isEmpty
//         ? "https://wa.me/"
//         : "https://wa.me/$phone";
//     final Uri uri = Uri.parse(url);
//     try {
//       await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//     } catch (e) {
//       debugPrint("WhatsApp launch failed: $e");
//     }
//   }
// }



