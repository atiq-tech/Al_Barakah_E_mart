import 'package:al_barakah_e_mart/all_api_model/area_model.dart';
import 'package:al_barakah_e_mart/all_api_model/delivery_times_model.dart';
import 'package:al_barakah_e_mart/all_api_model/district_model.dart';
import 'package:al_barakah_e_mart/all_api_model/thana_model.dart';
import 'package:al_barakah_e_mart/all_api_provider/area_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/delivery_times_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/district_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/thana_provider.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.quantity,
    this.sizeId,
    this.colorId,
    required this.from,
    this.addToCart,
    this.total,
    required this.token,
  });

  final int quantity;
  final String? sizeId;
  final String? colorId;
  final String from;
  final String token;
  final String? total;
  final List<AddToCartModel>? addToCart;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  String customerAddress = "";

  String customerDistrictName = "";
  String customerThanaName = "";
  String customerAreaName = "";

  String customerDistrictId = "";
  String customerThanaId = "";
  String customerAreaId = "";
  
  final _shipperNameController = TextEditingController();
  final _shipperPhoneController = TextEditingController();
  final _emailController = TextEditingController();
  final districtController = TextEditingController();
  final thanaController = TextEditingController();
  final areaController = TextEditingController();
  final billingController = TextEditingController();
  final shippingController = TextEditingController();
  final deliveryDateController = TextEditingController();
  final deliveryTimesController = TextEditingController();

  String? factoryId;
  String? departmentId;
  String? districtId;
  String? thanaId;
  String? areaId;
  String? deliveryTimesId;

  SharedPreferences? sharedPreferences;

  Future<void> _initializeData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      customerName = sharedPreferences?.getString('name') ?? "";
      customerEmail = sharedPreferences?.getString('email') ?? "";
      customerPhone = sharedPreferences?.getString('phone') ?? "";
      customerAddress = sharedPreferences?.getString('address') ?? "";

      customerDistrictName = sharedPreferences?.getString('districtName') ?? "";
      customerThanaName = sharedPreferences?.getString('thanaName') ?? "";
      customerAreaName = sharedPreferences?.getString('areaName') ?? "";

      customerDistrictId = sharedPreferences?.getString('districtId') ?? "";
      customerThanaId = sharedPreferences?.getString('thanaId') ?? "";
      customerAreaId = sharedPreferences?.getString('areaId') ?? "";

      districtController.text = customerDistrictName;
      thanaController.text = customerThanaName;
      areaController.text = customerAreaName;

      _shipperNameController.text = customerName;
      _shipperPhoneController.text = customerPhone;
      _emailController.text = customerEmail;
      billingController.text = customerAddress;
      shippingController.text = customerAddress;

      /// SHIPPING COST CONDITION FOR LOGIN USER
      if (customerAreaName.toLowerCase() == "dhaka") {
        shippingCost = insideDaka;
      } else {
        shippingCost = outsideDaka;
      }
    });
  }

  String insideDaka = "";
  String outsideDaka = "";
   void getCompanyProfile() async {
    try {
      final response = await Dio().get("${BaseUrl}get_company_profile",
      );
      if (response.statusCode == 200) {
        var data = response.data is List ? response.data[0] : response.data;
        setState(() {
          insideDaka = data['inside_dhaka'] ?? "";
          outsideDaka = data['outside_dhaka'] ?? "";
        });
      }
    } catch (e) {
      print("Error fetching company profile: $e");
    }
    print("insideDaka-------Company_Name======$insideDaka");
    print("outsideDaka-------Company_Name======$outsideDaka");
  }

  String shippingCost = "0";

  @override
  void initState() {
    super.initState();
    getCompanyProfile();
    _initializeData();
    Future.microtask(() {
        Provider.of<DeliveryTimesProvider>(context, listen: false).getDeliveryTimes();
        Provider.of<DistrictProvider>(context, listen: false).getDistrict();
        Provider.of<ThanaProvider>(context, listen: false).getThana("");
        Provider.of<AreaProvider>(context, listen: false).getArea("");
      });
    deliveryDateController.text = DateFormat('dd-MM-yyyy / EEEE').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<AddToCartProvider>(context);
    final cartList = cartProvider.cart;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Text("Checkout", style: TextStyle(color: appBarColor, fontWeight: FontWeight.bold)),
            Text("Guest Checkout", style: TextStyle(fontSize: 14.sp, color: Colors.teal.shade600)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            children: [
              /// STEP INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _stepCircle(0, "Account"),
                  _stepDivider(0),
                  _stepCircle(1, "Delivery Date"),
                  _stepDivider(1),
                  _stepCircle(2, "Order Summary"),
                ],
              ),
              SizedBox(height: 30.h),
              /// STEP BODY
              if (currentStep == 0) _accountStep(),
              if (currentStep == 1) _deliveryStep(),
              if (currentStep == 2) _summaryStep(cartList),
              SizedBox(height: 20.h),
              /// ACTION BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Button
                  if (currentStep > 0)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: ElevatedButton(
                          onPressed: () => setState(() => currentStep--),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF063321), // Dark Green
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: const Text("Previous", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),

                  // Next / Place Order Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (currentStep < 2) {
                          setState(() => currentStep++);
                        } else {
                          // TODO: Implement Place Order Logic
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF063321),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        currentStep == 2 ? "Place Order" : "Next",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _stepDivider(int step) {
    return Expanded(
      child: Container(height: 2,color: currentStep > step ? Colors.green.shade700 : Colors.grey.shade300),
    );
  }

  Widget _stepCircle(int step, String title) {
    bool isCompleted = currentStep > step;
    bool isActive = currentStep == step;
    return Column(
      children: [
        CircleAvatar(
          radius: 15.r,
          backgroundColor: isCompleted ? Colors.green.shade700 : (isActive ? Colors.blue.shade800 : Colors.grey.shade300),
          child: isCompleted 
              ? Icon(Icons.check, size: 16.r, color: Colors.white)
              : Text("${step + 1}", style: TextStyle(color: isActive ? Colors.white : Colors.black54)),
        ),
        SizedBox(height: 4.h),
        Text(title, style: TextStyle(fontSize: 10.sp, color: Colors.black87)),
      ],
    );
  }

  Widget _accountStep() {
  return Column(
    children: [
      _inputField("Enter Name *","Name", _shipperNameController),
      _inputField("Enter Phone Number *","Phone",_shipperPhoneController),
      _inputField("Enter Email","Email",_emailController),
      SizedBox(height: 5.h),
      /// DISTRICT
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45.h,
              child: Consumer<DistrictProvider>(
                builder: (context, provider, child) {
                  final districtList = provider.districtList;
                  return TypeAheadField<DistrictModel>(
                    suggestionsCallback: (pattern) {
                      if (pattern.isEmpty) {
                        return districtList;
                      }
                      return districtList.where((item) {
                        final name = item.districtName.toString().toLowerCase();
                        return name.contains(pattern.toLowerCase());
                      }).toList();
                    },
                    itemBuilder: (context,DistrictModel suggestion) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        child: Text("${suggestion.districtName}"),
                      );
                    },
                    onSelected: (DistrictModel suggestion) {
                      districtController.text = suggestion.districtName ?? "";
                      districtId = suggestion.districtSlNo?.toString() ?? "";
                      Provider.of<ThanaProvider>(context,listen: false).getThana(districtId);
                      FocusScope.of(context).unfocus();
                    },
                    builder: (context,controller,focusNode) {
                      controller.text = districtController.text;
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: "Select District",
                          contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(8.r)),
                          suffixIcon: controller.text.isEmpty ? null : GestureDetector(
                            onTap: () {
                              controller.clear();
                              districtController.clear();
                            },
                            child: const Icon(Icons.close,size: 18),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 5.h),
      /// THANA
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45.h,
              child: Consumer<ThanaProvider>(
                builder: (context, provider, child) {
                  final thanaList = provider.thanaList;
                  return TypeAheadField<ThanaModel>(
                    suggestionsCallback: (pattern) {
                      if (pattern.isEmpty) {
                        return thanaList;
                      }
                      return thanaList.where((item) {
                        final name = item.name.toString().toLowerCase();
                        return name.contains(pattern.toLowerCase());
                      }).toList();
                    },
                    itemBuilder: (context,ThanaModel suggestion) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        child: Text("${suggestion.name}"),
                      );
                    },
                    onSelected: (ThanaModel suggestion) {
                      thanaController.text = suggestion.name ?? "";
                      thanaId = suggestion.id?.toString() ?? "";
                      Provider.of<AreaProvider>(context,listen: false).getArea(thanaId);
                      FocusScope.of(context).unfocus();
                    },
                    builder: (context,controller,focusNode,) {
                      controller.text = thanaController.text;
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText: "Select Thana",
                          contentPadding:EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                          suffixIcon: controller.text.isEmpty ? null : GestureDetector(
                            onTap: () {
                              controller.clear();
                              thanaController.clear();
                            },
                            child: const Icon(Icons.close,size: 18),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 5.h),
      /// AREA
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45.h,
              child: Consumer<AreaProvider>(
                builder: (context, provider, child) {
                  final areaList = provider.areaList;
                  return TypeAheadField<AreaModel>(
                    suggestionsCallback: (pattern) {
                      if (pattern.isEmpty) {return areaList;}
                      return areaList.where((item) {
                        final name = item.name.toString().toLowerCase();
                        return name.contains( pattern.toLowerCase());
                      }).toList();
                    },
                    itemBuilder: (context,AreaModel suggestion) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        child: Text("${suggestion.name}"),
                      );
                    },
                    onSelected: (AreaModel suggestion) {
                      areaController.text = suggestion.name ?? "";
                      areaId = suggestion.id?.toString() ?? "";

                      /// SHIPPING COST CONDITION
                      if ((suggestion.name ?? "").toLowerCase() == "dhaka") {
                        shippingCost = insideDaka;
                      } else {
                        shippingCost = outsideDaka;
                      }

                      print("Shipping Cost ====== $shippingCost");

                      setState(() {});

                      FocusScope.of(context).unfocus();
                    },
                    builder: (context,controller,focusNode) {
                      controller.text = areaController.text;
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText:"Select Area",
                          contentPadding:EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(8.r)),
                          suffixIcon:
                          controller.text.isEmpty ? null: GestureDetector(
                            onTap: () {
                              controller.clear();
                              areaController.clear();
                            },
                            child: const Icon(Icons.close,size: 18),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 15.h),
      _inputField("Billing address *","Billing Address*",billingController),
      _inputField("Shipping address *","Shipping Address*",shippingController),
    ],
  );
}

  Widget _deliveryStep() {
    return Column(
      children: [
      Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: TextFormField(
          controller: deliveryDateController,
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365),
              ),
            );
            if (pickedDate != null) {
              deliveryDateController.text = DateFormat('dd-MM-yyyy / EEEE').format(pickedDate);
            }
          },
          decoration: InputDecoration(
            labelText: "Delivery Date*",
            hintText: "Select Delivery Date",
            suffixIcon: const Icon(Icons.calendar_month,),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 45.h,
              child: Consumer<DeliveryTimesProvider>(
                builder: (context, provider, child) {
                  final deliveryTimesList = provider.deliveryTimesList;
                  return TypeAheadField<DeliveryTimesModel>(
                    suggestionsCallback: (pattern) {
                      if (pattern.isEmpty) {return deliveryTimesList;}
                      return deliveryTimesList.where((item) {
                        final name = item.time.toString().toLowerCase();
                        return name.contains( pattern.toLowerCase());
                      }).toList();
                    },
                    itemBuilder: (context,DeliveryTimesModel suggestion) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                        child: Text("${suggestion.time}"),
                      );
                    },
                    onSelected: (DeliveryTimesModel suggestion) {
                      deliveryTimesController.text =suggestion.time ?? "";
                      deliveryTimesId = suggestion.groupId?.toString()?? "";
                      FocusScope.of(context).unfocus();
                    },
                    builder: (context,controller,focusNode) {
                      controller.text = deliveryTimesController.text;
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          hintText:"Select Times",
                          contentPadding:EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(8.r)),
                          suffixIcon:
                          controller.text.isEmpty ? null: GestureDetector(
                            onTap: () {
                              controller.clear();
                              deliveryTimesController.clear();
                            },
                            child: const Icon(Icons.close,size: 18),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
       ),
      ],
    );
  }

  Widget _summaryStep(List<AddToCartModel> cartList) {
    return Column(
      children: [
        Text("Order Summery", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.h),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Colors.white),
              children: [
                Padding(padding: EdgeInsets.all(8), child: Text("Products", style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.all(8), child: Text("Quantity", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.all(8), child: Text("Total", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            ...cartList.map((item) => TableRow(
              children: [
                Padding(padding: EdgeInsets.all(8), child: Text(item.productName ?? "")),
                Padding(padding: EdgeInsets.all(8), child: Text("${item.quantity}", textAlign: TextAlign.center)),
                Padding(padding: EdgeInsets.all(8), child: Text("${item.discountPrice}", textAlign: TextAlign.center)),
              ],
            )).toList(),
            TableRow(
              children: [
                const Padding(padding: EdgeInsets.all(8), child: Text("Shipping Charge", style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    shippingCost,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                const Padding(padding: EdgeInsets.all(8), child: Text("Total Amount", style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "${(double.tryParse(widget.total ?? "0") ?? 0) + (double.tryParse(shippingCost) ?? 0)}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _inputField(String hint, String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
      ),
    );
  }
}












// import 'package:al_barakah_e_mart/all_api_model/area_model.dart';
// import 'package:al_barakah_e_mart/all_api_model/delivery_times_model.dart';
// import 'package:al_barakah_e_mart/all_api_model/district_model.dart';
// import 'package:al_barakah_e_mart/all_api_model/thana_model.dart';
// import 'package:al_barakah_e_mart/all_api_provider/area_provider.dart';
// import 'package:al_barakah_e_mart/all_api_provider/delivery_times_provider.dart';
// import 'package:al_barakah_e_mart/all_api_provider/district_provider.dart';
// import 'package:al_barakah_e_mart/all_api_provider/thana_provider.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
// import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({
//     super.key,
//     required this.quantity,
//     this.sizeId,
//     this.colorId,
//     required this.from,
//     this.addToCart,
//     this.total,
//     required this.token,
//   });

//   final int quantity;
//   final String? sizeId;
//   final String? colorId;
//   final String from;
//   final String token;
//   final String? total;
//   final List<AddToCartModel>? addToCart;

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   int currentStep = 0;
//   String customerName = "";
//   String userEmail = "";
//   String userPhone = "";
//   String userAddress = "";

//   final _shipperNameController = TextEditingController();
//   final _shipperPhoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final districtController = TextEditingController();
//   final thanaController = TextEditingController();
//   final areaController = TextEditingController();
//   final billingController = TextEditingController();
//   final shippingController = TextEditingController();
//   final deliveryDateController = TextEditingController();
//   final deliveryTimesController = TextEditingController();
//   String? factoryId;
//   String? departmentId;
//   String? districtId;
//   String? thanaId;
//   String? areaId;
//   String? deliveryTimesId;

//   SharedPreferences? sharedPreferences;

//   Future<void> _initializeData() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       customerName = sharedPreferences?.getString('name') ?? "";
//       userEmail = sharedPreferences?.getString('email') ?? "";
//       userPhone = sharedPreferences?.getString('phone') ?? "";
//       userAddress = sharedPreferences?.getString('address') ?? "";

//       _shipperNameController.text = customerName;
//       _shipperPhoneController.text = userPhone;
//       _emailController.text = userEmail;
//       billingController.text = userAddress;
//       shippingController.text = userAddress;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//     Future.microtask(() {
//         Provider.of<DeliveryTimesProvider>(context, listen: false).getDeliveryTimes();
//         Provider.of<DistrictProvider>(context, listen: false).getDistrict();
//         Provider.of<ThanaProvider>(context, listen: false).getThana("");
//         Provider.of<AreaProvider>(context, listen: false).getArea("");
//       });
//     deliveryDateController.text = DateFormat('dd-MM-yyyy / EEEE').format(DateTime.now());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<AddToCartProvider>(context);
//     final cartList = cartProvider.cart;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         centerTitle: true,
//         title: Column(
//           children: [
//             Text("Checkout", style: TextStyle(color: appBarColor, fontWeight: FontWeight.bold)),
//             Text("Guest Checkout", style: TextStyle(fontSize: 14.sp, color: Colors.teal.shade600)),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(15.r),
//           child: Column(
//             children: [
//               /// STEP INDICATOR
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _stepCircle(0, "Account"),
//                   _stepDivider(0),
//                   _stepCircle(1, "Delivery Date"),
//                   _stepDivider(1),
//                   _stepCircle(2, "Order Summary"),
//                 ],
//               ),
//               SizedBox(height: 30.h),

//               /// STEP BODY
//               if (currentStep == 0) _accountStep(),
//               if (currentStep == 1) _deliveryStep(),
//               if (currentStep == 2) _summaryStep(cartList),

//               SizedBox(height: 20.h),

//               /// ACTION BUTTONS
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Previous Button
//                   if (currentStep > 0)
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 10.w),
//                         child: ElevatedButton(
//                           onPressed: () => setState(() => currentStep--),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF063321), // Dark Green
//                             padding: EdgeInsets.symmetric(vertical: 12.h),
//                           ),
//                           child: const Text("Previous", style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                     ),

//                   // Next / Place Order Button
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (currentStep < 2) {
//                           setState(() => currentStep++);
//                         } else {
//                           // TODO: Implement Place Order Logic
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF063321),
//                         padding: EdgeInsets.symmetric(vertical: 12.h),
//                       ),
//                       child: Text(
//                         currentStep == 2 ? "Place Order" : "Next",
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _stepDivider(int step) {
//     return Expanded(
//       child: Container(
//         height: 2,
//         color: currentStep > step ? Colors.green.shade700 : Colors.grey.shade300,
//       ),
//     );
//   }

//   Widget _stepCircle(int step, String title) {
//     bool isCompleted = currentStep > step;
//     bool isActive = currentStep == step;

//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 15.r,
//           backgroundColor: isCompleted ? Colors.green.shade700 : (isActive ? Colors.blue.shade800 : Colors.grey.shade300),
//           child: isCompleted 
//               ? Icon(Icons.check, size: 16.r, color: Colors.white)
//               : Text("${step + 1}", style: TextStyle(color: isActive ? Colors.white : Colors.black54)),
//         ),
//         SizedBox(height: 4.h),
//         Text(title, style: TextStyle(fontSize: 10.sp, color: Colors.black87)),
//       ],
//     );
//   }

//   Widget _accountStep() {
//   return Column(
//     children: [

//       _inputField(
//         "Enter Name *",
//         "Name",
//         _shipperNameController,
//       ),

//       _inputField(
//         "Enter Phone Number *",
//         "Phone",
//         _shipperPhoneController,
//       ),

//       _inputField(
//         "Enter Email",
//         "Email",
//         _emailController,
//       ),
//       SizedBox(height: 5.h),
//       /// DISTRICT
//       Row(
//         children: [
//           Expanded(
//             child: SizedBox(
//               height: 45.h,
//               child: Consumer<DistrictProvider>(
//                 builder: (context, provider, child) {
//                   final districtList = provider.districtList;
//                   return TypeAheadField<DistrictModel>(
//                     suggestionsCallback: (pattern) {
//                       if (pattern.isEmpty) {
//                         return districtList;
//                       }
//                       return districtList.where((item) {
//                         final name = item.districtName.toString().toLowerCase();
//                         return name.contains(pattern.toLowerCase());
//                       }).toList();
//                     },
//                     itemBuilder: (context,DistrictModel suggestion) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
//                         child: Text("${suggestion.districtName}"),
//                       );
//                     },
//                     onSelected: (DistrictModel suggestion) {
//                       districtController.text = suggestion.districtName ?? "";
//                       districtId = suggestion.districtSlNo?.toString() ?? "";
//                       Provider.of<ThanaProvider>(context,listen: false).getThana(districtId);
//                       FocusScope.of(context).unfocus();
//                     },
//                     builder: (context,controller,focusNode) {
//                       controller.text = districtController.text;
//                       return TextField(
//                         controller: controller,
//                         focusNode: focusNode,
//                         decoration: InputDecoration(
//                           hintText: "Select District",
//                           contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
//                           border: OutlineInputBorder(borderRadius:BorderRadius.circular(8.r)),
//                           suffixIcon: controller.text.isEmpty ? null : GestureDetector(
//                             onTap: () {
//                               controller.clear();
//                               districtController.clear();
//                             },
//                             child: const Icon(Icons.close,size: 18),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       SizedBox(height: 5.h),
//       /// THANA
//       Row(
//         children: [
//           Expanded(
//             child: SizedBox(
//               height: 45.h,
//               child: Consumer<ThanaProvider>(
//                 builder: (context, provider, child) {
//                   final thanaList = provider.thanaList;
//                   return TypeAheadField<ThanaModel>(
//                     suggestionsCallback: (pattern) {
//                       if (pattern.isEmpty) {
//                         return thanaList;
//                       }
//                       return thanaList.where((item) {
//                         final name = item.name.toString().toLowerCase();
//                         return name.contains(pattern.toLowerCase());
//                       }).toList();
//                     },
//                     itemBuilder: (context,ThanaModel suggestion) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
//                         child: Text("${suggestion.name}"),
//                       );
//                     },
//                     onSelected: (ThanaModel suggestion) {
//                       thanaController.text = suggestion.name ?? "";
//                       thanaId = suggestion.id?.toString() ?? "";
//                       Provider.of<AreaProvider>(context,listen: false).getArea(thanaId);
//                       FocusScope.of(context).unfocus();
//                     },
//                     builder: (context,controller,focusNode,) {
//                       controller.text = thanaController.text;
//                       return TextField(
//                         controller: controller,
//                         focusNode: focusNode,
//                         decoration: InputDecoration(
//                           hintText: "Select Thana",
//                           contentPadding:EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
//                           suffixIcon: controller.text.isEmpty ? null : GestureDetector(
//                             onTap: () {
//                               controller.clear();
//                               thanaController.clear();
//                             },
//                             child: const Icon(Icons.close,size: 18),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       SizedBox(height: 5.h),
//       /// AREA
//       Row(
//         children: [
//           Expanded(
//             child: SizedBox(
//               height: 45.h,
//               child: Consumer<AreaProvider>(
//                 builder: (context, provider, child) {
//                   final areaList = provider.areaList;
//                   return TypeAheadField<AreaModel>(
//                     suggestionsCallback: (pattern) {
//                       if (pattern.isEmpty) {return areaList;}
//                       return areaList.where((item) {
//                         final name = item.name.toString().toLowerCase();
//                         return name.contains( pattern.toLowerCase());
//                       }).toList();
//                     },
//                     itemBuilder: (context,AreaModel suggestion) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
//                         child: Text("${suggestion.name}"),
//                       );
//                     },
//                     onSelected: ( AreaModel suggestion) {
//                       areaController.text =suggestion.name ?? "";
//                       areaId = suggestion.id?.toString()?? "";
//                       FocusScope.of(context).unfocus();
//                     },
//                     builder: (context,controller,focusNode) {
//                       controller.text = areaController.text;
//                       return TextField(
//                         controller: controller,
//                         focusNode: focusNode,
//                         decoration: InputDecoration(
//                           hintText:"Select Area",
//                           contentPadding:EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
//                           border: OutlineInputBorder(borderRadius:BorderRadius.circular(8.r)),
//                           suffixIcon:
//                           controller.text.isEmpty ? null: GestureDetector(
//                             onTap: () {
//                               controller.clear();
//                               areaController.clear();
//                             },
//                             child: const Icon(Icons.close,size: 18),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       SizedBox(height: 15.h),
//       _inputField(
//         "Billing address *",
//         "Billing Address*",
//         billingController,
//       ),
//       _inputField(
//         "Shipping address *",
//         "Shipping Address*",
//         shippingController,
//       ),
//     ],
//   );
// }

//   Widget _deliveryStep() {
//     return Column(
//       children: [
//       Padding(
//         padding: EdgeInsets.only(bottom: 5.h),
//         child: TextFormField(
//           controller: deliveryDateController,
//           readOnly: true,
//           onTap: () async {
//             DateTime? pickedDate = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(const Duration(days: 365),
//               ),
//             );
//             if (pickedDate != null) {
//               deliveryDateController.text = DateFormat('dd-MM-yyyy / EEEE').format(pickedDate);
//             }
//           },
//           decoration: InputDecoration(
//             labelText: "Delivery Date*",
//             hintText: "Select Delivery Date",
//             suffixIcon: const Icon(Icons.calendar_month,),
//             contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
//           ),
//         ),
//       ),
//       Row(
//         children: [
//           Expanded(
//             child: SizedBox(
//               height: 45.h,
//               child: Consumer<DeliveryTimesProvider>(
//                 builder: (context, provider, child) {
//                   final deliveryTimesList = provider.deliveryTimesList;
//                   return TypeAheadField<DeliveryTimesModel>(
//                     suggestionsCallback: (pattern) {
//                       if (pattern.isEmpty) {return deliveryTimesList;}
//                       return deliveryTimesList.where((item) {
//                         final name = item.time.toString().toLowerCase();
//                         return name.contains( pattern.toLowerCase());
//                       }).toList();
//                     },
//                     itemBuilder: (context,DeliveryTimesModel suggestion) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
//                         child: Text("${suggestion.time}"),
//                       );
//                     },
//                     onSelected: (DeliveryTimesModel suggestion) {
//                       deliveryTimesController.text =suggestion.time ?? "";
//                       deliveryTimesId = suggestion.groupId?.toString()?? "";
//                       FocusScope.of(context).unfocus();
//                     },
//                     builder: (context,controller,focusNode) {
//                       controller.text = deliveryTimesController.text;
//                       return TextField(
//                         controller: controller,
//                         focusNode: focusNode,
//                         decoration: InputDecoration(
//                           hintText:"Select Times",
//                           contentPadding:EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
//                           border: OutlineInputBorder(borderRadius:BorderRadius.circular(8.r)),
//                           suffixIcon:
//                           controller.text.isEmpty ? null: GestureDetector(
//                             onTap: () {
//                               controller.clear();
//                               deliveryTimesController.clear();
//                             },
//                             child: const Icon(Icons.close,size: 18),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//        ),
//       ],
//     );
//   }

//   Widget _summaryStep(List<AddToCartModel> cartList) {
//     return Column(
//       children: [
//         Text("Order Summery", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
//         SizedBox(height: 10.h),
//         Table(
//           border: TableBorder.all(color: Colors.grey.shade300),
//           columnWidths: const {
//             0: FlexColumnWidth(3),
//             1: FlexColumnWidth(1),
//             2: FlexColumnWidth(1),
//           },
//           children: [
//             const TableRow(
//               decoration: BoxDecoration(color: Colors.white),
//               children: [
//                 Padding(padding: EdgeInsets.all(8), child: Text("Products", style: TextStyle(fontWeight: FontWeight.bold))),
//                 Padding(padding: EdgeInsets.all(8), child: Text("Quantity", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
//                 Padding(padding: EdgeInsets.all(8), child: Text("Total", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
//               ],
//             ),
//             ...cartList.map((item) => TableRow(
//               children: [
//                 Padding(padding: EdgeInsets.all(8), child: Text(item.productName ?? "")),
//                 Padding(padding: EdgeInsets.all(8), child: Text("${item.quantity}", textAlign: TextAlign.center)),
//                 Padding(padding: EdgeInsets.all(8), child: Text("${item.discountPrice}", textAlign: TextAlign.center)),
//               ],
//             )).toList(),
//             TableRow(
//               children: [
//                 const Padding(padding: EdgeInsets.all(8), child: Text("Shipping Charge", style: TextStyle(fontWeight: FontWeight.bold))),
//                 const SizedBox(),
//                 Padding(padding: EdgeInsets.all(8), child: Text("0", textAlign: TextAlign.center)),
//               ],
//             ),
//             TableRow(
//               children: [
//                 const Padding(padding: EdgeInsets.all(8), child: Text("Total Amount", style: TextStyle(fontWeight: FontWeight.bold))),
//                 const SizedBox(),
//                 Padding(padding: EdgeInsets.all(8), child: Text("${widget.total} +", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _inputField(String hint, String label, TextEditingController controller) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 5.h),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
//         ),
//       ),
//     );
//   }
// }













// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
// import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({
//     super.key,
//     required this.quantity,
//     this.sizeId,
//     this.colorId,
//     required this.from,
//     this.addToCart,
//     this.total,
//     required this.token,
//   });

//   final int quantity;
//   final String? sizeId;
//   final String? colorId;
//   final String from;
//   final String token;
//   final String? total;
//   final List<AddToCartModel>? addToCart;

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   int currentStep = 0;
//   String userName = "";
//   String userEmail = "";
//   String userPhone = "";
//   String userAddress = "";

//   final _shipperNameController = TextEditingController();
//   final _shipperPhoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final districtController = TextEditingController();
//   final thanaController = TextEditingController();
//   final areaController = TextEditingController();
//   final billingController = TextEditingController();
//   final shippingController = TextEditingController();
//   final deliveryDateController = TextEditingController();
//   final deliveryNoteController = TextEditingController();

//   SharedPreferences? sharedPreferences;

//   Future<void> _initializeData() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       userName = sharedPreferences?.getString('name') ?? "";
//       userEmail = sharedPreferences?.getString('email') ?? "";
//       userPhone = sharedPreferences?.getString('phone') ?? "";
//       userAddress = sharedPreferences?.getString('address') ?? "";
      
//       _shipperNameController.text = userName;
//       _shipperPhoneController.text = userPhone;
//       _emailController.text = userEmail;
//       billingController.text = userAddress;
//       shippingController.text = userAddress;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<AddToCartProvider>(context);
//     final cartList = cartProvider.cart;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         centerTitle: true,
//         title: Column(
//           children: [
//             Text("Checkout", style: TextStyle(color: Colors.teal.shade900, fontWeight: FontWeight.bold)),
//             Text("Guest Checkout", style: TextStyle(fontSize: 14.sp, color: Colors.teal)),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(15.r),
//           child: Column(
//             children: [
//               /// STEP INDICATOR
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _stepCircle(0, "Account"),
//                   _stepDivider(0),
//                   _stepCircle(1, "Delivery Date"),
//                   _stepDivider(1),
//                   _stepCircle(2, "Order Summary"),
//                 ],
//               ),
//               SizedBox(height: 30.h),

//               /// STEP BODY
//               if (currentStep == 0) _accountStep(),
//               if (currentStep == 1) _deliveryStep(),
//               if (currentStep == 2) _summaryStep(cartList),

//               SizedBox(height: 30.h),

//               /// ACTION BUTTONS
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Previous Button
//                   if (currentStep > 0)
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 10.w),
//                         child: ElevatedButton(
//                           onPressed: () => setState(() => currentStep--),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF063321), // Dark Green
//                             padding: EdgeInsets.symmetric(vertical: 12.h),
//                           ),
//                           child: const Text("Previous", style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                     ),

//                   // Next / Place Order Button
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (currentStep < 2) {
//                           setState(() => currentStep++);
//                         } else {
//                           // TODO: Implement Place Order Logic
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF063321),
//                         padding: EdgeInsets.symmetric(vertical: 12.h),
//                       ),
//                       child: Text(
//                         currentStep == 2 ? "Place Order" : "Next",
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _stepDivider(int step) {
//     return Expanded(
//       child: Container(
//         height: 2,
//         color: currentStep > step ? Colors.green : Colors.grey.shade300,
//       ),
//     );
//   }

//   Widget _stepCircle(int step, String title) {
//     bool isCompleted = currentStep > step;
//     bool isActive = currentStep == step;

//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 15.r,
//           backgroundColor: isCompleted ? Colors.green : (isActive ? Colors.blue.shade800 : Colors.grey.shade300),
//           child: isCompleted 
//               ? Icon(Icons.check, size: 16.r, color: Colors.white)
//               : Text("${step + 1}", style: TextStyle(color: isActive ? Colors.white : Colors.black54)),
//         ),
//         SizedBox(height: 4.h),
//         Text(title, style: TextStyle(fontSize: 10.sp, color: Colors.black87)),
//       ],
//     );
//   }

//   Widget _accountStep() {
//     return Column(
//       children: [
//         _inputField("Enter Name *", "Name", _shipperNameController),
//         _inputField("Enter Phone Number *", "Phone", _shipperPhoneController),
//         _inputField("Enter Email", "Email", _emailController),
//         _inputField("Select District", "District", districtController),
//         _inputField("Thana *", "Thana", thanaController),
//         _inputField("Area *", "Area", areaController),
//         _inputField("Billing address *", "Billing Address*", billingController),
//         _inputField("Shipping address *", "Shipping Address*", shippingController),
//       ],
//     );
//   }

//   Widget _deliveryStep() {
//     return Column(
//       children: [
//         _inputField("17-05-2026 /Sunday", "Delivery Date*", deliveryDateController),
//         _inputField("9AM-10PM", "Select Time*", deliveryNoteController),
//       ],
//     );
//   }

//   Widget _summaryStep(List<AddToCartModel> cartList) {
//     return Column(
//       children: [
//         Text("Order Summery", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
//         SizedBox(height: 10.h),
//         Table(
//           border: TableBorder.all(color: Colors.grey.shade300),
//           columnWidths: const {
//             0: FlexColumnWidth(3),
//             1: FlexColumnWidth(1),
//             2: FlexColumnWidth(1),
//           },
//           children: [
//             const TableRow(
//               decoration: BoxDecoration(color: Colors.white),
//               children: [
//                 Padding(padding: EdgeInsets.all(8), child: Text("Products", style: TextStyle(fontWeight: FontWeight.bold))),
//                 Padding(padding: EdgeInsets.all(8), child: Text("Quantity", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
//                 Padding(padding: EdgeInsets.all(8), child: Text("Total", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
//               ],
//             ),
//             ...cartList.map((item) => TableRow(
//               children: [
//                 Padding(padding: EdgeInsets.all(8), child: Text(item.productName ?? "")),
//                 Padding(padding: EdgeInsets.all(8), child: Text("${item.quantity}", textAlign: TextAlign.center)),
//                 Padding(padding: EdgeInsets.all(8), child: Text("${item.discountPrice}", textAlign: TextAlign.center)),
//               ],
//             )).toList(),
//             TableRow(
//               children: [
//                 const Padding(padding: EdgeInsets.all(8), child: Text("Shipping Charge", style: TextStyle(fontWeight: FontWeight.bold))),
//                 const SizedBox(),
//                 Padding(padding: EdgeInsets.all(8), child: Text("0", textAlign: TextAlign.center)),
//               ],
//             ),
//             TableRow(
//               children: [
//                 const Padding(padding: EdgeInsets.all(8), child: Text("Total Amount", style: TextStyle(fontWeight: FontWeight.bold))),
//                 const SizedBox(),
//                 Padding(padding: EdgeInsets.all(8), child: Text("${widget.total} +", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _inputField(String hint, String label, TextEditingController controller) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15.h),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
//         ),
//       ),
//     );
//   }
// }


















// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
// import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({
//     super.key,
//     required this.quantity,
//     this.sizeId,
//     this.colorId,
//     required this.from,
//     this.addToCart,
//     this.total,
//     required this.token,
//   });

//   final int quantity;
//   final String? sizeId;
//   final String? colorId;
//   final String from;
//   final String token;
//   final String? total;
//   final List<AddToCartModel>? addToCart;

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }
// class _CheckoutScreenState extends State<CheckoutScreen> {
//   int currentStep = 0;
//   String userName = "";
//   String userEmail = "";
//   String userPhone = "";
//   String userAddress = "";

//   final _shipperNameController = TextEditingController();
//   final _shipperPhoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   final districtController = TextEditingController();
//   final thanaController = TextEditingController();
//   final areaController = TextEditingController();
//   final billingController = TextEditingController();
//   final shippingController = TextEditingController();
//   final deliveryDateController = TextEditingController();
//   final deliveryNoteController = TextEditingController();

//   SharedPreferences? sharedPreferences;
//   Future<void> _initializeData() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     userName ="${sharedPreferences?.getString('name')}";
//     userEmail ="${sharedPreferences?.getString('email')}";
//     userPhone = "${sharedPreferences?.getString('phone')}";
//     userAddress = "${sharedPreferences?.getString('address')}";
//     _shipperNameController.text = userName;
//     _shipperPhoneController.text = userPhone;
//     _emailController.text = userEmail;
//     billingController.text = userAddress;
//     shippingController.text = userAddress;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<AddToCartProvider>(context);
//     final cartList = cartProvider.cart;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//         title: Text("Checkout Page",style: AllTextStyle.getTitleTextStyle()),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(10.r),
//           child: Column(
//             children: [
//               /// STEP INDICATOR
//               Row(
//                 children: [
//                   _stepCircle(0,"Account Information"),
//                   Expanded(child: Divider(thickness: 2,color: Colors.grey.shade300)),
//                   _stepCircle(1,"Delivery       Date"),
//                   Expanded(child: Divider( thickness: 2,color:Colors.grey.shade300)),
//                   _stepCircle(2,"Order Summary"),
//                 ],
//               ),
//               SizedBox(height: 10.h),
//               /// STEP BODY
//               if (currentStep == 0)
//                 _accountStep(),
//               if (currentStep == 1)
//                 _deliveryStep(),
//               if (currentStep == 2)
//                 _summaryStep(cartList),
//               SizedBox(height: 10.h),
//               /// BUTTONS
//               Row(
//                 mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                 children: [
//                   if (currentStep != 0)
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           currentStep--;
//                         });
//                       },
//                       style:ElevatedButton.styleFrom(backgroundColor: appBarColor),
//                       child: const Text("Previous", style: TextStyle(color: Colors.white)),
//                     ),
//                   const Spacer(),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (currentStep < 2) {
//                         setState(() {
//                           currentStep++;
//                         });
//                       } else {
//                         // Utils.toastMessage(message:"Order Placed Successfully");
//                       }
//                     },
//                     style:ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green.shade900,
//                     ),
//                     child: Text(
//                       currentStep == 2 ? "Place Order" : "Next",
//                       style: const TextStyle(  color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// STEP CIRCLE
//   Widget _stepCircle(int step,String title) {
//     bool isActive = currentStep == step;
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 14.r,
//           backgroundColor: isActive? Colors.blue : Colors.grey.shade300,
//           child: Text("${step + 1}",
//             style: TextStyle(color: isActive ? Colors.white : Colors.black),
//           ),
//         ),
//         SizedBox(
//           width: 80.w,
//           child: Text(title,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
//   /// ACCOUNT STEP
//   Widget _accountStep() {
//     return Column(
//       children: [
//         _inputField(
//           "Enter Name *","Name",
//           _shipperNameController,
//         ),
//         _inputField(
//           "Enter Phone Number *","Phone",
//           _shipperPhoneController,
//         ),
//         _inputField(
//           "Enter Email","Email",
//           _emailController,
//         ),
//         _inputField(
//           "District","District",
//           districtController,
//         ),
//         _inputField(
//           "Thana *","Thana",
//           thanaController,
//         ),
//         _inputField(
//           "Area *","Area",
//           areaController,
//         ),
//         _inputField(
//           "Billing Address *","Billing Address *",
//           billingController,
//         ),
//         _inputField(
//           "Shipping Address *","Shipping Address *",
//           shippingController,
//         ),
//       ],
//     );
//   }

//   /// DELIVERY STEP
//   Widget _deliveryStep() {
//     return Column(
//       children: [
//         _inputField(
//           "Delivery Date","Delivery Date*",
//           deliveryDateController,
//         ),
//         TextFormField(
//           controller:deliveryNoteController,
//           maxLines: 4,
//           decoration: InputDecoration(
//             hintText: "Delivery Note",
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.r),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /// SUMMARY STEP
//   Widget _summaryStep(List<AddToCartModel> cartList) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(15.r),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade100,
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Column(
//             children: [
//               _summaryRow(
//                 "Subtotal",
//                 "৳ ${widget.total}",
//               ),
//               Divider(),
//               _summaryRow(
//                 "Delivery Charge",
//                 "(will be added)",
//               ),
//               Divider(),
//               _summaryRow(
//                 "Total Discount",
//                 "৳ 0",
//               ),
//               Divider(),
//               _summaryRow(
//                 "Total Amount",
//                 "৳ ${widget.total}",
//                 isBold: true,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 20.h),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: cartList.length,
//           itemBuilder: (context, index) {
//             final item =  cartList[index];
//             return Card(
//               elevation: 2,
//               child: ListTile(
//                 leading: SizedBox(
//                   height: 50,
//                   width: 50,
//                   child: CustomImage(
//                     path: item.image,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 title: Text(
//                   item.productName ?? "",
//                   maxLines: 2,
//                 ),
//                 subtitle: Text(
//                   "Qty: ${item.quantity}",
//                 ),
//                 trailing: Text(
//                   "৳${item.discountPrice}",
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
//   /// INPUT FIELD
//   Widget _inputField(String hint,String label,
//     TextEditingController controller,
//   ) {
//     return Padding(
//       padding:EdgeInsets.only(left: 15.w,right: 15.w, bottom: 10.h),
//       child: SizedBox(
//         height: 30.h,
//         child: TextFormField(
//           controller: controller,
//           style: TextStyle(fontSize: 11.sp),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(fontSize: 11.sp),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
//             labelText: label,
//             labelStyle: TextStyle(fontSize: 12.sp),
//           ),
//         ),
//       ),
//     );
//   }
//   /// SUMMARY ROW
//   Widget _summaryRow(String title,String value, {
//     bool isBold = false,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title,style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
//         Text(value,style: TextStyle(fontWeight:isBold ? FontWeight.bold : FontWeight.w500,color: Colors.green.shade900)),
//       ],
//     );
//   }
// }










// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:al_barakah_e_mart/custom_text_field/mycustom_text_form_field.dart';
// import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
// import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
// import 'package:al_barakah_e_mart/provider/cart_remove_provider.dart';
// import 'package:al_barakah_e_mart/screens/auth/pages/signin_page.dart';
// import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';
// import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
// import 'package:al_barakah_e_mart/utils/utils.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key,
//       required this.quantity,
//       this.sizeId,
//       this.colorId,
//       required this.from,
//       this.addToCart,
//       this.total,
//       required this.token});
//   final int quantity;
//   final String? sizeId;
//   final String? colorId;
//   final String from;
//   final String token;
//   final String? total;
//   final List<AddToCartModel>? addToCart;

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   String selectedMethod = "cash";
//   String userName = "";
//   String userEmail = "";
//   String userPhone = "";
//   String userAddress = "";
//   String userImage = "";
//   SharedPreferences? sharedPreferences;
//   Future<void> _initializeData() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     userName = "${sharedPreferences?.getString('name')}";
//     userEmail = "${sharedPreferences?.getString('email')}";
//     userPhone = "${sharedPreferences?.getString('phone')}";
//     userAddress = "${sharedPreferences?.getString('address')}";
//     userImage = "${sharedPreferences?.getString('image')}";

//    _shipperNameController.text = userName;
//     _shipperPhoneController.text = userPhone;
//     _emailController.text = userEmail;
//     _shipperAddressController.text = userAddress;
//   }
  
//   final _formKey = GlobalKey<FormState>();
//   final _shipperNameController = TextEditingController();
//   final _shipperPhoneController = TextEditingController();
//   final _shipperAddressController = TextEditingController();
//   final _emailController = TextEditingController();
//   final areaController = TextEditingController();

//   String? selectedArea;
//   double? deliveryCharge = 0;
//   double walletAdjustAmount = 0;
//   double walletAdjustPercent = 0;
//   double payable = 0;

//   late final Box box;
//   bool isWalletAdjusted = false;
//   bool isLoading = false;

//   var vat;
//   double subTotal = 0.0;
//   double totalAmmount = 0.0;
//   var total;

//   @override
//   void initState() {
//     _initializeData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;
//     totalAmmount = addToCartProviderList.map((e) => e.discountPrice).fold(0.0, (p, element) => p+double.parse("$element"));
//     double h2TextSize = 12.sp;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: InkWell(onTap: () {Navigator.pop(context);},
//         child: const Icon(Icons.arrow_back)),
//         foregroundColor: Colors.black,
//         backgroundColor: scaffoldColor,
//         title: Text('Checkout Page',style: AllTextStyle.getTitleTextStyle()),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Divider(),
//               const Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Text("Image",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ), Expanded(
//                     flex: 4,
//                     child: Text("Name",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Text("Qty",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text("Price",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Text("Total",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(),
//               widget.from == "cart"
//                   ? Column(
//                       children: List.generate(
//                       widget.addToCart!.length,
//                       (index) {
//                         return Padding(
//                           padding: EdgeInsets.only(top: 3.h),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.blueGrey.shade50,
//                               borderRadius: BorderRadius.circular(6.r),
//                               border: Border.all(color: Colors.blueGrey.shade100)
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                 flex: 2,
//                                 child:Padding(
//                                   padding: EdgeInsets.all(2.r),
//                                   child: CustomImage(
//                                     path:"${widget.addToCart![index].image}",
//                                   ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 4,
//                                   child: SizedBox(
//                                     child: Text(
//                                       "${widget.addToCart![index].productName}",
//                                       maxLines: 3,
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize:12.sp,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black87),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: SizedBox(
//                                     child: Text(
//                                       "${widget.addToCart![index].quantity}",
//                                       style: TextStyle(
//                                       fontSize:12.sp,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.black87),
//                                       maxLines: 1,
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: SizedBox(
//                                      child: Text(
//                                       "${widget.addToCart![index].discountPrice}",
//                                       maxLines: 1,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize:12.sp,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black87),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: SizedBox(
//                                     child: Text(
//                                       "${widget.addToCart![index].discountPrice! * double.parse("${widget.addToCart![index].quantity}")}",
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize:12.sp,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black87),
//                                     )),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ))
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: SizedBox(
//                             child: Text(
//                               "${widget.quantity}",
//                               style: TextStyle(
//                                 fontSize: h2TextSize,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black38,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: SizedBox(
//                               child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "BDT",
//                                 style: TextStyle(
//                                     fontSize: h2TextSize,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black38),
//                               ),
//                               Text(
//                                 "$subTotal",
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontSize: h2TextSize,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black38),
//                               ),
//                             ],
//                           )),
//                         ),
//                       ],
//                     ),
//               const Divider(),
//               Container(
//                 padding: EdgeInsets.all(20.r),
//                 decoration: BoxDecoration(
//                   color: Colors.blueGrey.shade50,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Subtotal: ", style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold)),
//                         Text(
//                           "BDT ${widget.total}",
//                           style: TextStyle(fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const Divider(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Delivery Charge :",
//                           style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold
//                           ),
//                         ),
//                         Text(
//                           "(will be added)",
//                           style: TextStyle(
//                               fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const Divider(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Total Discount :",
//                           style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold
//                           ),
//                         ),
//                         Text(
//                           "BDT  0",
//                           style: TextStyle(
//                               fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const Divider(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Total Amount:", style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold)),
//                         Text(
//                           "BDT ${widget.total}",
//                           style: TextStyle(fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const Divider(),
//                   ],
//                 ),
//               ),
//               Text(
//                 "Payment Method",
//                 style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
//               ),
//               const Divider(),
//               /// Cash on Delivery
//               Row(
//               children: [
//                 Expanded(
//                   child: RadioListTile(
//                     value: "cash",
//                     groupValue: selectedMethod,
//                     dense: true,
//                     visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//                     contentPadding: EdgeInsets.zero,
//                     title: Text(
//                       "Cash on Delivery",
//                       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp,color: selectedMethod=="cod"? Colors.green:Colors.black),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedMethod = value!;
//                       });
//                     },
//                   ),
//                 ),

//                 Expanded(
//                   child: RadioListTile(
//                     value: "online",
//                     groupValue: selectedMethod,
//                     dense: true,
//                     visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//                     contentPadding: EdgeInsets.zero,
//                     title: Text(
//                       "Online Payment",
//                       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp,color: selectedMethod=="online"? Colors.green:Colors.black),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedMethod = value!;
//                       });
//                     },
//                   ),
//                 ),

//               ],
//             ),
//               /// Conditional Show
//               if (selectedMethod == "cash")
//                 Container(
//                   padding: EdgeInsets.all(10.r),
//                   decoration: BoxDecoration(
//                     color: Colors.orange.shade100,
//                     borderRadius: BorderRadius.circular(6.r),
//                   ),
//                   child: Text(
//                     "Please Call For 01711514200",style: GoogleFonts.poppins(
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black,
//                       fontStyle: FontStyle.italic
//                     )
//                   ),
//                 ),
//               if (selectedMethod == "online")
//                 Container(
//                   padding: EdgeInsets.only(bottom: 4.h,top: 4.h),
//                   decoration: BoxDecoration(
//                     color: Colors.orange.shade100,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         children: [
//                           CustomImage(
//                             path:"images/bkash.png",
//                             width: 20.w,
//                           ),
//                           const SizedBox(width: 4),
//                           Text("bKash:\n01711514200",style: GoogleFonts.poppins(
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                             fontStyle: FontStyle.italic
//                           )),
//                         ],
//                       ),
//                       const SizedBox(width: 4),
//                       Row(
//                         children: [
//                           CustomImage(
//                             path:"images/nagod.png",
//                             width: 20.w,
//                           ),
//                           const SizedBox(width: 4),
//                           Text("Nagad:\n01711514200",style: GoogleFonts.poppins(
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                             fontStyle: FontStyle.italic
//                           )),
//                         ],
//                       ),
//                       const SizedBox(width: 4),
//                       Row(
//                         children: [
//                           CustomImage(
//                             path:"images/rocket.png",
//                             width: 20.w,
//                           ),
//                           const SizedBox(width: 4),
//                           Text("Rocket:\n01711514200",style: GoogleFonts.poppins(
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                             fontStyle: FontStyle.italic
//                           )),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(),
//                 SizedBox(height: 10.h),
//               //Shipping Information Section
//               Text('Billing details',style: TextStyle( fontSize: h2TextSize, fontWeight: FontWeight.bold,color: Colors.black)),
//               Container(
//                 margin: EdgeInsets.only(top: 15.h),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 15.h),
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(255, 231, 231, 231),
//                             borderRadius: BorderRadius.circular(10.r)),
//                         child: Column(
//                           children: [
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                      Text("Your Name *", style: TextStyle(fontSize: h2TextSize)),
//                                       SizedBox(height: 5.h),
//                                       SizedBox(
//                                         height: 30.h,
//                                         width: MediaQuery.of(context).size.width/2.3,
//                                         child: MyCustomTextFormField().getCustomEditTextArea(
//                                             hintValue: 'Name',
//                                             validation: true,
//                                             controller: _shipperNameController,
//                                             keyboardType: TextInputType.text,
//                                             validationErrorMsg: 'error_msg'),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(width: 5.w),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text("Phone number *", style: TextStyle(fontSize: h2TextSize)),
//                                       SizedBox(height: 5.h),
//                                       SizedBox(
//                                         height: 30.h,
//                                         width: MediaQuery.of(context).size.width/2.3,
//                                         child: MyCustomTextFormField().getCustomEditTextArea(
//                                             hintValue: 'Phone number',
//                                             validation: true,
//                                             controller: _shipperPhoneController,
//                                             keyboardType: TextInputType.phone,
//                                             validationErrorMsg: 'error_msg'),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 15.h),
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Email *", style: TextStyle(fontSize: h2TextSize)),
//                                   SizedBox(height: 5.h),
//                                   Container(
//                                     height: 30.h,
//                                     width: MediaQuery.of(context).size.width,
//                                     padding: EdgeInsets.only(right: 35.h),
//                                     child: MyCustomTextFormField().getCustomEditTextArea(
//                                         hintValue: 'Enter email',
//                                         validation: true,
//                                         controller: _emailController,
//                                         keyboardType: TextInputType.text,
//                                         validationErrorMsg: 'error_msg'),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 15.h),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Shipping Adreess *", style: TextStyle(fontSize: h2TextSize)),
//                                 SizedBox(height: 5.h),
//                                 SizedBox(
//                                   height: 30.h,
//                                   width: MediaQuery.of(context).size.width,
//                                   child: MyCustomTextFormField().getCustomEditTextArea(
//                                       hintValue: 'Shipping Adreess',
//                                       validation: true,
//                                       controller: _shipperAddressController,
//                                       keyboardType: TextInputType.text,
//                                       validationErrorMsg: 'error_msg'),
//                                 )
//                               ],
//                             ),
//                             SizedBox(height: 15.h),
//                             const Divider(),
//                             Padding(
//                               padding: EdgeInsets.only(top:5.h,bottom: 10.h),
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: applineColor,
//                                   minimumSize: Size.fromHeight(35.h),
//                                 ),
//                                 onPressed: () {
//                                   /// 🔥 1️⃣ First Check → User Logged In or Not
//                                   if (widget.token == "" || widget.token.isEmpty) {
//                                     Utils.errorSnackBarWithButton(
//                                       context,
//                                       "Sign In Please",
//                                       () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => const SignInPage(),
//                                           ),
//                                         );
//                                       },
//                                     );
//                                     return; 
//                                   }
//                                   /// 🔥 2️⃣ Then Check Mobile
//                                   if (_shipperPhoneController.text.trim().isEmpty) {
//                                     Utils.showTopSnackBar(context, "Please Enter Mobile");
//                                     return;
//                                   }
//                                   /// 🔥 3️⃣ Everything OK → Place Order
//                                   setState(() {
//                                     isLoading = true;
//                                   });
//                                   placeOrder(context);
//                                 },
//                                 child: isLoading
//                                     ? const SizedBox(
//                                         height: 18,
//                                         width: 18,
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                           strokeWidth: 2,
//                                         ),
//                                       )
//                                     : Text(
//                                         "PLACE ORDER",
//                                         style: AllTextStyle.tableHeadTextStyle,
//                                       ),
//                               ),
//                             ),
//                            SizedBox(height: 10.h),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




















// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:al_barakah_e_mart/custom_text_field/mycustom_text_form_field.dart';
// import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
// import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
// import 'package:al_barakah_e_mart/provider/cart_remove_provider.dart';
// import 'package:al_barakah_e_mart/screens/auth/pages/signin_page.dart';
// import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:al_barakah_e_mart/utils/constants.dart';
// import 'package:al_barakah_e_mart/utils/custom_image.dart';
// import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
// import 'package:al_barakah_e_mart/utils/utils.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key,
//       required this.quantity,
//       this.sizeId,
//       this.colorId,
//       required this.from,
//       this.addToCart,
//       this.total,
//       required this.token});
//   final int quantity;
//   final String? sizeId;
//   final String? colorId;
//   final String from;
//   final String token;
//   final String? total;
//   final List<AddToCartModel>? addToCart;

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   String selectedMethod = "cash";
//   String userName = "";
//   String userEmail = "";
//   String userPhone = "";
//   String userAddress = "";
//   String userImage = "";
//   SharedPreferences? sharedPreferences;
//   Future<void> _initializeData() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     userName = "${sharedPreferences?.getString('name')}";
//     userEmail = "${sharedPreferences?.getString('email')}";
//     userPhone = "${sharedPreferences?.getString('phone')}";
//     userAddress = "${sharedPreferences?.getString('address')}";
//     userImage = "${sharedPreferences?.getString('image')}";

//    _shipperNameController.text = userName;
//     _shipperPhoneController.text = userPhone;
//     _emailController.text = userEmail;
//     _shipperAddressController.text = userAddress;
//   }
  
//   final _formKey = GlobalKey<FormState>();

//   final _shipperNameController = TextEditingController();
//   final _shipperPhoneController = TextEditingController();
//   final _shipperAddressController = TextEditingController();
//   //final _couponCodeController = TextEditingController();
//   final _emailController = TextEditingController();
//   final areaController = TextEditingController();

//   String? selectedArea;
//   double? deliveryCharge = 0;
//   double walletAdjustAmount = 0;
//   double walletAdjustPercent = 0;
//   double payable = 0;

//   late final Box box;
//   bool isWalletAdjusted = false;
//   bool isLoading = false;

// Future<void> placeOrder(BuildContext context) async {
//   setState(() {
//     isLoading = true;
//   });

//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   String link = "${BaseUrl}customer_order_store";

//   try {
//     Map<String, dynamic> body = {
//       "data": {
//         "payment_method": selectedMethod,
//         "name": _shipperNameController.text.trim(),
//         "phone": _shipperPhoneController.text.trim(),
//         "email": _emailController.text.trim(),
//         "address": _shipperAddressController.text.trim(),
//         "coupon": "",
//         "voucher": "",
//         "subtotal": widget.total.toString(),
//         "discount": "0",
//         "discount_type": "fixed",
//         "total": widget.total.toString(),
//         "agree": "1"
//       },
//       "cart": widget.from == 'cart'
//           ? List.generate(widget.addToCart!.length, (index) {
//               var item = widget.addToCart![index];

//               return {
//                 "id": item.id.toString(),
//                 "name": item.productName ?? "",
//                 "price": item.discountPrice.toString(),
//                 "quantity": item.quantity.toString(),
//                 "total": (double.parse(item.discountPrice.toString()) *
//                         int.parse(item.quantity.toString()))
//                     .toStringAsFixed(2),
//                 "main_image": item.image ?? "",
//                 "options": [
//                   {
//                     "color": "0",
//                     "storage": null,
//                     "network": null,
//                     "region": null,
//                     "size": null
//                   }
//                 ]
//               };
//             })
//           : [
//               {
//                 "quantity": widget.quantity.toString(),
//               }
//             ]
//     };

//     /// 🔥🔥 FULL DEBUG PRINT START 🔥🔥

//     print("========== ORDER BODY DEBUG START ==========");

//     print("---- DATA SECTION ----");
//     body["data"].forEach((key, value) {
//       print("$key : $value");
//     });

//     print("---- CART SECTION ----");

//     for (int i = 0; i < body["cart"].length; i++) {
//       print("Item Index: $i");

//       body["cart"][i].forEach((key, value) {
//         if (key == "options") {
//           print("  $key :");
//           for (var option in value) {
//             option.forEach((k, v) {
//               print("     $k : $v");
//             });
//           }
//         } else {
//           print("  $key : $value");
//         }
//       });

//       print("----------------------");
//     }

//     print("========== ORDER BODY DEBUG END ==========");

//     /// 🔥🔥 FULL DEBUG PRINT END 🔥🔥

//     Response response = await Dio().post(
//       link,
//       data: body,
//       options: Options(
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer ${sharedPreferences.getString("token")}",
//         },
//       ),
//     );

//     var res = response.data;
//     print("orderPlace response==== $res");

//     if (res != null && res['status'] == "success") {
//       CustomSnackBar.showTopSnackBar(context, "Order Placed Successfully!");

//       if (widget.from == 'cart') {
//         Provider.of<AddToCartProvider>(context, listen: false).clearCart();
//         Provider.of<RemoveCartProvider>(context, listen: false).clear();
//       }

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => MainScreen()),
//       );
//     } else {
//       Utils.showTopSnackBar(context, res['message'] ?? "Try again!");
//     }
//   } catch (e) {
//     print("Error =====> $e");
//     Utils.showTopSnackBar(context, "Something went wrong!");
//   } finally {
//     setState(() {
//       isLoading = false;
//     });
//   }
// }

//   var vat;
//   double subTotal = 0.0;
//   double totalAmmount = 0.0;
//   var total;

//   @override
//   void initState() {
//     _initializeData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;
//     totalAmmount = addToCartProviderList.map((e) => e.discountPrice).fold(0.0, (p, element) => p+double.parse("$element"));
//     double h2TextSize = 12.sp;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: InkWell(onTap: () {Navigator.pop(context);},
//         child: const Icon(Icons.arrow_back)),
//         foregroundColor: Colors.black,
//         backgroundColor: scaffoldColor,
//         title: Text('Checkout Page',style: AllTextStyle.getTitleTextStyle()),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Divider(),
//               const Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Text("Image",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ), Expanded(
//                     flex: 4,
//                     child: Text("Name",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Text("Qty",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text("Price",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Text("Total",textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//               const Divider(),
//               widget.from == "cart"
//                   ? Column(
//                       children: List.generate(
//                       widget.addToCart!.length,
//                       (index) {
//                         return Padding(
//                           padding: EdgeInsets.only(top: 3.h),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.blueGrey.shade50,
//                               borderRadius: BorderRadius.circular(6.r),
//                               border: Border.all(color: Colors.blueGrey.shade100)
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                 flex: 2,
//                                 child:Padding(
//                                   padding: EdgeInsets.all(2.r),
//                                   child: CustomImage(
//                                     path:"${widget.addToCart![index].image}",
//                                   ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 4,
//                                   child: SizedBox(
//                                     child: Text(
//                                       "${widget.addToCart![index].productName}",
//                                       maxLines: 3,
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize:12.sp,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black87),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: SizedBox(
//                                     child: Text(
//                                       "${widget.addToCart![index].quantity}",
//                                       style: TextStyle(
//                                       fontSize:12.sp,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.black87),
//                                       maxLines: 1,
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: SizedBox(
//                                      child: Text(
//                                       "${widget.addToCart![index].discountPrice}",
//                                       maxLines: 1,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize:12.sp,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black87),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: SizedBox(
//                                     child: Text(
//                                       "${widget.addToCart![index].discountPrice! * double.parse("${widget.addToCart![index].quantity}")}",
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize:12.sp,
//                                           fontWeight: FontWeight.w400,
//                                           color: Colors.black87),
//                                     )),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ))
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: SizedBox(
//                             child: Text(
//                               "${widget.quantity}",
//                               style: TextStyle(
//                                 fontSize: h2TextSize,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black38,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: SizedBox(
//                               child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(
//                                 "BDT",
//                                 style: TextStyle(
//                                     fontSize: h2TextSize,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black38),
//                               ),
//                               Text(
//                                 "$subTotal",
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     fontSize: h2TextSize,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black38),
//                               ),
//                             ],
//                           )),
//                         ),
//                       ],
//                     ),
//               const Divider(),
//               //       Row(
//               //         crossAxisAlignment: CrossAxisAlignment.start,
//               //         children: [
//               //           Expanded(
//               //             flex: 3,
//               //             child: SizedBox(
//               //               height: 30.h,
//               //               width: MediaQuery.of(context).size.width,
//               //               child: MyCustomTextFormField().getCustomEditTextArea(
//               //                   hintValue: 'Coupon Code',
//               //                   validation: true,
//               //                   controller: _couponCodeController,
//               //                   keyboardType: TextInputType.text,
//               //                   validationErrorMsg: 'error_msg'),
//               //             ),
//               //           ),
//               //           SizedBox(width: 5.w),
//               //           Expanded(
//               //             child: Container(
//               //               height: 30.h,
//               //               decoration: BoxDecoration(
//               //                 borderRadius: BorderRadius.circular(100.r),
//               //                 color: appbuttonColor,
//               //                 boxShadow: [
//               //                   BoxShadow(
//               //                     color: Colors.black.withOpacity(0.2),
//               //                     blurRadius: 10,
//               //                     spreadRadius: 1,
//               //                     offset: const Offset(0, 4),
//               //                   ),
//               //                 ],
//               //                ),
//               //               child: Center(child: Text("Apply",style: AllTextStyle.tableHeadTextStyle)),
//               //             ),
//               //           ),
//               //         ],
//               //       ),
//               // const Divider(),
//               Container(
//                 padding: EdgeInsets.all(20.r),
//                 decoration: BoxDecoration(
//                   color: Colors.blueGrey.shade50,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Subtotal: ", style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold)),
//                         Text(
//                           "BDT ${widget.total}",
//                           style: TextStyle(fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const Divider(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Delivery Charge :",
//                           style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold
//                           ),
//                         ),
//                         Text(
//                           "(will be added)",
//                           style: TextStyle(
//                               fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const Divider(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Total Discount :",
//                           style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold
//                           ),
//                         ),
//                         Text(
//                           "BDT  0",
//                           style: TextStyle(
//                               fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const Divider(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Total Amount:", style: TextStyle(fontSize: h2TextSize, fontWeight: FontWeight.bold)),
//                         Text(
//                           "BDT ${widget.total}",
//                           style: TextStyle(fontSize: h2TextSize, color: Colors.amber.shade800, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     const Divider(),
//                   ],
//                 ),
//               ),
//               Text(
//                 "Payment Method",
//                 style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
//               ),
//               const Divider(),
//               /// Cash on Delivery
//               Row(
//               children: [
//                 Expanded(
//                   child: RadioListTile(
//                     value: "cash",
//                     groupValue: selectedMethod,
//                     dense: true,
//                     visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//                     contentPadding: EdgeInsets.zero,
//                     title: Text(
//                       "Cash on Delivery",
//                       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp,color: selectedMethod=="cod"? Colors.green:Colors.black),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedMethod = value!;
//                       });
//                     },
//                   ),
//                 ),

//                 Expanded(
//                   child: RadioListTile(
//                     value: "online",
//                     groupValue: selectedMethod,
//                     dense: true,
//                     visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//                     contentPadding: EdgeInsets.zero,
//                     title: Text(
//                       "Online Payment",
//                       style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp,color: selectedMethod=="online"? Colors.green:Colors.black),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedMethod = value!;
//                       });
//                     },
//                   ),
//                 ),

//               ],
//             ),
//               /// Conditional Show
//               if (selectedMethod == "cash")
//                 Container(
//                   padding: EdgeInsets.all(10.r),
//                   decoration: BoxDecoration(
//                     color: Colors.orange.shade100,
//                     borderRadius: BorderRadius.circular(6.r),
//                   ),
//                   child: Text(
//                     "Please Call For 01711514200",style: GoogleFonts.poppins(
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black,
//                       fontStyle: FontStyle.italic
//                     )
//                   ),
//                 ),
//               if (selectedMethod == "online")
//                 Container(
//                   padding: EdgeInsets.only(bottom: 4.h,top: 4.h),
//                   decoration: BoxDecoration(
//                     color: Colors.orange.shade100,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         children: [
//                           CustomImage(
//                             path:"images/bkash.png",
//                             width: 20.w,
//                           ),
//                           const SizedBox(width: 4),
//                           Text("bKash:\n01711514200",style: GoogleFonts.poppins(
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                             fontStyle: FontStyle.italic
//                           )),
//                         ],
//                       ),
//                       const SizedBox(width: 4),
//                       Row(
//                         children: [
//                           CustomImage(
//                             path:"images/nagod.png",
//                             width: 20.w,
//                           ),
//                           const SizedBox(width: 4),
//                           Text("Nagad:\n01711514200",style: GoogleFonts.poppins(
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                             fontStyle: FontStyle.italic
//                           )),
//                         ],
//                       ),
//                       const SizedBox(width: 4),
//                       Row(
//                         children: [
//                           CustomImage(
//                             path:"images/rocket.png",
//                             width: 20.w,
//                           ),
//                           const SizedBox(width: 4),
//                           Text("Rocket:\n01711514200",style: GoogleFonts.poppins(
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                             fontStyle: FontStyle.italic
//                           )),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(),
//                 SizedBox(height: 10.h),
//               //Shipping Information Section
//               Text('Billing details',style: TextStyle( fontSize: h2TextSize, fontWeight: FontWeight.bold,color: Colors.black)),
//               Container(
//                 margin: EdgeInsets.only(top: 15.h),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 15.h),
//                         decoration: BoxDecoration(
//                             color: const Color.fromARGB(255, 231, 231, 231),
//                             borderRadius: BorderRadius.circular(10.r)),
//                         child: Column(
//                           children: [
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                      Text("Your Name *", style: TextStyle(fontSize: h2TextSize)),
//                                       SizedBox(height: 5.h),
//                                       SizedBox(
//                                         height: 30.h,
//                                         width: MediaQuery.of(context).size.width/2.3,
//                                         child: MyCustomTextFormField().getCustomEditTextArea(
//                                             hintValue: 'Name',
//                                             validation: true,
//                                             controller: _shipperNameController,
//                                             keyboardType: TextInputType.text,
//                                             validationErrorMsg: 'error_msg'),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(width: 5.w),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text("Phone number *", style: TextStyle(fontSize: h2TextSize)),
//                                       SizedBox(height: 5.h),
//                                       SizedBox(
//                                         height: 30.h,
//                                         width: MediaQuery.of(context).size.width/2.3,
//                                         child: MyCustomTextFormField().getCustomEditTextArea(
//                                             hintValue: 'Phone number',
//                                             validation: true,
//                                             controller: _shipperPhoneController,
//                                             keyboardType: TextInputType.phone,
//                                             validationErrorMsg: 'error_msg'),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 15.h),
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Email *", style: TextStyle(fontSize: h2TextSize)),
//                                   SizedBox(height: 5.h),
//                                   Container(
//                                     height: 30.h,
//                                     width: MediaQuery.of(context).size.width,
//                                     padding: EdgeInsets.only(right: 35.h),
//                                     child: MyCustomTextFormField().getCustomEditTextArea(
//                                         hintValue: 'Enter email',
//                                         validation: true,
//                                         controller: _emailController,
//                                         keyboardType: TextInputType.text,
//                                         validationErrorMsg: 'error_msg'),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 15.h),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Shipping Adreess *", style: TextStyle(fontSize: h2TextSize)),
//                                 SizedBox(height: 5.h),
//                                 SizedBox(
//                                   height: 30.h,
//                                   width: MediaQuery.of(context).size.width,
//                                   child: MyCustomTextFormField().getCustomEditTextArea(
//                                       hintValue: 'Shipping Adreess',
//                                       validation: true,
//                                       controller: _shipperAddressController,
//                                       keyboardType: TextInputType.text,
//                                       validationErrorMsg: 'error_msg'),
//                                 )
//                               ],
//                             ),
//                             SizedBox(height: 15.h),
//                             const Divider(),
//                             Padding(
//                               padding: EdgeInsets.only(top:5.h,bottom: 10.h),
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: applineColor,
//                                   minimumSize: Size.fromHeight(35.h),
//                                 ),
//                                 onPressed: () {

//                                   /// 🔥 1️⃣ First Check → User Logged In or Not
//                                   if (widget.token == "" || widget.token.isEmpty) {

//                                     Utils.errorSnackBarWithButton(
//                                       context,
//                                       "Sign In Please",
//                                       () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => const SignInPage(),
//                                           ),
//                                         );
//                                       },
//                                     );
//                                     return; 
//                                   }

//                                   /// 🔥 2️⃣ Then Check Mobile
//                                   if (_shipperPhoneController.text.trim().isEmpty) {
//                                     Utils.showTopSnackBar(context, "Please Enter Mobile");
//                                     return;
//                                   }

//                                   /// 🔥 3️⃣ Everything OK → Place Order
//                                   setState(() {
//                                     isLoading = true;
//                                   });

//                                   placeOrder(context);
//                                 },
//                                 child: isLoading
//                                     ? const SizedBox(
//                                         height: 18,
//                                         width: 18,
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                           strokeWidth: 2,
//                                         ),
//                                       )
//                                     : Text(
//                                         "PLACE ORDER",
//                                         style: AllTextStyle.tableHeadTextStyle,
//                                       ),
//                               ),
//                             ),
//                            SizedBox(height: 10.h),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
