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
    await launchUrl(phoneUri,
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
