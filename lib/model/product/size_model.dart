import 'dart:convert';

class SizeDataModel {
  final String id;
  final String productId;
  final String colorId;
  final String sizeId;
  final String purchaseRate;
  final String mainPrice;
  final String reorderLevel;
  final String cashbackPercent;
  final String cashbackAmount;
  final String salePrice;
  final String sizeSiNo;
  final String sizeName;
  final String status;
  final String sizeBranchid;
  final String stock;

  SizeDataModel({
    required this.id,
    required this.productId,
    required this.colorId,
    required this.sizeId,
    required this.purchaseRate,
    required this.mainPrice,
    required this.reorderLevel,
    required this.cashbackPercent,
    required this.cashbackAmount,
    required this.salePrice,
    required this.sizeSiNo,
    required this.sizeName,
    required this.status,
    required this.sizeBranchid,
    required this.stock,
  });

  factory SizeDataModel.fromJson(String str) => SizeDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SizeDataModel.fromMap(Map<String, dynamic> json) => SizeDataModel(
    id: json["id"]??"",
    productId: json["product_id"]??"",
    colorId: json["color_id"]??"",
    sizeId: json["size_id"]??"",
    purchaseRate: json["purchase_rate"]??"",
    mainPrice: json["main_price"]??"",
    reorderLevel: json["reorder_level"]??"",
    cashbackPercent: json["cashback_percent"]??"",
    cashbackAmount: json["cashback_amount"]??"",
    salePrice: json["sale_price"]??"",
    sizeSiNo: json["size_SiNo"]??"",
    sizeName: json["size_name"]??"",
    status: json["status"]??"",
    sizeBranchid: json["size_branchid"]??"",
    stock: json["stock"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "color_id": colorId,
    "size_id": sizeId,
    "purchase_rate": purchaseRate,
    "main_price": mainPrice,
    "reorder_level": reorderLevel,
    "cashback_percent": cashbackPercent,
    "cashback_amount": cashbackAmount,
    "sale_price": salePrice,
    "size_SiNo": sizeSiNo,
    "size_name": sizeName,
    "status": status,
    "size_branchid": sizeBranchid,
    "stock": stock,
  };
}
