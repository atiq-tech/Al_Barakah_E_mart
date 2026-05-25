import 'package:al_barakah_e_mart/all_api_provider/delivery_times_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/department_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/district_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/factory_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/thana_provider.dart';
import 'package:al_barakah_e_mart/hive_with_cart/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:al_barakah_e_mart/all_api_provider/All_Top_Brand_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/all_orders_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/all_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/all_searching_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/area_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/brand_wise_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/categories_feature_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/child_categories_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/customer_orders_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/feature_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_brands_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_category_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_slide_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/get_wish_list_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/menu_category_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/parent_cate_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/parent_categories_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/popular_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/products_details_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/related_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/resent_product_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/searching_wise_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/special_products_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/top_brands_provider.dart';
import 'package:al_barakah_e_mart/all_api_provider/top_rated_products_provider.dart';
import 'package:al_barakah_e_mart/provider/add_to_cart_provider.dart';
import 'package:al_barakah_e_mart/provider/cart_remove_provider.dart';
import 'package:al_barakah_e_mart/provider/token_provider/token_provider.dart';
import 'package:al_barakah_e_mart/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(ProductDetailsAdapter());
  await Hive.openBox('pre_due');
  await Hive.openBox("cart");

  runApp(const AlBarakahEmartApp());
}

class AlBarakahEmartApp extends StatelessWidget {
  const AlBarakahEmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<TokenProvider>(create: (context) => TokenProvider()),
          ChangeNotifierProvider<AddToCartProvider>(create: (context) => AddToCartProvider()),
          ChangeNotifierProvider<RemoveCartProvider>(create: (context) => RemoveCartProvider()),
          ChangeNotifierProvider<ThanaProvider>(create: (context) => ThanaProvider()),
          ChangeNotifierProvider<DepartmentProvider>(create: (context) => DepartmentProvider()),
          ChangeNotifierProvider<FactoryProvider>(create: (context) => FactoryProvider()),
          ChangeNotifierProvider<DistrictProvider>(create: (context) => DistrictProvider()),         
          ChangeNotifierProvider<DeliveryTimesProvider>(create: (context) => DeliveryTimesProvider()),
          

          ChangeNotifierProvider<SliderProvider>(create: (context) => SliderProvider()),
          ChangeNotifierProvider<GetCategoriesProvider>(create: (context) => GetCategoriesProvider()),
          ChangeNotifierProvider<ParentCategoriesProvider>(create: (context) => ParentCategoriesProvider()),
          ChangeNotifierProvider<ChildCategoriesProvider>(create: (context) => ChildCategoriesProvider()),
          ChangeNotifierProvider<ParentCateProductProvider>(create: (context) => ParentCateProductProvider()),
          ChangeNotifierProvider<TopRatedProductsProvider>(create: (context) => TopRatedProductsProvider()),
          ChangeNotifierProvider<ResentProductProvider>(create: (context) => ResentProductProvider()),
          ChangeNotifierProvider<PopularProductsProvider>(create: (context) => PopularProductsProvider()),
          ChangeNotifierProvider<FeatureProductsProvider>(create: (context) => FeatureProductsProvider()),
          ChangeNotifierProvider<NewArrivalProductsProvider>(create: (context) => NewArrivalProductsProvider()),
          ChangeNotifierProvider<GetBrandsProvider>(create: (context) => GetBrandsProvider()),
          ChangeNotifierProvider<ProductsDetailsProvider>(create: (context) => ProductsDetailsProvider()),
          ChangeNotifierProvider<BrandWiseProductsProvider>(create: (context) => BrandWiseProductsProvider()),
          ChangeNotifierProvider<RelatedProductsProvider>(create: (context) => RelatedProductsProvider()),
          ChangeNotifierProvider<AreaProvider>(create: (context) => AreaProvider()),

          ChangeNotifierProvider<TopBrandsProvider>(create: (context) => TopBrandsProvider()),
          ChangeNotifierProvider<GetWishListProvider>(create: (context) => GetWishListProvider()),
          ChangeNotifierProvider<AllOrdersProvider>(create: (context) => AllOrdersProvider()),
          ChangeNotifierProvider<AllProductsProvider>(create: (context) => AllProductsProvider()),
          ChangeNotifierProvider<MenuCategoryProvider>(create: (context) => MenuCategoryProvider()),
          ChangeNotifierProvider<CategoriesFeatureProvider>(create: (context) => CategoriesFeatureProvider()),
          ChangeNotifierProvider<CustomerOrdersProvider>(create: (context) => CustomerOrdersProvider()),
          ChangeNotifierProvider<AllSearchingProductsProvider>(create: (context) => AllSearchingProductsProvider()),
          ChangeNotifierProvider<SearchingWiseProductsProvider>(create: (context) => SearchingWiseProductsProvider()),
          ChangeNotifierProvider<AllTopBrandProductProvider>(create: (context) => AllTopBrandProductProvider()),
      
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen()
        ),
      ),
    );
  }
}
