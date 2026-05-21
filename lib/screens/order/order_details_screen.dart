import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/all_api_model/customer_orders_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class OrderDetailsScreen extends StatelessWidget {
  final CustomerOrdersModel order;

  const OrderDetailsScreen({super.key, required this.order});

  Future<void> printOrderInvoice() async {
  final pdf = pw.Document();
  final now = DateTime.now();
  final formattedPeriod = now.hour >= 12 ? 'PM' : 'AM';
  final formattedHour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
  final formattedMinute = now.minute < 10 ? '0${now.minute}' : '${now.minute}';
  final currentDateTimeString = "${now.month}/${now.day}/${now.year.toString().substring(2)}, $formattedHour:$formattedMinute $formattedPeriod";

  // ১. আপনার অ্যাসেট ফোল্ডার থেকে লোগো ইমেজটি লোড করুন
  pw.MemoryImage? logoImage;
  try {
    final imageBytes = await rootBundle.load('images/ablogo.png');
    logoImage = pw.MemoryImage(imageBytes.buffer.asUint8List());
  } catch (e) {
    debugPrint("Logo load failed: $e");
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      build: (context) {
        return pw.Column(
          crossAxisAlignment:  pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  currentDateTimeString, // এখানে কারেন্ট ডেট এবং টাইম ডাইনামিকালি শো হবে (যেমন: 5/20/26, 5:01 PM)
                  style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey900),
                ),
                pw.Text(
                  "Invoice",
                  style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey900),
                ),
              ],
            ),
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Column(
                children: [
                  if (logoImage != null)
                    pw.Container(
                      height: 55,
                      margin: const pw.EdgeInsets.only(bottom: 8),
                      child: pw.Image(logoImage, fit: pw.BoxFit.contain),
                    ),
                  pw.Text(
                    "Al Barakah E-mart",
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.teal900),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Text(
                    "152/2k Green Road, Dhanmondi, Dhaka-1205",
                    style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey800),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    "Mobile : 01717202623",
                    style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey800),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 15),

            // 🔥 ইমেজ অনুযায়ী ডাবল সলিড বর্ডার (Double Line Border)
            pw.Container(
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  top: pw.BorderSide(style: pw.BorderStyle.solid, width: 0.8, color: PdfColors.black),
                  bottom: pw.BorderSide(style: pw.BorderStyle.solid, width: 0.8, color: PdfColors.black),
                ),
              ),
              padding: const pw.EdgeInsets.symmetric(vertical: 2),
              child: pw.Container(
                height: 1,
                color: PdfColors.white, // মাঝখানে ফাঁকা রাখার জন্য
              ),
            ),
            
            // Order Details Header Title
            pw.SizedBox(height: 8),
            pw.Center(
              child: pw.Text(
                "Order Details",
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.normal, color: PdfColors.black),
              ),
            ),
            pw.SizedBox(height: 5),
            
            // ডটেড ডিভাইডার লাইন
            pw.Container(
              decoration: const pw.BoxDecoration(
                border: pw.Border(bottom: pw.BorderSide(style: pw.BorderStyle.dotted, width: 1, color: PdfColors.grey600)),
              ),
            ),
            pw.SizedBox(height: 15),

            // কাস্টমার ও অর্ডার ইনফো (Row আকারে দুই পাশে)
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(children: [
                      pw.Text("Name : ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                      pw.Text("${order.customerName ?? 'N/A'}", style: const pw.TextStyle(fontSize: 11)),
                    ]),
                    pw.SizedBox(height: 4),
                    pw.Row(children: [
                      pw.Text("Phone : ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                      pw.Text("${order.customerMobile ?? 'N/A'}", style: const pw.TextStyle(fontSize: 11)),
                    ]),
                    pw.SizedBox(height: 4),
                    pw.Row(children: [
                      pw.Text("Address : ", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                      pw.Text("${order.customerAddress ?? 'N/A'}", style: const pw.TextStyle(fontSize: 11)),
                    ]),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Row(children: [
                      pw.Text("Order No :", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                      pw.Text("${order.saleMasterInvoiceNo ?? 'N/A'}", style: const pw.TextStyle(fontSize: 11)),
                    ]),
                    pw.SizedBox(height: 4),
                    pw.Row(children: [
                      pw.Text("Order Date :", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                      pw.Text("${order.saleMasterSaleDate ?? 'N/A'}", style: const pw.TextStyle(fontSize: 11)),
                    ]),
                    pw.SizedBox(height: 4),
                    pw.Row(children: [
                      pw.Text("Order From :", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
                      pw.Text("Test", style: const pw.TextStyle(fontSize: 11)), 
                    ]),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 25),

            // প্রডাক্ট টেবিল (বর্ডার কালার হালকা করা হয়েছে একদম ইমেজের মতো)
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
              columnWidths: const {
                0: pw.FlexColumnWidth(4),
                1: pw.FlexColumnWidth(2),
                2: pw.FlexColumnWidth(2),
                3: pw.FlexColumnWidth(2),
              },
              children: [
                // টেবিল হেডার
                pw.TableRow(
                  children: [
                    pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8), child: pw.Text("Product Name", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11))),
                    pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8), child: pw.Center(child: pw.Text("Quantity", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)))),
                    pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8), child: pw.Center(child: pw.Text("Price", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)))),
                    pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8), child: pw.Center(child: pw.Text("Total", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)))),
                  ],
                ),
                // টেবিল বডি (লুপ)
                if (order.orderDetails != null)
                  ...order.orderDetails!.map((product) {
                    return pw.TableRow(
                      children: [
                        pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8), child: pw.Text(product.productType?.toString() ?? "Product", style: const pw.TextStyle(fontSize: 11))), 
                        pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8), child: pw.Center(child: pw.Text("${product.saleDetailsTotalQuantity} x", style: const pw.TextStyle(fontSize: 11)))),
                        pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8), child: pw.Center(child: pw.Text("${product.saleDetailsRate}", style: const pw.TextStyle(fontSize: 11)))),
                        pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8), child: pw.Container(alignment: pw.Alignment.centerRight, child: pw.Text("${product.saleDetailsTotalAmount}", style: const pw.TextStyle(fontSize: 11)))),
                      ],
                    );
                  }),
              ],
            ),
            pw.SizedBox(height: 10),

            // সাবটোটাল ও ক্যালকুলেশন পার্ট
            pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Container(
                width: 260,
                child: pw.Column(
                  children: [
                    pdfSummaryRow("Sub Total:", "${order.saleMasterSubTotalAmount ?? '0.00'}"),
                    pw.Container(margin: const pw.EdgeInsets.symmetric(vertical: 4), height: 0.5, color: PdfColors.grey500),
                    pdfSummaryRow("Delivery Charge:", "${order.shippingCharge ?? '0.00'}"),
                    pw.Container(margin: const pw.EdgeInsets.symmetric(vertical: 4), height: 0.5, color: PdfColors.grey500),
                    pdfSummaryRow("Total Amount:", "${order.saleMasterTotalSaleAmount ?? '0.00'}", isBold: true),
                  ],
                ),
              ),
            ),
            
            // ফ্লেক্সিবল স্পেস যা সিগনেচার পার্টকে একদম নিচে পুশ করবে
            pw.Spacer(),

            // 🔥 একদম নিচে ইমেজের মতো সিগনেচার সেকশন (Received by এবং Authorized Signature)
            // 🔥 একদম নিচে ইমেজের মতো সিগনেচার সেকশন (Received by এবং Authorized Signature)
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    // এখানে color প্রোপার্টি বাদ দিয়ে decoration ব্যবহার করা হয়েছে
                    pw.Container(
                      width: 120, 
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(top: pw.BorderSide(width: 0.8, color: PdfColors.black)),
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text("Received by", style: const pw.TextStyle(fontSize: 11)),
                  ],
                ),
                pw.Column(
                  children: [
                    // এখানেও সেম ফিক্স করা হয়েছে
                    pw.Container(
                      width: 140, 
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(top: pw.BorderSide(width: 0.8, color: PdfColors.black)),
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text("Authorized Signature", style: const pw.TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Invoice Details", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top border & Print button row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: printOrderInvoice,
                  child: const Row(
                    children: [
                      Icon(Icons.print, color: Colors.blue, size: 18),
                      SizedBox(width: 4),
                      Text("Print", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.black, thickness: 0.5),
            // Order Invoice Title
            Center(
              child: Text(
                "Order Invoice",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff004d40),
                ),
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // বাম পাশের কাস্টমার ইনফো
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoText("Name", order.customerName),
                    infoText("Phone", order.customerMobile),
                    infoText("Address", order.customerAddress),
                  ],
                ),
                // ডান পাশের অর্ডার ট্র্যাকিং ইনফো
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    infoTextRight("Order No", order.saleMasterInvoiceNo),
                    infoTextRight("Order Date", order.saleMasterSaleDate),
                    infoTextRight("Order From", order.customerAddress),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // ইমেজ স্টাইলের প্রডাক্ট টেবিল
            Table(
              border: TableBorder.all(color: Colors.grey.shade400, width: 1),
              columnWidths: const {
                0: FlexColumnWidth(4), // প্রডাক্ট নাম বড় হবে
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
              },
              children: [
                // টেবিল হেডার রো
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey.shade50),
                  children: [
                    tableHeader("Product Name", alignment: Alignment.centerLeft),
                    tableHeader("Quantity"),
                    tableHeader("Price"),
                    tableHeader("Total"),
                  ],
                ),
                // ডাটা রো জেনারেট (লুপ)
                if (order.orderDetails != null)
                  ...order.orderDetails!.map((product) {
                    return TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.r),
                          child: Text(product.productType?.toString() ?? "Product Item", style: TextStyle(fontSize: 12.sp)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.r),
                          child: Center(child: Text("${product.saleDetailsTotalQuantity} x", style: TextStyle(fontSize: 12.sp))),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.r),
                          child: Center(child: Text("${product.saleDetailsRate}", style: TextStyle(fontSize: 12.sp))),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.r),
                          child: Center(child: Text("${product.saleDetailsTotalAmount}", style: TextStyle(fontSize: 12.sp))),
                        ),
                      ],
                    );
                  }),
              ],
            ),
            SizedBox(height: 10.h),
            // সাব টোটাল, ডেলিভারি চার্জ এবং গ্র্যান্ড টোটাল সেকশন
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 220.w,
                child: Column(
                  children: [
                    screenSummaryRow("Sub Total:", "${order.saleMasterSubTotalAmount ?? '0.00'}"),
                    const Divider(height: 10),
                    screenSummaryRow("Delivery Charge:", "${order.shippingCharge ?? '0.00'}"),
                    const Divider(height: 10),
                    screenSummaryRow("Total Amount:", "${order.saleMasterTotalSaleAmount ?? '0.00'}", isBold: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- হেল্পার উইজেটস (স্ক্রিন ডিজাইনের জন্য) ---
  Widget infoText(String label, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        "$label : ${value ?? 'N/A'}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: Colors.black87),
      ),
    );
  }

  Widget infoTextRight(String label, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        "$label :${value ?? 'N/A'}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: Colors.black87),
      ),
    );
  }

  Widget tableHeader(String title, {Alignment alignment = Alignment.center}) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.all(5.r),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp, color: Colors.black87),
      ),
    );
  }

  Widget screenSummaryRow(String title, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp)),
        Text(amount, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: 12.sp)),
      ],
    );
  }

  // --- হেল্পার উইজেটস (PDF ডিজাইনের জন্য) ---
  static pw.Widget pdfSummaryRow(String title, String amount, {bool isBold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
        pw.Text(amount, style: pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal, fontSize: 11)),
      ],
    );
  }
}