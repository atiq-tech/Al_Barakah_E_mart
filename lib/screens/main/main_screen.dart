import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/custom/custom_drtawer/all_drawer_section/update_profile_page.dart';
import 'package:al_barakah_e_mart/custom/custom_card/cart_screen.dart';
import 'package:al_barakah_e_mart/custom/custom_drtawer/custom_drawer.dart';
import 'package:al_barakah_e_mart/main.dart';
import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
import 'package:al_barakah_e_mart/screens/auth/pages/dashboard_page.dart';
import 'package:al_barakah_e_mart/screens/home/home_screen.dart';
import 'package:al_barakah_e_mart/screens/main/component/bottom_navbar.dart';
import 'package:al_barakah_e_mart/screens/main/component/main_controller.dart';
import 'package:al_barakah_e_mart/screens/search/search_screen.dart';
import 'package:al_barakah_e_mart/utils/all_textstyle.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import '../auth/pages/signin_page.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? userName = "";
  String? customerId = "";
  String? authType = "";
  Future<void> _initializeData() async {
    userName = "${sharedPreferences.getString('name')}";
    customerId = "${sharedPreferences.getString('id')}";
    authType = "${sharedPreferences.getString('auth_type')}";

    print("auth_type=========$authType");
    print("User all Information   userName:$userName");

  }
  
  final _homeController = MainController();
  List<Widget> pageList = [
    const HomeScreen(),
    DashBoardPage(),
    const CartScreen(),
    const UpdateProfile(),
  ];

  @override
  void initState() {
    _initializeData();
    // TODO: implement initState
    super.initState();

  }

  final key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final customerId = "${sharedPreferences.getString('id')}";
    final addToCart = Provider.of<AddToCartProvider>(context, listen: true).cart;

    return StreamBuilder<int>(
      initialData: 0,
      stream: _homeController.naveListener.stream,
      builder: (context, snapshot) {
        int index = snapshot.data ?? 0;
        return Scaffold(
          extendBody: true,
          key: key,
          appBar: AppBar(
            backgroundColor: appBarColor,
            foregroundColor: Colors.black,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            leadingWidth: 40.w,
            titleSpacing: 0,
            title: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'images/ablogo.png',
                    height: 35.h,
                    width: 35.w,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: GestureDetector(
                onTap: () {
                  key.currentState!.openDrawer();
                },
                child: Icon(Icons.menu,color: Colors.white),
              ),
            ),
            actions: [
             Column(
              children: [
                Text("Al Barakah E-Mart",style:AllTextStyle.appbarTextStyle),
                customerId == "null" ||customerId == "" ||customerId.isEmpty ? GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const SignInPage()));
                  },
                    child: Text("Login Please",style:TextStyle(color: Colors.green.shade500,fontSize: 12.sp,fontWeight: FontWeight.w500)))
                    :Text("$userName",style: TextStyle(color: Colors.white,fontSize: 11.sp,overflow: TextOverflow.ellipsis)),
              ],
            ),
             SizedBox(width: 15.w),
             Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: GestureDetector(
                  child: const Icon(Icons.search,color: Colors.white),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
                  },
                ),
              ),
              Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: GestureDetector(
                        onTap: () {
                          MainController().naveListener.sink.add(2);
                        },
                        child: const Icon(Icons.shopping_cart,color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 3.h,
                    child: Container(
                      decoration: BoxDecoration(
                       color: Colors.red,
                       borderRadius: BorderRadius.circular(100.r)
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Text('${addToCart.length}',style: const TextStyle(
                            color: Colors.white
                          ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          drawer: const CustomDrawer(),
          body: WillPopScope(
            onWillPop: () {
              key.currentState!.closeDrawer();
              return
               _homeController.onBackPressed(context, index);
            },
            child: UpgradeAlert(
              upgrader: Upgrader(
                dialogStyle: Platform.isIOS
                    ? UpgradeDialogStyle.cupertino
                    : UpgradeDialogStyle.material,
              ),
              child: IndexedStack(
                index: index,
                children: pageList,
              ),
            ),
          ),
          bottomNavigationBar: MyBottomNavigationBar(
            mainController: _homeController,
            selectedIndex: index,
          ),
        );
      },
    );
  }
}
