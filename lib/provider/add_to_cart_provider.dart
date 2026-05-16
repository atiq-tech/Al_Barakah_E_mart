import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';

class AddToCartProvider with ChangeNotifier {
  List<AddToCartModel> cart = [];
  double totalCartValue = 0;
  Box? cartBox;

  AddToCartProvider() {
    init(); // box open করে cart load করবে
  }

  Future<void> init() async {
    // Open the box if not already open
    if (!Hive.isBoxOpen('cart')) {
      cartBox = await Hive.openBox('cart');
    } else {
      cartBox = Hive.box('cart');
    }
    loadCart();
  }

  void loadCart() {
    if (cartBox != null && cartBox!.isNotEmpty) {
      cart = List<AddToCartModel>.from(
        cartBox!.get('cartList', defaultValue: []).map(
          (e) => AddToCartModel.fromJson(Map<String, dynamic>.from(e)),
        ),
      );
      calculateTotal();
      notifyListeners();
    }
  }

  void saveCart() {
    if (cartBox != null) {
      List<Map<String, dynamic>> cartMap = cart.map((e) => e.toJson()).toList();
      cartBox!.put('cartList', cartMap);
    }
  }

  void addProduct(AddToCartModel product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    if (index != -1) {
      updateProduct(product, cart[index].quantity! + 1);
    } else {
      cart.add(product);
      calculateTotal();
      saveCart();
      notifyListeners();
    }
  }

  void removeProduct(AddToCartModel product) {
    cart.removeWhere((item) => item.id == product.id);
    calculateTotal();
    saveCart();
    notifyListeners();
  }

  void updateProduct(AddToCartModel product, int quantity) {
    int index = cart.indexWhere((i) => i.id == product.id);
    if (index != -1) {
      cart[index].quantity = quantity;
      calculateTotal();
      saveCart();
      notifyListeners();
    }
  }

  void clearCart() {
    cart = [];
    calculateTotal();
    saveCart();
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    for (var f in cart) {
      totalCartValue += (f.discountPrice ?? 0) * (f.quantity ?? 1);
    }
  }
}























// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
// import 'dart:convert';

// class AddToCartProvider with ChangeNotifier {
//   List<AddToCartModel> cart = [];
//   double totalCartValue = 0;

//   int get total => cart.length;

//   AddToCartProvider() {
//     loadCart(); // app start e cart load hobe
//   }

//   void addProduct(AddToCartModel product) {
//     int index = cart.indexWhere((i) => i.id == product.id);
//     if (index != -1) {
//       updateProduct(product, cart[index].quantity! + 1);
//     } else {
//       cart.add(product);
//       calculateTotal();
//       saveCart();
//       notifyListeners();
//     }
//   }

//   void removeProduct(AddToCartModel product) {
//     cart.removeWhere((item) => item.id == product.id);
//     calculateTotal();
//     saveCart();
//     notifyListeners();
//   }

//   void updateProduct(AddToCartModel product, int quantity) {
//     int index = cart.indexWhere((i) => i.id == product.id);
//     if (index != -1) {
//       cart[index].quantity = quantity;
//       calculateTotal();
//       saveCart();
//       notifyListeners();
//     }
//   }

//   void clearCart() {
//     cart = [];
//     calculateTotal();
//     saveCart();
//     notifyListeners();
//   }

//   void calculateTotal() {
//     totalCartValue = 0;
//     for (var f in cart) {
//       totalCartValue += (f.discountPrice ?? 0) * (f.quantity ?? 1);
//     }
//   }

//   ///================ SharedPreferences =================
//   Future<void> saveCart() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> cartJson = cart.map((e) => jsonEncode(e.toJson())).toList();
//     await prefs.setStringList('cart', cartJson);
//   }

//   Future<void> loadCart() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? cartJson = prefs.getStringList('cart');
//     if (cartJson != null) {
//       cart = cartJson.map((e) => AddToCartModel.fromJson(jsonDecode(e))).toList();
//       calculateTotal();
//       notifyListeners();
//     }
//   }
// }










// import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
// import 'package:flutter/cupertino.dart';

// class AddToCartProvider with ChangeNotifier{

//   List<AddToCartModel> cart = [];
//   double totalCartValue = 0;
//   int get total => cart.length;

//   void addProduct(product) {
//     int index = cart.indexWhere((i) => i.id == product.id);
//     print("product id++++++++++++ $index");
//     if (index != -1) {
//       updateProduct(product, product.quantity + 1);
//     } else {
//       cart.add(product);
//       calculateTotal();
//       notifyListeners();
//     }
//   }

//   void removeProduct(product) {
//     int index = cart.indexWhere((i) => i.id == product.id);
//     cart[index].quantity = 1;
//     cart.removeWhere((item) => item.id == product.id);
//     calculateTotal();
//     notifyListeners();
//   }

//   void updateProduct(product, quantity) {
//     int index = cart.indexWhere((i) => i.id == product.id);
//     cart[index].quantity = quantity;
//     calculateTotal();
//     notifyListeners();
//   }


//   void clearCart() {
//     for (var f in cart) {
//       f.quantity = 1;
//     }
//     cart = [];
//     notifyListeners();
//   }

//   ///====new====
//   void calculateTotal() {
//     totalCartValue = 0;
//     for (var f in cart) {
//       totalCartValue += f.discountPrice! * f.quantity!;
//     }
//   }
// }














// import 'package:al_barakah_e_mart/model/add_to_cart_model.dart';
// import 'package:flutter/cupertino.dart';

// class AddToCartProvider with ChangeNotifier{

//   List<AddToCartModel> cart = [];
//   double totalCartValue = 0;
//   int get total => cart.length;

//   void addProduct(product) {
//     int index = cart.indexWhere((i) => i.id == product.id);
//     print("product id++++++++++++ $index");
//     if (index != -1) {
//       updateProduct(product, product.quantity + 1);
//     } else {
//       cart.add(product);
//       calculateTotal();
//       notifyListeners();
//     }
//   }

//   // void isAddedInCart(id){
//   //   int index = cart.indexWhere((i) => i.id == product.id);
//   //
//   // }

//   void removeProduct(product) {
//     int index = cart.indexWhere((i) => i.id == product.id);
//     cart[index].quantity = 1;
//     cart.removeWhere((item) => item.id == product.id);
//     calculateTotal();
//     notifyListeners();
//   }

//   void updateProduct(product, quantity) {
//     int index = cart.indexWhere((i) => i.id == product.id);
//     cart[index].quantity = quantity;
//     // if (cart[index].quantity == 0) removeProduct(product);
//     calculateTotal();
//     notifyListeners();
//   }


//   void clearCart() {
//     for (var f in cart) {
//       f.quantity = 1;
//     }
//     cart = [];
//     notifyListeners();
//   }

//   // void calculateTotal() {
//   //   totalCartValue = 0;
//   //   cart.forEach((f) {
//   //     totalCartValue += f.mainPrice! * f.quantity!;
//   //   });
//   // }
//   ///====new====
//   void calculateTotal() {
//     totalCartValue = 0;
//     for (var f in cart) {
//       totalCartValue += f.discountPrice! * f.quantity!;
//     }
//   }
// }






