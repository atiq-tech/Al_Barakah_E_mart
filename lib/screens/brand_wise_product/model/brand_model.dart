import 'dart:convert';

class BrandsModel {
  final String brandSiNo;
  final String brandName;
  final String image;
  final String status;
  final String brandBranchid;
  final dynamic metaTitle;
  final dynamic metaDesc;

  BrandsModel({
    required this.brandSiNo,
    required this.brandName,
    required this.image,
    required this.status,
    required this.brandBranchid,
    required this.metaTitle,
    required this.metaDesc,
  });

  factory BrandsModel.fromJson(String str) => BrandsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BrandsModel.fromMap(Map<String, dynamic> json) => BrandsModel(
    brandSiNo: json["brand_SiNo"]??"",
    brandName: json["brand_name"]??"",
    image: json["image"]??"",
    status: json["status"]??"",
    brandBranchid: json["brand_branchid"]??"",
    metaTitle: json["meta_title"],
    metaDesc: json["meta_desc"],
  );

  Map<String, dynamic> toMap() => {
    "brand_SiNo": brandSiNo,
    "brand_name": brandName,
    "image": image,
    "status": status,
    "brand_branchid": brandBranchid,
    "meta_title": metaTitle,
    "meta_desc": metaDesc,
  };
}
