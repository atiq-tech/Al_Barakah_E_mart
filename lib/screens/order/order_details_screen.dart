import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:al_barakah_e_mart/all_api_model/customer_orders_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class OrderDetailsScreen extends StatefulWidget {
  final CustomerOrdersModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
Future<void> printOrder(CustomerOrdersModel order) async {
  final pdf = pw.Document();

  // প্রথমে সব product images load করে নিন
  final List<pw.MemoryImage?> productImages = [];
  for (var product in order.productInfo!) {
    final imageUrlFull = "$imageUrl${product.relToProduct?.mainImage}";
    try {
      final response = await http.get(Uri.parse(imageUrlFull));
      if (response.statusCode == 200) {
        productImages.add(pw.MemoryImage(response.bodyBytes));
      } else {
        productImages.add(null);
      }
    } catch (e) {
      productImages.add(null);
    }
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(2.r),
      build: (context) => [

        /// Status Badge
        pw.Center(
          child: pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: pw.BoxDecoration(
              color: _statusPdfColor(order.status),
              borderRadius: pw.BorderRadius.circular(5),
            ),
            child: pw.Text(
              _statusText(order.status),
              style: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ),

        pw.SizedBox(height: 10),

        /// Shipping + Summary Box
        pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey200,
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              /// Shipping Address
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Shipping Address", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 3),
                    pw.Text(order.customerInfo?.customerName ?? ""),
                    pw.Text(order.saleCustomerAddress ?? ""),
                    pw.Text("Mobile: ${order.customerInfo?.customerMobile ?? ""}"),
                  ],
                ),
              ),

              pw.SizedBox(width: 15),

              /// Order Summary
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Order Summary", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    summaryPdfRow("Sub-Total", order.saleMasterSubTotalAmount),
                    summaryPdfRow("Total", order.saleMasterTotalSaleAmount),
                    summaryPdfRow("Paid", order.saleMasterPaidAmount),
                    summaryPdfRow("Due", order.saleMasterDueAmount),
                  ],
                ),
              ),
            ],
          ),
        ),

        pw.SizedBox(height: 15),

        /// Products Title
        pw.Text("Products", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
        pw.SizedBox(height: 5),

        /// Product Table Header
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          color: PdfColors.grey300,
          child: pw.Row(
            children: [
              pw.Expanded(flex: 2, child: pw.Center(child: pw.Text("Image"))),
              pw.Expanded(flex: 4, child: pw.Center(child: pw.Text("Product Name"))),
              pw.Expanded(flex: 2, child: pw.Center(child: pw.Text("Quantity"))),
              pw.Expanded(flex: 3, child: pw.Center(child: pw.Text("Total"))),
            ],
          ),
        ),

        /// Product List
        ...List.generate(order.productInfo!.length, (index) {
          final product = order.productInfo![index];
          final image = productImages[index];

          return pw.Container(
            padding: const pw.EdgeInsets.all(5),
            decoration: const pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey)),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    height: 35,
                    alignment: pw.Alignment.center,
                    child: image != null
                        ? pw.Image(image, width: 35, height: 35, fit: pw.BoxFit.cover)
                        : pw.Text("No Image"),
                  ),
                ),

                pw.SizedBox(width: 10),

                pw.Expanded(
                  flex: 4,
                  child: pw.Text(product.relToProduct?.productName ?? ""),
                ),

                pw.Expanded(
                  flex: 2,
                  child: pw.Center(
                    child: pw.Text(product.saleDetailsTotalQuantity.toString()),
                  ),
                ),

                pw.Expanded(
                  flex: 3,
                  child: pw.Center(
                    child: pw.Text("${product.saleDetailsTotalAmount}"),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Information #${widget.order.saleMasterInvoiceNo}",style: TextStyle(fontSize: 15.sp,fontStyle: FontStyle.italic)),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              printOrder(widget.order);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 Status Badge
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: _statusColor(widget.order.status),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  _statusText(widget.order.status),
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            /// 🔥 Shipping + Summary Box
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Shipping Address
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Shipping Address",style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 3.h),
                        Text(widget.order.customerInfo?.customerName ?? ""),
                        Text(widget.order.saleCustomerAddress ?? ""),
                        SizedBox(height: 3.h),
                        Text("Mobile: ${widget.order.customerInfo?.customerMobile ?? ""}"),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.w),
                  /// Order Summary
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Order Summary",style: TextStyle(fontWeight: FontWeight.bold)),
                        summaryRow("Sub-Total",widget.order.saleMasterSubTotalAmount),
                        summaryRow("Total",widget.order.saleMasterTotalSaleAmount),
                        summaryRow("Paid",widget.order.saleMasterPaidAmount),
                        summaryRow("Due",widget.order.saleMasterDueAmount),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            /// 🔥 Products Title
            Text("Products",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
            SizedBox(height: 5.h),
            /// 🔥 Product Table Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 3.h),
              color: Colors.grey.shade300,
              child: const Row(
                children: [
                  Expanded(flex: 2, child: Center(child: Text("Image"))),
                  Expanded(flex: 4, child: Center(child: Text("Product Name"))),
                  Expanded(flex: 2, child: Center(child: Text("Quantity"))),
                  Expanded(flex: 3, child: Center(child: Text("Total"))),
                ],
              ),
            ),

            /// 🔥 Product List
            ...widget.order.productInfo!.map((product) {
              return Container(
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomImage(
                        path: "$imageUrl${product.relToProduct?.mainImage}",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      flex: 4,
                      child: Text(product.relToProduct?.productName ?? "",style: TextStyle(fontSize: 11.sp)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(child: Text(product.saleDetailsTotalQuantity.toString(),style: TextStyle(fontSize: 11.sp)),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text("৳${product.saleDetailsTotalAmount}",style: TextStyle(fontSize: 11.sp)),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String title, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text("৳${value ?? "0.00"}"),
        ],
      ),
    );
  }

  Color _statusColor(String? status) {
    switch (status) {
      case "a":
        return Colors.green;
      case "p":
        return Colors.orange;
      case "c":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _statusText(String? status) {
    switch (status) {
      case "a":
        return "Confirmed";
      case "p":
        return "Pending";
      case "c":
        return "Cancelled";
      default:
        return "Unknown";
    }
  }
}

pw.Widget summaryPdfRow(String title, String? value){
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      pw.Text(title),
      pw.Text("${value ?? "0.00"}"),
    ],
  );
}

PdfColor _statusPdfColor(String? status){
  switch(status){
    case "a":
      return PdfColors.green;
    case "p":
      return PdfColors.orange;
    case "c":
      return PdfColors.red;
    default:
      return PdfColors.grey;
  }
}

