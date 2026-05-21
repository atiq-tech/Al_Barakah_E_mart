import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:al_barakah_e_mart/custom/custom_drtawer/all_drawer_section/change_password.dart';
import 'package:al_barakah_e_mart/custom/custom_drtawer/all_drawer_section/update_profile_page.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
import 'package:al_barakah_e_mart/provider/token_provider/token_provider.dart';
import 'package:al_barakah_e_mart/provider/user_profile_provider.dart';
import 'package:al_barakah_e_mart/screens/auth/pages/signin_page.dart';
import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
import 'package:al_barakah_e_mart/screens/order/order_history_screen.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:al_barakah_e_mart/utils/custom_snackbar.dart';
import 'package:al_barakah_e_mart/utils/utils.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  String? userName = "User";
  String? customerId = "";
  String? authType = "";
  Future<void> _initializeData() async {
    customerId = "${sharedPreferences.getString('id')}";
    userName = "${sharedPreferences.getString('name')}";
    authType = "${sharedPreferences.getString('auth_type')}";

    print("auth_type=========$authType");
  }
  

  @override
  void initState() {
    _initializeData();
    // TODO: implement initState
    super.initState();
    Provider.of<TokenProvider>(context, listen: false).getToken();
    Provider.of<UserProfileProvider>(context, listen: false).getUserProfile();
  }
  
  @override
  Widget build(BuildContext context) {
    final addToCartProviderList = Provider.of<AddToCartProvider>(context, listen: true).cart;
    final customerId = "${sharedPreferences.getString('id')}";
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false, // 🔥 back icon remove
      //   title: Text(
      //     "Hello, ${userName ?? 'User'}",
      //     style: GoogleFonts.adamina(
      //       fontSize: 12.sp,
      //       fontWeight: FontWeight.w700,
      //       color: Colors.black,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: LayoutBuilder(
        builder: (context, constraints) {
                  if (customerId == "null" || customerId == "" || customerId.isEmpty) {
          return Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                },
                child: const Text("Sign in Please")),
          );
      }
      else {
      return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w,top: 20.h),
      child: GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 12.h,
      children: [
      
        /// Home Page
        dashboardItem(
          context,
          title: "Home",
          icon: Icons.home,
          color: Colors.blue,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
          },
        ),
      
        /// My Order
        dashboardItem(
          context,
          title: "Orders History",
          icon: Icons.shopping_cart,
          color: Colors.green,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => OrderHistoryScreen()));
          },
        ),
      
        /// My Profile
        dashboardItem(
          context,
          title: "My Profile",
          icon: Icons.person,
          color: Colors.purple,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateProfile()));
          },
        ),
        /// All Brand
        // authType == "reseller" ?  dashboardItem(
        //   context,
        //   title: "Product List",
        //   icon: Icons.card_giftcard,
        //   color: Colors.indigo,
        //   onTap: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (_) => ProductListScreen()));
        //   },
        // ): dashboardItem(
        //   context,
        //   title: "All Brand",
        //   icon: Icons.branding_watermark,
        //   color: Colors.purple,
        //   onTap: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (_) => BrandsWiseAllItemsScreen()));
        //   },
        // ),
      
        /// Change Password
        dashboardItem(
          context,
          title: "Change Password",
          icon: Icons.lock,
          color: Colors.teal,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePassword()));
          },
        ),
      
        /// Logout
        dashboardItem(
          context,
          title: "Logout",
          icon: Icons.logout,
          color: Colors.red,
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            addToCartProviderList.clear();
            Provider.of<TokenProvider>(context, listen: false).removeAToken();
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInPage()),(route) => false);
            logoutApi(context);
            CustomSnackBar.showTopSnackBar(context, "User Logged out successfully");
          },
        ),
      ],
      ),
    );
    }
  }),
    );
  }

  /// Reusable Dashboard Item
  Widget dashboardItem(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: color),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(
                  icon,
                  size: 30.sp,
                  color: color,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logoutApi(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  try {
    String url = "${BaseUrl}customer_logout";
    final response = await Dio().post(
      url,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    var data = response.data;

    if (data["success"] == true) {
      CustomSnackBar.showTopSnackBar(context, data["message"] ?? "Logged out");
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 401) {
      print("Token expired → local logout");
    } else {
      Utils.showTopSnackBar(context, "Logout failed");
      return;
    }
  } catch (e) {
    Utils.showTopSnackBar(context, "Logout failed");
    return;
  }

  /// ✅ LOCAL LOGOUT
  Provider.of<TokenProvider>(context, listen: false).removeAToken();
  await prefs.clear();

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const SignInPage()),(route) => false,
  );
}
}


















// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:al_barakah_e_mart/all_api_provider/all_orders_provider.dart';
// import 'package:al_barakah_e_mart/screens/main/main_screen.dart';
// import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DashBoardPage extends StatefulWidget {
//   const DashBoardPage({super.key, required this.userName});
//   final String userName;

//   @override
//   State<DashBoardPage> createState() => _DashBoardPageState();
// }

// class _DashBoardPageState extends State<DashBoardPage> {
//   @override
//   void initState() {
//     AllOrdersProvider.isAllOrderLoading = true;
//     //Provider.of<AllOrdersProvider>(context,listen: false).allOrderModellist = [];
//     Provider.of<AllOrdersProvider>(context,listen: false).getGetOrders();
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final allOrdersData = Provider.of<AllOrdersProvider>(context).allOrderModellist;
//     print("allOrdersData=======  ${allOrdersData.length}");
//     return Scaffold(
//         appBar: AppBar(
//             backgroundColor: Colors.blueGrey,
//             title: const Text("DashBoard",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
//             centerTitle: true,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
//             },
//               child: const Icon(Icons.arrow_back,color: Colors.white)),
//         ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.all(10.r),
//         margin: EdgeInsets.all(10.r),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.blueGrey),
//           borderRadius: BorderRadius.circular(10.r)
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("My DashBoard",style: AllTextStyle.appbarTextStyle),
//                 SizedBox(height: 15.h),
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       const TextSpan(text: 'Hello, ',style: TextStyle(color: Colors.black)),
//                       TextSpan(text: '${widget.userName} ', style: TextStyle(color: Colors.blue.shade600,fontWeight: FontWeight.w500)),
//                       const TextSpan(text: '!', style: TextStyle(color: Colors.black)),
//                     ],
//                   ),
//                 ),
//                 const Text("From your My Account Dashboard you have the ability to view a snapshot of your recent account activity and update your account information. Select a link below to view or edit information.",textAlign: TextAlign.justify),
//                 SizedBox(height: 15.h),
//                 Text("Latest Order",style: AllTextStyle.appbarTextStyle),
//                 SizedBox(height: 10.h),
//                 AllOrdersProvider.isAllOrderLoading == true ? Padding(padding: EdgeInsets.symmetric(vertical: 20.h),
//                   child: Center(child: CircularProgressIndicator()),
//                 ):allOrdersData.isNotEmpty?
//                 SizedBox(
//                   width: double.infinity,
//                   height: MediaQuery.of(context).size.height / 1.43,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         headingRowHeight: 20.0,
//                         dataRowHeight: 20.0,
//                         headingRowColor: WidgetStateColor.resolveWith((states) => Colors.blueGrey),
//                         showCheckboxColumn: true,
//                         border:
//                         TableBorder.all(color: Colors.black54, width: 1.w),
//                         columns: [
//                           DataColumn(label: Expanded(child: Center(child: Text('SL',style: AllTextStyle.tableHeadTextStyle))),),
//                           DataColumn(label: Expanded(child: Center(child: Text('Date',style: AllTextStyle.tableHeadTextStyle))),),
//                           DataColumn(label: Expanded(child: Center(child: Text('Order No',style: AllTextStyle.tableHeadTextStyle))),),
//                           DataColumn(label: Expanded(child: Center(child: Text('Phone',style: AllTextStyle.tableHeadTextStyle))),),
//                           DataColumn(label: Expanded(child: Center(child: Text('Total',style: AllTextStyle.tableHeadTextStyle))),),
//                           DataColumn(label: Expanded(child: Center(child: Text('Status',style: AllTextStyle.tableHeadTextStyle))),),
//                           //DataColumn(label: Expanded(child: Center(child: Text('Action',style: AllTextStyle.tableHeadTextStyle))),),
//                         ],
//                         rows: List.generate(
//                           allOrdersData.length,
//                             (int index) => DataRow(
//                             cells: <DataCell>[
//                               DataCell(Center(child: Text('${index+1}')),),
//                               DataCell(Center(child: Text(allOrdersData[index].orderDate)),),
//                               DataCell(Center(child: Text(allOrdersData[index].orderNumber)),),
//                               DataCell(Center(child: Text(allOrdersData[index].phone)),),
//                               DataCell(Center(child: Text("TK.${allOrdersData[index].totalAmount}")),),
//                               DataCell(Container(
//                                   width: 75.w,
//                                   margin: EdgeInsets.symmetric(vertical: 2.5.h),
//                                   decoration: BoxDecoration(
//                                       color:allOrdersData[index].status == "Pending"?Colors.cyanAccent.shade400:Colors.orange,
//                                       borderRadius: BorderRadius.circular(4.r)),
//                                   child: Center(child: Text(allOrdersData[index].status,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500))))),
//                               // DataCell(Center(child: Text('')),),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ): Align(alignment: Alignment.center,child: Center(child: Text("No Data Found",style: TextStyle(fontSize: 16.sp,color: Colors.red)))),
//               ]
//           ),
//         ),
//       ),
//     );
//   }
// }