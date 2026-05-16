import 'dart:convert';

class WishListModel {
  final String id;
  final String customerId;
  final String productId;
  final String addedAt;
  final String productCode;
  final String productName;
  final String mainImage;
  final String slug;

  WishListModel({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.addedAt,
    required this.productCode,
    required this.productName,
    required this.mainImage,
    required this.slug,
  });

  factory WishListModel.fromJson(String str) => WishListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WishListModel.fromMap(Map<String, dynamic> json) => WishListModel(
    id: json["id"]??"",
    customerId: json["customer_id"]??"",
    productId: json["product_id"]??"",
    addedAt: json["added_at"]??"",
    productCode: json["Product_Code"]??"",
    productName: json["Product_Name"]??"",
    mainImage: json["main_image"]??"",
    slug: json["slug"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customer_id": customerId,
    "product_id": productId,
    "added_at": addedAt,
    "Product_Code": productCode,
    "Product_Name": productName,
    "main_image": mainImage,
    "slug": slug,
  };
}
