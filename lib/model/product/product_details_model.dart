import 'dart:convert';

import 'package:al_barakah_e_mart/API_Model_Class/all_product_model_class.dart';

class ProductDetailsModel {
  final bool success;
  final ProductDataModel productDataModel;
  final List<ProductDataModel> reletedProduct;

  ProductDetailsModel({
    required this.success,
    required this.productDataModel,
    required this.reletedProduct,
  });

  factory ProductDetailsModel.fromJson(String str) => ProductDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailsModel.fromMap(Map<String, dynamic> json) => ProductDetailsModel(
    success: json["success"],
    productDataModel: ProductDataModel.fromMap(json["data"]),
    reletedProduct: json["releted_product_data"] == [] ? [] : List<ProductDataModel>.from(json["releted_product_data"].map((x) => ProductDataModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "success": success,
    "data": productDataModel.toMap(),
    "releted_product_data": List<dynamic>.from(reletedProduct.map((x) => x.toMap())),
  };
}