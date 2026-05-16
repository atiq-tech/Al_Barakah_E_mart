import 'dart:convert';

class PurchaseCouponModel {
  final String productSlNo;
  final String productCode;
  final String productName;
  final String rechargeValue;
  final String salePrice;
  final String image;
  final String status;
  final String isActive;
  final String addBy;
  final String addTime;
  final String updateBy;
  final String updateTime;
  final String productBranchid;

  PurchaseCouponModel({
    required this.productSlNo,
    required this.productCode,
    required this.productName,
    required this.rechargeValue,
    required this.salePrice,
    required this.image,
    required this.status,
    required this.isActive,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.productBranchid,
  });

  factory PurchaseCouponModel.fromJson(String str) => PurchaseCouponModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PurchaseCouponModel.fromMap(Map<String, dynamic> json) => PurchaseCouponModel(
    productSlNo: json["Product_SlNo"]??"",
    productCode: json["Product_Code"]??"",
    productName: json["Product_Name"]??"",
    rechargeValue: json["recharge_value"]??"",
    salePrice: json["sale_price"]??"",
    image: json["image"]??"",
    status: json["status"]??"",
    isActive: json["is_active"]??"",
    addBy: json["AddBy"]??"",
    addTime: json["AddTime"]??"",
    updateBy: json["UpdateBy"]??"",
    updateTime: json["UpdateTime"]??"",
    productBranchid: json["Product_branchid"]??"",
  );

  Map<String, dynamic> toMap() => {
    "Product_SlNo": productSlNo,
    "Product_Code": productCode,
    "Product_Name": productName,
    "recharge_value": rechargeValue,
    "sale_price": salePrice,
    "image": image,
    "status": status,
    "is_active": isActive,
    "AddBy": addBy,
    "AddTime": addTime,
    "UpdateBy": updateBy,
    "UpdateTime": updateTime,
    "Product_branchid": productBranchid,
  };
}
