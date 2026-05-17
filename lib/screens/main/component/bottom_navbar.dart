import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_barakah_e_mart/screens/main/component/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key, required this.mainController, required this.selectedIndex}) : super(key: key);
  final MainController mainController;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 9,
      color: const Color(0x00ffffff),
      // shadowColor: Colors.black,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: appBarColor,
          selectedLabelStyle: TextStyle(fontSize: 12.sp, color: Colors.black),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp, color: Colors.white),
          elevation: 0,
          showSelectedLabels: true,
          unselectedItemColor: Colors.white,
          selectedItemColor: applineColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home, color: Colors.white),
              activeIcon: Icon(Icons.home,color: applineColor),
              label: "Home",
            ),

            BottomNavigationBarItem(
              activeIcon: Icon(Icons.dashboard,color: applineColor),
              icon: const Icon(Icons.dashboard, color: Colors.white),
              label: "Dashboard",
            ),

            BottomNavigationBarItem(
              activeIcon: Icon(Icons.shopping_cart,color: applineColor),
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              label: "Cart",
            ),

            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person_outline_outlined, color: applineColor),
              icon: Icon(Icons.person_outline_outlined, color: Colors.white),
              label: "Profile",
            ),
          ],
          // type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (int index) {
            print("$index");
            mainController.naveListener.sink.add(index);
          },
        ),
      ),
    );
  }
}
