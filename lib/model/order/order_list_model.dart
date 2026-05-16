
import 'dart:convert';

class OrderListModel {
  final String saleDetailsSlNo;
  final String saleMasterIdNo;
  final String productIdNo;
  final String colorId;
  final String sizeId;
  final String saleDetailsTotalQuantity;
  final String purchaseRate;
  final String saleDetailsRate;
  final String cashbackPercent;
  final String saleDetailsCashback;
  final String saleDetailsTotalCashback;
  final String saleDetailsTotalAmount;
  final String status;
  final dynamic addBy;
  final String addTime;
  final dynamic updateBy;
  final dynamic updateTime;
  final String saleDetailsBranchId;
  final String productName;
  final String productCategoryName;
  final String sizeName;
  final String colorName;
  final String colorCode;
  final String image1;

  OrderListModel({
    required this.saleDetailsSlNo,
    required this.saleMasterIdNo,
    required this.productIdNo,
    required this.colorId,
    required this.sizeId,
    required this.saleDetailsTotalQuantity,
    required this.purchaseRate,
    required this.saleDetailsRate,
    required this.cashbackPercent,
    required this.saleDetailsCashback,
    required this.saleDetailsTotalCashback,
    required this.saleDetailsTotalAmount,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.saleDetailsBranchId,
    required this.productName,
    required this.productCategoryName,
    required this.sizeName,
    required this.colorName,
    required this.colorCode,
    required this.image1,
  });

  factory OrderListModel.fromJson(String str) => OrderListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderListModel.fromMap(Map<String, dynamic> json) => OrderListModel(
    saleDetailsSlNo: json["SaleDetails_SlNo"]??"",
    saleMasterIdNo: json["SaleMaster_IDNo"]??"",
    productIdNo: json["Product_IDNo"]??"",
    colorId: json["color_id"]??"",
    sizeId: json["size_id"]??"",
    saleDetailsTotalQuantity: json["SaleDetails_TotalQuantity"]??"",
    purchaseRate: json["Purchase_Rate"]??"",
    saleDetailsRate: json["SaleDetails_Rate"]??"",
    cashbackPercent: json["cashback_percent"]??"",
    saleDetailsCashback: json["SaleDetails_Cashback"]??"",
    saleDetailsTotalCashback: json["SaleDetails_TotalCashback"]??"",
    saleDetailsTotalAmount: json["SaleDetails_TotalAmount"]??"",
    status: json["Status"]??"",
    addBy: json["AddBy"],
    addTime: json["AddTime"]??"",
    updateBy: json["UpdateBy"],
    updateTime: json["UpdateTime"],
    saleDetailsBranchId: json["SaleDetails_BranchId"]??"",
    productName: json["Product_Name"]??"",
    productCategoryName: json["ProductCategory_Name"]??"",
    sizeName: json["size_name"]??"",
    colorName: json["color_name"]??"",
    colorCode: json["color_code"]??"",
    image1: json["image_1"]??"",
  );

  Map<String, dynamic> toMap() => {
    "SaleDetails_SlNo": saleDetailsSlNo,
    "SaleMaster_IDNo": saleMasterIdNo,
    "Product_IDNo": productIdNo,
    "color_id": colorId,
    "size_id": sizeId,
    "SaleDetails_TotalQuantity": saleDetailsTotalQuantity,
    "Purchase_Rate": purchaseRate,
    "SaleDetails_Rate": saleDetailsRate,
    "cashback_percent": cashbackPercent,
    "SaleDetails_Cashback": saleDetailsCashback,
    "SaleDetails_TotalCashback": saleDetailsTotalCashback,
    "SaleDetails_TotalAmount": saleDetailsTotalAmount,
    "Status": status,
    "AddBy": addBy,
    "AddTime": addTime,
    "UpdateBy": updateBy,
    "UpdateTime": updateTime,
    "SaleDetails_BranchId": saleDetailsBranchId,
    "Product_Name": productName,
    "ProductCategory_Name": productCategoryName,
    "size_name": sizeName,
    "color_name": colorName,
    "color_code": colorCode,
    "image_1": image1,
  };
}
