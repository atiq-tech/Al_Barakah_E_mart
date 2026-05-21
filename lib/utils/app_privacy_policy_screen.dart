import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy for AL Barakah E-mart",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Effective Date: 03 May 2026",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
              SizedBox(height: 15.h),

              _sectionTitle("1. Information We Collect"),
              _sectionText("""
- Phone number
- Name (if provided)
- Delivery address
- Order details and history
- Device information (device type, OS, usage data)
"""),

              _sectionTitle("2. How We Use Your Information"),
              _sectionText("""
- Process and manage orders
- Provide customer support
- Improve app performance and user experience
"""),

              _sectionTitle("3. Data Sharing"),
              _sectionText("""
We do not sell your personal data.

We may share data with:
- Delivery partners (to complete orders)
- Legal authorities (if required by law)
"""),

              _sectionTitle("4. Data Security"),
              _sectionText(
                  "We take reasonable steps to protect your data, but no system is 100% secure."),

              _sectionTitle("5. User Rights"),
              _sectionText(
                  "You can request to update or delete your data by contacting us."),

              _sectionTitle("6. Children's Privacy"),
              _sectionText(
                  "This app is not intended for children under 13."),

              _sectionTitle("7. Changes to This Policy"),
              _sectionText(
                  "We may update this Privacy Policy anytime. Updates will be shown on this page."),

              _sectionTitle("8. Contact Us"),
              _sectionText("""
                Email: @gmail.com
                Phone: 01717202623
                """),

              _sectionTitle("9. Consent"),
              _sectionText(
                  "By using this app, you agree to this Privacy Policy."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, bottom: 6.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _sectionText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        height: 1.5.h,
      ),
    );
  }
}