import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryTermsScreen extends StatelessWidget {
  const DeliveryTermsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery Terms"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              "Delivery Terms & Conditions – TL Telecom",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 10.h),

            Text("Effective Date: 03 May 2026"),
             SizedBox(height: 16.h),

            const Text(
              "Welcome to TL Telecom. By placing an order through our app, you agree to the following delivery terms and conditions:",
            ),
             SizedBox(height: 16.h),

            _sectionTitle("1. Delivery Areas"),
            const Text(
                "We currently deliver products within selected areas. Delivery availability may vary depending on your location."),

            _sectionTitle("2. Delivery Time"),
            const Text("• Orders are usually delivered within 1–3 business days"),
            const Text(
                "• Delivery time may vary due to location, product availability, or unexpected issues."),

            _sectionTitle("3. Delivery Charges"),
            const Text("• Delivery charges may apply depending on your location"),
            const Text(
                "• The exact delivery fee will be shown during checkout"),

            _sectionTitle("4. Order Processing"),
            const Text("• Orders are processed after confirmation"),
            const Text("• We may contact you for order verification"),

            _sectionTitle("5. Delayed or Failed Delivery"),
            const Text(
                "We are not responsible for delays caused by incorrect address, customer unavailability, or unavoidable events."),

            _sectionTitle("6. Order Cancellation"),
            const Text("• Orders can be canceled before dispatch"),
            const Text(
                "• Once shipped, cancellation may not be possible"),

            _sectionTitle("7. Delivery Confirmation"),
            const Text(
                "A delivery is considered complete once the product is handed over to the customer."),

            _sectionTitle("8. Damaged or Missing Items"),
            const Text(
                "If you receive damaged or missing items, contact us within 24 hours."),

            _sectionTitle("9. Contact Us"),
            const Text("Email: tltelecom@gmail.com"),
            const Text("Phone: 01711514200"),

            SizedBox(height: 15.h),

            const Text(
              "By placing an order, you agree to these Delivery Terms & Conditions.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}