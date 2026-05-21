import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/customer_orders_provider.dart';
import 'package:al_barakah_e_mart/screens/order/order_details_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CustomerOrdersProvider>(context, listen: false).getCustomerOrders());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerOrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w600)),
      ),
      body: provider.isLoading ? const Center(child: CircularProgressIndicator())
          : provider.customerOrderslist.isEmpty ? Center(child: Text("No Orders Found",style: AllTextStyle.nofoundTextStyle))
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, 
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, 
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: DataTable(
                          dataRowHeight: 22.h,
                          headingRowHeight: 20.h,
                          headingRowColor: WidgetStateProperty.all(Colors.grey.shade300),
                          border: TableBorder.all(color: Colors.grey.shade400, width: 0.5),
                          columns: const [
                            DataColumn(label: Text('Invoice Number', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Order Date', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Shipping Address', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Shipping Cost', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Delivery Date', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Total Cost', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
                          ],
                          rows: provider.customerOrderslist.map((order) {
                            return DataRow(cells: [
                              DataCell(Text(order.saleMasterInvoiceNo?.toString() ?? "N/A")),
                              DataCell(Text(order.saleMasterSaleDate?.toString() ?? "N/A")),
                              DataCell(
                                Text(
                                  "${order.customerAddress ?? 'No Address'}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DataCell(Text("${order.shippingCharge ?? "0.00"}")),
                              DataCell(Text(order.deliveryDate?.toString() ?? "Pending")),
                              DataCell(Text("${order.saleMasterTotalSaleAmount ?? "0.00"}")),
                              DataCell(
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(
                                    color: _statusColor(order.status?.toString()),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    _statusText(order.status?.toString()),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                             DataCell(
                              InkWell(
                                borderRadius: BorderRadius.circular(6.r),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OrderDetailsScreen(
                                        order: order,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                  child: Container(
                                    height: 25.h,
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    decoration: BoxDecoration(
                                      color: appBarColor,
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                    child: Text("View",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),)
                                  ),
                                ),
                              ),
                            ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  // স্ট্যাটাস অনুযায়ী ব্যাকগ্রাউন্ড কালার নির্ধারণ
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

  // স্ট্যাটাস কোডকে টেক্সটে রূপান্তর
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