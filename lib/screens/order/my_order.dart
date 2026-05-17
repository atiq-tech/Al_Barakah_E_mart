import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:al_barakah_e_mart/all_api_model/customer_orders_model.dart';
import 'package:al_barakah_e_mart/all_api_provider/customer_orders_provider.dart';
import 'package:al_barakah_e_mart/screens/order/order_details_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_image.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CustomerOrdersProvider>(context, listen: false)
            .getCustomerOrders(null));
  }

  void loadOrders(String? status) {
    setState(() {
      selectedStatus = status;
    });
    Provider.of<CustomerOrdersProvider>(context, listen: false)
        .getCustomerOrders(status);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerOrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Order History",style: TextStyle(fontStyle: FontStyle.italic))),
      body: Column(
        children: [
          /// 🔥 Filter Buttons
          SizedBox(
            height: 35.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 30.w),
                filterButton("All Orders", null),
                filterButton("Pending", "p"),
                filterButton("Confirmed", "a"),
              ],
            ),
          ),
          SizedBox(height: 10.h),

          /// 🔥 Order List
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.customerOrderslist.isEmpty
                    ? Center(
                        child: Text(
                          "No Orders Found",
                          style: AllTextStyle.nofoundTextStyle,
                        ),
                      )
                    : ListView.builder(
                        itemCount: provider.customerOrderslist.length,
                        itemBuilder: (context, index) {
                          final order =
                              provider.customerOrderslist[index];

                          return orderCard(order);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  /// 🔥 Filter Button
  Widget filterButton(String title, String? status) {
    bool isSelected = selectedStatus == status;

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      color: isSelected
          ? applineColor
          : const Color.fromARGB(255, 21, 203, 235),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: InkWell(
        onTap: () => loadOrders(status),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }

  /// 🔥 Order Card
  Widget orderCard(CustomerOrdersModel order) {
    return Card(
      elevation: 5,
      color: Colors.cyan.shade50,
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order# ${order.saleMasterInvoiceNo}",
                      style:
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "Date Added: ${order.saleMasterSaleDate}"),
                  ],
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: order.status == "p"
                          ? Colors.orange
                          : Colors.green,
                      radius: 7.r,
                      child: Icon(
                        Icons.check,
                        size: 10.r,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      order.status == "p"
                          ? "Pending"
                          : "Confirmed",
                      style: TextStyle(
                          color: applineColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),

            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.productInfo?.length ?? 0,
              itemBuilder: (context, index) {
                final product = order.productInfo![index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          child: CustomImage(
                            path:"$imageUrl${product.relToProduct?.mainImage}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        flex: 5,
                        child: Text(
                          product.relToProduct?.productName ??
                              "",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Divider(),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ${order.saleMasterTotalSaleAmount}৳",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: applineColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Card(
                  elevation: 3,
                  color: applineColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              OrderDetailsScreen(order: order),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 5.h),
                      child: const Text(
                        "View",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
