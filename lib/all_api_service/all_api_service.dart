
import 'package:al_barakah_e_mart/all_api_model/all_orders_model.dart';
import 'package:al_barakah_e_mart/all_api_model/all_products_model.dart';
import 'package:al_barakah_e_mart/all_api_model/area_model.dart';
import 'package:al_barakah_e_mart/all_api_model/child_categories_model.dart';
import 'package:al_barakah_e_mart/all_api_model/customer_orders_model.dart';
import 'package:al_barakah_e_mart/all_api_model/get_brands_model.dart';
import 'package:al_barakah_e_mart/all_api_model/get_category_model.dart';
import 'package:al_barakah_e_mart/all_api_model/get_slide_model.dart';
import 'package:al_barakah_e_mart/all_api_model/get_wish_list_model.dart';
import 'package:al_barakah_e_mart/all_api_model/products_details_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AllApiService{
  ///==================Get Category Api=======================
  static fetchGetCategories() async {
    try {
      String url = "${BaseUrl}get_categories";
      Response response = await Dio().get(url,
      //  data: {
      //       "menuItem": "1"
      //   }
       );
      var data = response.data;
      print("Get categories Data===> $data");
      return List.from(data["data"]).map((e) => GetCategoriesModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  // ONEK BORO FA.................................................

  //////=====fetchCategoriesFeature
   static fetchCategoriesFeature() async {
    try {
      String url = "${BaseUrl}get_category";
      Response response = await Dio().post(url,
        data: {
            "isFeature":"1"
        });
      var data = response.data;
      print("Get Feature categories Data===> $data");
      return List.from(data).map((e) => GetCategoriesModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================Get ParentCategories Api=======================
  static fetchParentCategories(String? categoryId) async {
    try {
      String url = "${BaseUrl}get_category";
      Response response = await Dio().post(url,
          data: {
            "categoryId": categoryId
          });
      var data = response.data;
      print("Get categories Data===> $data");
      print("categoryId===>$categoryId");
      return List.from(data).map((e) => GetCategoriesModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================get_sliders Api=======================
  static fetchGetSliders() async {
    try {
      String url = "${BaseUrl}get_sliders";
      Response response = await Dio().get(url);
      var data = response.data;
      print("Get Sliders Data===> $data");
      return List.from(data).map((e) => GetSlidersModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  ///==================get GetWishList Api=======================
  static fetchGetWishList() async {
    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      String url = "${BaseUrl}api/get_wish_list";
      Response response = await Dio().post(url,
          data:{
            "customerId": "${sharedPreferences.getString("id")}"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPreferences.getString("token")}",
          }));
      var data = response.data;
      print("get_wish_list Data===> $data");
      return List.from(data["wishLists"]).map((e) => GetWishListModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  ///==================get_Orders Api=======================
  static fetchGetOrders() async {
    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      String url = "${BaseUrl}api/get_orders";
      Response response = await Dio().post(url,
          data:{
            "customerId": "${sharedPreferences.getString("id")}"
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPreferences.getString("token")}",
          }));
      var data = response.data;
      print("get_orders Data===> $data");
      print("user id ${sharedPreferences.getString("id")}");
      print("Token is  >>>><<<<< ${sharedPreferences.getString("token")}");
      return List.from(data["orders"]).map((e) => AllOrderModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

    ///==================get_customer_orders Api=======================
  static fetchCustomerOrders(String? orderStatus) async {
    SharedPreferences? sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    try {
      String url = "${BaseUrl}get_customer_orders";
      Response response = await Dio().post(url,
          data:{
            "customerId": "${sharedPreferences.getString("id")}",
            "orderStatus": orderStatus
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${sharedPreferences.getString("token")}",
          }));
      var data = response.data;
      print("get_orders Data===> $data");
      print("user id ${sharedPreferences.getString("id")}");
      print("Token is  >>>><<<<< ${sharedPreferences.getString("token")}");
      return List.from(data).map((e) => CustomerOrdersModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================Get ALl Searching Api=======================
  static fetchAllSearchingProducts() async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().get(url);
          // data: {
          //   "filter": "top"
          // });
      var data = response.data;
      print("AllSearchingProducts Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  ///==================Get ALl Searching Wise Api=======================
  static fetchSearchingWiseProducts(String? srcValue) async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().post(url,
          data: {
            "input_value": "$srcValue"
          });
      var data = response.data;
      print("AllSearchingProducts Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================Get TopRated Api=======================
  static fetchTopRated() async {
    try {
      String url = "${BaseUrl}api/get_products";
      Response response = await Dio().post(url,
         data: {
           "filter": "top"
     });
      var data = response.data;
      print("Get TopRated Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================Get ResentProduct Api=======================
  static fetchResentProduct() async {
    try {
      String url = "${BaseUrl}api/get_products";
      Response response = await Dio().post(url,
          data: {
            "filter": "recent"
          });
      var data = response.data;
      print("Get ResentProduct Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================Get PopularProducts Api=======================
  static fetchPopularProducts() async {
    try {
      String url = "${BaseUrl}api/get_products";
      Response response = await Dio().post(url,
          data: {
            "filter": "popular"
          });
      var data = response.data;
      print("Get PopularProducts Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }


  ///==================Get FeatureProducts Api=======================
  static fetchFeatureProducts() async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().post(url,
        data: {
          "filter":"feature",
        });
      var data = response.data;
      print("Get products Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
//==========BestSellers===========
   static fetchBestDealerFProducts() async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().post(url,
        data: {
          "isBestDeal":"1"
        });
      var data = response.data;
      print("Get BestDealer Products Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  //==========BestSellers===========
   static fetchBestSellersFProducts() async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().post(url,
        data: {
          "isBestSeller":"1"
        });
      var data = response.data;
      print("Get BestSellers Products Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  //==========isOfferGadget===========
   static fetchGadgetOfferProducts() async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().post(url,
        data: {
          "isOfferGadget":"true"
        });
      var data = response.data;
      print("Get GadgetOffer Products Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
 
  //==========isOfferDevice===========
   static fetchDeviceOfferProducts() async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().post(url,
        data: {
          "isOfferDevice":"true"
        });
      var data = response.data;
      print("Get DeviceOffer Products Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================Get SpecialProducts Api=======================
  static fetchSpecialProducts() async {
    try {
      String url = "${BaseUrl}api/get_products";
      Response response = await Dio().post(url,
          data: {
            "filter": "special"
          });
      var data = response.data;
      print("Get SpecialProducts Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================get_brands Api=======================
  static fetchGetBrands() async {
    try {
      String url = "${BaseUrl}get_brands";
      Response response = await Dio().get(url);
      var data = response.data;
      print("Get brands Data===> $data");
      return List.from(data).map((e) => GetBrandsModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
 ///==================get_Top brands Api=======================
   static fetchTopBrands() async {
    try {
      String url = "${BaseUrl}get_brands";
      Response response = await Dio().post(url,
        data: {
          "isTopBrand":"true"
        });
      var data = response.data;
      print("Get Top brands Data===> $data");
      return List.from(data).map((e) => GetBrandsModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================Get SpecialProducts Api=======================
  static fetchBrandWiseProducts(String? brandId) async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().post(url,
          data: {
            "brandId": "$brandId"
          });
      var data = response.data;
      print("Get BrandWiseProducts Data===> $data");
      print("brandId===> $brandId");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  
  ///==================Get  AllTopBrandProducts Api=======================
  static fetchAllTopBrandProducts() async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().post(url,
          data: {
            "isBrand": "true"
          });
      var data = response.data;
      print("Get AllTopBrandProducts Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================Get ParentCateProducts Api=======================
  static fetchParentCateProducts(String? categoryId) async {
    try {
      String url = "${BaseUrl}get_products";
      Response response = await Dio().post(url,
          data: {
            "categoryId": categoryId
          });
      var data = response.data;
      print("ParentCateProducts Data===> $data");
      print("categoryId===>$categoryId");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  ///==================Get ProductsDetails Api=======================
  // static fetchProductsDetails(String slug) async {
  //   String link = "${BaseUrl}api/get_products";
  //   try {
  //     final formData = FormData.fromMap({
  //       "slug": slug.trim(),
  //     });
  //     final response = await Dio().post(link, data: formData);
  //     var item = response.data;
  //     return ProductsDetailsModel.fromMap(item['products']);
  //   } catch (e) {
  //     print("hhhhhhhhhhhhhh Error message $e");
  //     return null;
  //   }
  // }
static Future<ProductDetailsModel?> fetchProductsDetails(String slug) async {
  String link = "${BaseUrl}get_products";

  try {
    final formData = FormData.fromMap({
      "slug": slug.trim(),
    });

    final response = await Dio().post(link, data: formData);

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data;
      print("produt details=====$data");

      final List productsList = data["products"] ?? [];
      final List relatedList = data["related_products"] ?? [];

      if (productsList.isEmpty) return null;

      /// ✅ reshape to model structure
      final Map<String, dynamic> modelMap = {
        "product": productsList.first,      // main product
        "related_products": relatedList     // related from API
      };

      return ProductDetailsModel.fromMap(modelMap);
    }

    return null;
  } catch (e) {
    print("ProductDetails API Error: $e");
    return null;
  }
}
  ///==================Get child categories Api=======================
  // static fetchChildCategories(String? categoryId) async {
  //   String link = "${BaseUrl}get_category";
  //   print("Child Categories categoryId===== $categoryId");
  //   try {
  //     final formData = FormData.fromMap({
  //       "categoryId": "$categoryId"
  //     });
  //     final response = await Dio().post(link, data: formData);
  //     var item = response.data;
  //     print("Child Categories data===== $item");
  //     print("Child Categories categoryId===>$categoryId");
  //     return ChildCategoriesModel.fromMap(item);
  //   } catch (e) {
  //     print("Child Categories Error message $e");
  //     return null;
  //   }
  // }

  static Future<ChildCategoriesModel?> fetchChildCategories(String? categoryId) async {
  String link = "${BaseUrl}get_category";

  try {
    final formData = FormData.fromMap({
      "categoryId": "$categoryId"
    });

    final response = await Dio().post(link, data: formData);
    final item = response.data;

    print("Child Categories data===== $item");

    /// ✅ API returns LIST
    if (item is List && item.isNotEmpty) {
      return ChildCategoriesModel.fromMap(item.first);
    }

    /// ✅ API returns OBJECT
    if (item is Map<String, dynamic>) {
      return ChildCategoriesModel.fromMap(item);
    }

    return null;

  } catch (e) {
    print("Child Categories Error message $e");
    return null;
  }
}

  ///==================Get RelatedProducts Api=======================
  static fetchRelatedProducts(String? categoryId) async {
    try {
      String url = "${BaseUrl}api/get_products";
      Response response = await Dio().post(url,
          data: {
            "categoryId": categoryId
          });
      var data = response.data;
      print("RelatedProducts Data===> $data");
      print("RelatedProducts categoryId===>$categoryId");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print("product details======$e");
    }
    return null;
  }

  ///==================Get area Api=======================
  static fetchGetArea() async {
    try {
      String url = "${BaseUrl}api/get_area";
      Response response = await Dio().get(url);
      var data = response.data;
      print("GetArea Data===> $data");
      return List.from(data["areas"]).map((e) => AreaModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }

  ///==================Menu Category Api=======================
  static fetchMenuCategory(String? slug) async {
    try {
      String url = "${BaseUrl}menu_category";
      Response response = await Dio().post(url,
          data: {
            "slug": "$slug"
          });
      var data = response.data;
      print("menu_category Data===> $data");
      return List.from(data["products"]).map((e) => AllProductModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
}