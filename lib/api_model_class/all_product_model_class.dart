import 'dart:convert';

import 'package:al_barakah_e_mart/model/product/color_model.dart';
import 'package:al_barakah_e_mart/model/product/size_model.dart';

class ProductDataModel {
  final String productSlNo;
  final String productCode;
  final String productName;
  final String slug;
  final String productCategoryId;
  final String subCategoryId;
  final String subSubCategoryId;
  final String brand;
  final String purchaseRate;
  final String salePrice;
  final String mainPrice;
  final String cashbackPercent;
  final String cashbackAmount;
  final String productDescription;
  final String productShippingReturns;
  final String stock;
  final String unitId;
  final String mainImage;
  final String isExclusive;
  final String isHotDeals;
  final String isNewArrival;
  final String isTopSold;
  final dynamic rakingProduct;
  final String isActive;
  final String status;
  final String addBy;
  final String addTime;
  final String updateBy;
  final String updateTime;
  final String ipAddress;
  final String productBranchid;
  final String qty;
  final String metaTitle;
  final String metaDesc;
  final String productCategoryName;
  final String productSubCategoryName;
  final String productSubSubCategoryName;
  final String brandName;
  final String unitName;
  final List<ColorDataModel> colors;
  final List<SizeDataModel> sizeData;

  ProductDataModel({
    required this.productSlNo,
    required this.productCode,
    required this.productName,
    required this.slug,
    required this.productCategoryId,
    required this.subCategoryId,
    required this.subSubCategoryId,
    required this.brand,
    required this.purchaseRate,
    required this.salePrice,
    required this.mainPrice,
    required this.cashbackPercent,
    required this.cashbackAmount,
    required this.productDescription,
    required this.productShippingReturns,
    required this.stock,
    required this.unitId,
    required this.mainImage,
    required this.isExclusive,
    required this.isHotDeals,
    required this.isNewArrival,
    required this.isTopSold,
    required this.rakingProduct,
    required this.isActive,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.ipAddress,
    required this.productBranchid,
    required this.qty,
    required this.metaTitle,
    required this.metaDesc,
    required this.productCategoryName,
    required this.productSubCategoryName,
    required this.productSubSubCategoryName,
    required this.brandName,
    required this.unitName,
    required this.colors,
    required this.sizeData,
  });

  factory ProductDataModel.fromJson(String str) => ProductDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDataModel.fromMap(Map<String, dynamic> json) => ProductDataModel(
    productSlNo: json["Product_SlNo"]??"",
    productCode: json["Product_Code"]??"",
    productName: json["Product_Name"]??"",
    slug: json["slug"]??"",
    productCategoryId: json["ProductCategory_ID"]??"",
    subCategoryId: json["sub_category_id"]??"",
    subSubCategoryId: json["sub_sub_category_id"]??"",
    brand: json["brand"]??"",
    purchaseRate: json["purchase_rate"]??"",
    salePrice: json["sale_price"]??"",
    mainPrice: json["main_price"]??"",
    cashbackPercent: json["cashback_percent"]??"",
    cashbackAmount: json["cashback_amount"]??"",
    productDescription: json["Product_description"]??"",
    productShippingReturns: json["Product_shipping_returns"]??"",
    stock: json["stock"]??"",
    unitId: json["Unit_ID"]??"",
    mainImage: json["main_image"]??"",
    isExclusive: json["is_exclusive"]??"",
    isHotDeals: json["is_hot_deals"]??"",
    isNewArrival: json["is_new_arrival"]??"",
    isTopSold: json["is_top_sold"]??"",
    rakingProduct: json["raking_product"],
    isActive: json["is_active"]??"",
    status: json["status"]??"",
    addBy: json["AddBy"]??"",
    addTime: json["AddTime"]??"",
    updateBy: json["UpdateBy"]??"",
    updateTime: json["UpdateTime"]??"",
    ipAddress: json["ip_address"]??"",
    productBranchid: json["Product_branchid"]??"",
    qty: json["qty"]??"",
    metaTitle: json["meta_title"]??"",
    metaDesc: json["meta_desc"]??"",
    productCategoryName: json["ProductCategory_Name"]??"",
    productSubCategoryName: json["ProductSubCategory_Name"]??"",
    productSubSubCategoryName: json["ProductSubSubCategory_Name"]??"",
    brandName: json["brand_name"]??"",
    unitName: json["Unit_Name"]??"",
    colors: json["colors"] == [] || json["colors"] == null ? [] : List<ColorDataModel>.from(json["colors"].map((x) => ColorDataModel.fromMap(x))),
    sizeData: json["size_data"] == [] || json["size_data"] == null ? [] : List<SizeDataModel>.from(json["size_data"].map((x) => SizeDataModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Product_SlNo": productSlNo,
    "Product_Code": productCode,
    "Product_Name": productName,
    "slug": slug,
    "ProductCategory_ID": productCategoryId,
    "sub_category_id": subCategoryId,
    "sub_sub_category_id": subSubCategoryId,
    "brand": brand,
    "purchase_rate": purchaseRate,
    "sale_price": salePrice,
    "main_price": mainPrice,
    "cashback_percent": cashbackPercent,
    "cashback_amount": cashbackAmount,
    "Product_description": productDescription,
    "Product_shipping_returns": productShippingReturns,
    "stock": stock,
    "Unit_ID": unitId,
    "main_image": mainImage,
    "is_exclusive": isExclusive,
    "is_hot_deals": isHotDeals,
    "is_new_arrival": isNewArrival,
    "is_top_sold": isTopSold,
    "raking_product": rakingProduct,
    "is_active": isActive,
    "status": status,
    "AddBy": addBy,
    "AddTime": addTime,
    "UpdateBy": updateBy,
    "UpdateTime": updateTime,
    "ip_address": ipAddress,
    "Product_branchid": productBranchid,
    "qty": qty,
    "meta_title": metaTitle,
    "meta_desc": metaDesc,
    "ProductCategory_Name": productCategoryName,
    "ProductSubCategory_Name": productSubCategoryName,
    "ProductSubSubCategory_Name": productSubSubCategoryName,
    "brand_name": brandName,
    "Unit_Name": unitName,
    "colors": List<dynamic>.from(colors.map((x) => x.toMap())),
    "size_data": List<dynamic>.from(sizeData.map((x) => x.toMap())),
  };
}
