import 'dart:convert';

import 'package:al_barakah_e_mart/model/product/size_model.dart';

class ColorDataModel {
  final String colorSiNo;
  final String colorName;
  final String colorCode;
  final String status;
  final String colorBranchid;
  final String id;
  final String productId;
  final String colorId;
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final List<SizeDataModel> sizeData;
  ColorDataModel({
    required this.colorSiNo,
    required this.colorName,
    required this.colorCode,
    required this.status,
    required this.colorBranchid,
    required this.id,
    required this.productId,
    required this.colorId,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.sizeData,
  });

  factory ColorDataModel.fromJson(String str) => ColorDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ColorDataModel.fromMap(Map<String, dynamic> json) => ColorDataModel(
    colorSiNo: json["color_SiNo"]??"",
    colorName: json["color_name"]??"",
    colorCode: json["color_code"]??"",
    status: json["status"]??"",
    colorBranchid: json["color_branchid"]??"",
    id: json["id"]??"",
    productId: json["product_id"]??"",
    colorId: json["color_id"]??"",
    image1: json["image_1"]??"",
    image2: json["image_2"]??"",
    image3: json["image_3"]??"",
    image4: json["image_4"]??"",
    sizeData: json["size_d"] == [] || json["size_d"] == null ? [] : List<SizeDataModel>.from(json["size_d"].map((x) => SizeDataModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "color_SiNo": colorSiNo,
    "color_name": colorName,
    "color_code": colorCode,
    "status": status,
    "color_branchid": colorBranchid,
    "id": id,
    "product_id": productId,
    "color_id": colorId,
    "image_1": image1,
    "image_2": image2,
    "image_3": image3,
    "image_4": image4,
    "size_d": List<dynamic>.from(sizeData.map((x) => x.toMap())),
  };
}
