import 'dart:convert';
import 'package:al_barakah_e_mart/API_Model_Class/all_product_model_class.dart';
import 'package:al_barakah_e_mart/screens/brand_wise_product/model/brand_model.dart';
import 'package:al_barakah_e_mart/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiService{
  ////////////////////////////////////Brand Api Integration ////////////////////////
  static fetchBrands(context)async{
    try{
      String url="$baseUrl/get_web_brands";
      http.Response response=await http.get(Uri.parse(url));
      if(response.statusCode==200){
        var item=jsonDecode(response.body);
        return List.from(item).map((e) => BrandsModel.fromMap(e)).toList();
      }
    }catch(error){
      print("Your branding list Api Catch error $error");
    }
  }

  ///=======================brandsWise=================
  static Future<dynamic> getBrandsWise(context,
      String? brandId,
      ) async {
    //List<ProductDataModel> dataList = [];
    try {
      String link = "$baseUrl/get_web_products";
      var response = await Dio().post(link,
          data: {
            "brand_id": brandId,
          });

      print("brand_id===> $brandId");
      //   print(response.data);
      print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
      if (response.statusCode == 200) {
        final item = json.decode(response.data);
       // ProductDataModel datainstance;
        return List.from(item).map((e) => ProductDataModel.fromMap(e)).toList();
        // for (var i in item) {
        //   datainstance = ProductDataModel.fromMap(i);
        //   dataList.add(datainstance);
        //   // print("orders: $dataList");
        //   //   print(dataList[0].productName);
        //   //   print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
        // }
      }
      else {
        print('Data not found');
      }
    } catch (e) {
      print(e);
    }
   // return dataList;
  }
}