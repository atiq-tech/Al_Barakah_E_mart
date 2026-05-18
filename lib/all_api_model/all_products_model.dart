import 'dart:convert';

class AllProductModel {
    final dynamic productSlNo;
    final dynamic productCode;
    final dynamic productCategoryId;
    final dynamic subCategoryId;
    final dynamic productName;
    final dynamic slug;
    final dynamic productWholesaleRate;
    final dynamic productSellingPrice;
    final dynamic discount;
    final dynamic productImage;
    final dynamic thumImage;
    final dynamic shortDescription;
    final dynamic productDescription;
    final dynamic isOffer;
    final dynamic discountPrice;
    final dynamic stock;

    AllProductModel({
        required this.productSlNo,
        required this.productCode,
        required this.productCategoryId,
        required this.subCategoryId,
        required this.productName,
        required this.slug,
        required this.productWholesaleRate,
        required this.productSellingPrice,
        required this.discount,
        required this.productImage,
        required this.thumImage,
        required this.shortDescription,
        required this.productDescription,
        required this.isOffer,
        required this.discountPrice,
        required this.stock,
    });

    factory AllProductModel.fromJson(String str) => AllProductModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AllProductModel.fromMap(Map<String, dynamic> json) => AllProductModel(
        productSlNo: json["Product_SlNo"],
        productCode: json["Product_Code"],
        productCategoryId: json["ProductCategory_ID"],
        subCategoryId: json["sub_category_id"],
        productName: json["Product_Name"],
        slug: json["slug"],
        productWholesaleRate: json["Product_WholesaleRate"],
        productSellingPrice: json["Product_SellingPrice"],
        discount: json["discount"],
        productImage: json["Product_Image"],
        thumImage: json["thum_image"],
        shortDescription: json["short_description"],
        productDescription: json["Product_description"],
        isOffer: json["is_offer"],
        discountPrice: json["discount_price"],
        stock: json["stock"],
    );

    Map<String, dynamic> toMap() => {
        "Product_SlNo": productSlNo,
        "Product_Code": productCode,
        "ProductCategory_ID": productCategoryId,
        "sub_category_id": subCategoryId,
        "Product_Name": productName,
        "slug": slug,
        "Product_WholesaleRate": productWholesaleRate,
        "Product_SellingPrice": productSellingPrice,
        "discount": discount,
        "Product_Image": productImage,
        "thum_image": thumImage,
        "short_description": shortDescription,
        "Product_description": productDescription,
        "is_offer": isOffer,
        "discount_price": discountPrice,
        "stock": stock,
    };
}














// class AllProductModel {
//   final dynamic productSlNo;
//   final dynamic productCode;
//   final dynamic productName;
//   final dynamic productCategoryId;
//   final dynamic reference;
//   final dynamic barcode;
//   final dynamic color;
//   final dynamic brand;
//   final dynamic modelId;
//   final dynamic size;
//   final dynamic vat;
//   final dynamic productReOrederLevel;
//   final dynamic productPurchaseRate;
//   final dynamic productSellingPrice;
//   final dynamic productMinimumSellingPrice;
//   final dynamic productWholesaleRate;
//   final dynamic productCorporateRate;
//   final dynamic productOnlineRate;
//   final dynamic onlineDiscount;
//   final dynamic onlineDiscountPrice;
//   final dynamic onlineAfterDiscountAmount;
//   final dynamic startDate;
//   final dynamic oneCartunEqual;
//   final dynamic isService;
//   final dynamic isSerial;
//   final dynamic unitId;
//   final dynamic warranty;
//   final dynamic status;
//   final dynamic addBy;
//   final dynamic addTime;
//   final dynamic updateBy;
//   final dynamic updateTime;
//   final dynamic lastUpdateIp;
//   final dynamic productBranchid;
//   final dynamic model;
//   final dynamic slug;
//   final dynamic shortDescription;
//   final dynamic longDescription;
//   final dynamic specification;
//   final dynamic video;
//   final dynamic warrantyLongText;
//   final dynamic emiAvilable;
//   final dynamic isExchange;
//   final dynamic isFeature;
//   final dynamic isBestDeal;
//   final dynamic isBestSallers;
//   final dynamic newArrival;
//   final dynamic isOffer;
//   final dynamic type;
//   final dynamic mainImage;
//   final dynamic alterImage;
//   final dynamic mainImageAlt;
//   final dynamic alterImageAlt;
//   final dynamic weight;
//   final dynamic dimensions;
//   final dynamic note;
//   final dynamic compatibility;
//   final dynamic connectivity;
//   final dynamic noiseCancellation;
//   final dynamic microphone;
//   final dynamic waterResistance;
//   final dynamic powerOutput;
//   final dynamic frequencyResponse;
//   final dynamic material;
//   final dynamic batteryCapacity;
//   final dynamic camera;
//   final dynamic network;
//   final dynamic processor;
//   final dynamic ram;
//   final dynamic storage;
//   final dynamic display;
//   final dynamic batteryLife;
//   final dynamic operatingSystem;
//   final dynamic ports;
//   final dynamic cableType;
//   final dynamic length;
//   final dynamic isDraft;
//   final dynamic seoTitle;
//   final dynamic seoKeywords;
//   final dynamic seoDescription;
//   final dynamic storageId;
//   final dynamic regionId;
//   final dynamic simId;
//   final dynamic strapId;
//   final dynamic networkId;
//   final dynamic plugId;
//   final dynamic sizeId;
//   final dynamic specificationTypeId;
//   final dynamic endDate;
//   final dynamic preOrder;
//   final dynamic isTba;
//   final dynamic isCallForAvailablity;
//   final dynamic isOnlineOrder;
//   final dynamic showOnWebsite;
//   final dynamic deletedBy;
//   final dynamic deletedAt;
//   final dynamic createdAt;

//   final Inventory? inventory;
//   final List<MultipleImg> multipleImg;
//   final Relationcolor? relationcolor;
//   final Relationbrand? relationbrand;
//   final Category? category;

//   AllProductModel({
//     this.productSlNo,
//     this.productCode,
//     this.productName,
//     this.productCategoryId,
//     this.reference,
//     this.barcode,
//     this.color,
//     this.brand,
//     this.modelId,
//     this.size,
//     this.vat,
//     this.productReOrederLevel,
//     this.productPurchaseRate,
//     this.productSellingPrice,
//     this.productMinimumSellingPrice,
//     this.productWholesaleRate,
//     this.productCorporateRate,
//     this.productOnlineRate,
//     this.onlineDiscount,
//     this.onlineDiscountPrice,
//     this.onlineAfterDiscountAmount,
//     this.startDate,
//     this.oneCartunEqual,
//     this.isService,
//     this.isSerial,
//     this.unitId,
//     this.warranty,
//     this.status,
//     this.addBy,
//     this.addTime,
//     this.updateBy,
//     this.updateTime,
//     this.lastUpdateIp,
//     this.productBranchid,
//     this.model,
//     this.slug,
//     this.shortDescription,
//     this.longDescription,
//     this.specification,
//     this.video,
//     this.warrantyLongText,
//     this.emiAvilable,
//     this.isExchange,
//     this.isFeature,
//     this.isBestDeal,
//     this.isBestSallers,
//     this.newArrival,
//     this.isOffer,
//     this.type,
//     this.mainImage,
//     this.alterImage,
//     this.mainImageAlt,
//     this.alterImageAlt,
//     this.weight,
//     this.dimensions,
//     this.note,
//     this.compatibility,
//     this.connectivity,
//     this.noiseCancellation,
//     this.microphone,
//     this.waterResistance,
//     this.powerOutput,
//     this.frequencyResponse,
//     this.material,
//     this.batteryCapacity,
//     this.camera,
//     this.network,
//     this.processor,
//     this.ram,
//     this.storage,
//     this.display,
//     this.batteryLife,
//     this.operatingSystem,
//     this.ports,
//     this.cableType,
//     this.length,
//     this.isDraft,
//     this.seoTitle,
//     this.seoKeywords,
//     this.seoDescription,
//     this.storageId,
//     this.regionId,
//     this.simId,
//     this.strapId,
//     this.networkId,
//     this.plugId,
//     this.sizeId,
//     this.specificationTypeId,
//     this.endDate,
//     this.preOrder,
//     this.isTba,
//     this.isCallForAvailablity,
//     this.isOnlineOrder,
//     this.showOnWebsite,
//     this.deletedBy,
//     this.deletedAt,
//     this.createdAt,
//     this.inventory,
//     required this.multipleImg,
//     this.relationcolor,
//     required this.relationbrand,
//     this.category,
//   });

// /// ✅ CURRENT STOCK (never negative)
// int getCurrentStock() {
//   if (inventory == null) return 0;

//   final inv = inventory!;

//   final purchase = (inv.purchaseQuantity ?? 0);
//   final salesReturn = (inv.salesReturnQuantity ?? 0);
//   final transferTo = (inv.transferToQuantity ?? 0);

//   final sales = (inv.salesQuantity ?? 0);
//   final purchaseReturn = (inv.purchaseReturnQuantity ?? 0);
//   final damage = (inv.damageQuantity ?? 0);
//   final transferFrom = (inv.transferFromQuantity ?? 0);

//   final stock =
//       (purchase + salesReturn + transferTo) -
//       (sales + purchaseReturn + damage + transferFrom);

//   /// negative stock → 0
//   return stock < 0 ? 0 : stock;
// }

// /// ✅ STOCK STATUS TEXT
// String get stockStatus {
//   final stock = getCurrentStock();
//   return stock == 0 ? "Out of Stock" : "In Stock";
// }

//   /// ✅ STATIC VERSION (optional)
//   static int calculateStock(Inventory? inventory) {
//     if (inventory == null) return 0;

//     final purchase = (inventory.purchaseQuantity ?? 0);
//     final salesReturn = (inventory.salesReturnQuantity ?? 0);
//     final transferTo = (inventory.transferToQuantity ?? 0);

//     final sales = (inventory.salesQuantity ?? 0);
//     final purchaseReturn = (inventory.purchaseReturnQuantity ?? 0);
//     final damage = (inventory.damageQuantity ?? 0);
//     final transferFrom = (inventory.transferFromQuantity ?? 0);

//     return (purchase + salesReturn + transferTo) - (sales + purchaseReturn + damage + transferFrom);
//   }

//   factory AllProductModel.fromMap(Map<String, dynamic> json) {
//     return AllProductModel(
//       productSlNo: json["Product_SlNo"],
//       productCode: json["Product_Code"]?.toString(),
//       productName: json["Product_Name"]?.toString(),
//       productCategoryId: json["ProductCategory_ID"],
//       reference: json["reference"],
//       barcode: json["barcode"],
//       color: json["color"],
//       brand: json["brand"],
//       modelId: json["model_id"],
//       size: json["size"],
//       vat: json["vat"],
//       productReOrederLevel: json["Product_ReOrederLevel"],
//       productPurchaseRate: json["Product_Purchase_Rate"],
//       productSellingPrice: json["Product_SellingPrice"],
//       productMinimumSellingPrice: json["Product_MinimumSellingPrice"],
//       productWholesaleRate: json["Product_WholesaleRate"],
//       productCorporateRate: json["Product_CorporateRate"],
//       productOnlineRate: json["Product_OnlineRate"],
//       onlineDiscount: json["online_discount"],
//       onlineDiscountPrice: json["online_discount_price"],
//       onlineAfterDiscountAmount: json["online_after_discount_amount"],
//       startDate: json["start_date"],
//       oneCartunEqual: json["one_cartun_equal"],
//       isService: json["is_service"],
//       isSerial: json["is_serial"],
//       unitId: json["Unit_ID"],
//       warranty: json["warranty"],
//       status: json["status"],
//       addBy: json["AddBy"],
//       addTime: json["AddTime"],
//       updateBy: json["UpdateBy"],
//       updateTime: json["UpdateTime"],
//       lastUpdateIp: json["last_update_ip"],
//       productBranchid: json["Product_branchid"],
//       model: json["model"],
//       slug: json["slug"],
//       shortDescription: json["short_description"],
//       longDescription: json["long_description"],
//       specification: json["specification"],
//       video: json["video"],
//       warrantyLongText: json["warranty_long_text"],
//       emiAvilable: json["emi_avilable"],
//       isExchange: json["is_exchange"],
//       isFeature: json["is_feature"],
//       isBestDeal: json["is_best_deal"],
//       isBestSallers: json["is_best_sallers"],
//       newArrival: json["new_arrival"],
//       isOffer: json["is_offer"],
//       type: json["type"],
//       mainImage: json["main_image"],
//       alterImage: json["alter_image"],
//       mainImageAlt: json["main_image_alt"],
//       alterImageAlt: json["alter_image_alt"],
//       weight: json["weight"],
//       dimensions: json["dimensions"],
//       note: json["note"],
//       compatibility: json["compatibility"],
//       connectivity: json["connectivity"],
//       noiseCancellation: json["noise_cancellation"],
//       microphone: json["microphone"],
//       waterResistance: json["water_resistance"],
//       powerOutput: json["power_output"],
//       frequencyResponse: json["frequency_response"],
//       material: json["material"],
//       batteryCapacity: json["battery_capacity"],
//       camera: json["camera"],
//       network: json["network"],
//       processor: json["processor"],
//       ram: json["ram"],
//       storage: json["storage"],
//       display: json["display"],
//       batteryLife: json["battery_life"],
//       operatingSystem: json["operating_system"],
//       ports: json["ports"],
//       cableType: json["cable_type"],
//       length: json["length"],
//       isDraft: json["is_draft"],
//       seoTitle: json["seoTitle"],
//       seoKeywords: json["seoKeywords"],
//       seoDescription: json["seoDescription"],
//       storageId: json["storage_id"],
//       regionId: json["region_id"],
//       simId: json["sim_id"],
//       strapId: json["strap_id"],
//       networkId: json["network_id"],
//       plugId: json["plug_id"],
//       sizeId: json["size_id"],
//       specificationTypeId: json["specification_type_id"],
//       endDate: json["end_date"],
//       preOrder: json["pre_order"],
//       isTba: json["is_tba"],
//       isCallForAvailablity: json["is_call_for_availablity"],
//       isOnlineOrder: json["is_online_order"],
//       showOnWebsite: json["show_on_website"],
//       deletedBy: json["deleted_by"],
//       deletedAt: json["deleted_at"],
//       createdAt: json["created_at"],
//       inventory:json["inventory"] == null ? null : Inventory.fromMap(json["inventory"]),
//       multipleImg: json["multiple_img"] == null ? [] : List<MultipleImg>.from((json["multiple_img"] as List).map((x) => MultipleImg.fromMap(x))),
//       relationcolor: json["relationcolor"] == null ? null : Relationcolor.fromMap(json["relationcolor"]),
//       relationbrand: json["relationbrand"] == null ? null : Relationbrand.fromMap(json["relationbrand"]),
//       category: json["category"] == null ? null : Category.fromMap(json["category"]),
//     );
//   }
// }

// class Category {
//   final dynamic productCategorySlNo;
//   final dynamic parentId;
//   final String? productCategoryName;
//   final String? slug;
//   final String? image;
//   final dynamic isFeature;
//   final dynamic isMenubar;
//   final String? imgAlt;
//   final String? productCategoryDescription;
//   final dynamic rank;
//   final dynamic status;
//   final dynamic addBy;
//   final dynamic addTime;
//   final dynamic updateBy;
//   final dynamic updateTime;
//   final dynamic deletedAt;
//   final dynamic createdAt;
//   final dynamic updatedAt;
//   final String? seoTitle;
//   final String? seoDesp;
//   final String? seoKey;
//   final String? coverImage;
//   final String? coverImgAlt;
//   final dynamic categoryBranchid;
//   final Category? parents;

//   Category({
//     this.productCategorySlNo,
//     this.parentId,
//     this.productCategoryName,
//     this.slug,
//     this.image,
//     this.isFeature,
//     this.isMenubar,
//     this.imgAlt,
//     this.productCategoryDescription,
//     this.rank,
//     this.status,
//     this.addBy,
//     this.addTime,
//     this.updateBy,
//     this.updateTime,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.seoTitle,
//     this.seoDesp,
//     this.seoKey,
//     this.coverImage,
//     this.coverImgAlt,
//     this.categoryBranchid,
//     this.parents,
//   });

//   factory Category.fromMap(Map<String, dynamic> json) => Category(
//         productCategorySlNo: json["ProductCategory_SlNo"],
//         parentId: json["parent_id"],
//         productCategoryName: json["ProductCategory_Name"]?.toString(),
//         slug: json["slug"]?.toString(),
//         image: json["image"]?.toString(),
//         isFeature: json["is_feature"],
//         isMenubar: json["is_menubar"],
//         imgAlt: json["imgAlt"]?.toString(),
//         productCategoryDescription: json["ProductCategory_Description"]?.toString(),
//         rank: json["rank"],
//         status: json["status"],
//         addBy: json["AddBy"],
//         addTime: json["AddTime"],
//         updateBy: json["UpdateBy"],
//         updateTime: json["UpdateTime"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         seoTitle: json["seoTitle"]?.toString(),
//         seoDesp: json["seoDesp"]?.toString(),
//         seoKey: json["seoKey"]?.toString(),
//         coverImage: json["coverImage"]?.toString(),
//         coverImgAlt: json["coverImgAlt"]?.toString(),
//         categoryBranchid: json["category_branchid"],
//         parents:json["parents"] == null ? null : Category.fromMap(json["parents"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "ProductCategory_SlNo": productCategorySlNo,
//         "parent_id": parentId,
//         "ProductCategory_Name": productCategoryName,
//         "slug": slug,
//         "image": image,
//         "is_feature": isFeature,
//         "is_menubar": isMenubar,
//         "imgAlt": imgAlt,
//         "ProductCategory_Description": productCategoryDescription,
//         "rank": rank,
//         "status": status,
//         "AddBy": addBy,
//         "AddTime": addTime,
//         "UpdateBy": updateBy,
//         "UpdateTime": updateTime,
//         "deleted_at": deletedAt,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "seoTitle": seoTitle,
//         "seoDesp": seoDesp,
//         "seoKey": seoKey,
//         "coverImage": coverImage,
//         "coverImgAlt": coverImgAlt,
//         "category_branchid": categoryBranchid,
//         "parents": parents?.toMap(),
//       };
// }

// class Inventory {
//   final dynamic inventoryId;
//   final dynamic productId;
//   final dynamic purchaseQuantity;
//   final dynamic purchaseReturnQuantity;
//   final dynamic salesQuantity;
//   final dynamic salesReturnQuantity;
//   final dynamic wexchangeQuantity;
//   final dynamic damageQuantity;
//   final dynamic transferFromQuantity;
//   final dynamic transferToQuantity;
//   final dynamic branchId;

//   Inventory({
//     this.inventoryId,
//     this.productId,
//     this.purchaseQuantity,
//     this.purchaseReturnQuantity,
//     this.salesQuantity,
//     this.salesReturnQuantity,
//     this.wexchangeQuantity,
//     this.damageQuantity,
//     this.transferFromQuantity,
//     this.transferToQuantity,
//     this.branchId,
//   });

//   factory Inventory.fromMap(Map<String, dynamic> json) => Inventory(
//         inventoryId: json["inventory_id"],
//         productId: json["product_id"],
//         purchaseQuantity: json["purchase_quantity"],
//         purchaseReturnQuantity: json["purchase_return_quantity"],
//         salesQuantity: json["sales_quantity"],
//         salesReturnQuantity: json["sales_return_quantity"],
//         wexchangeQuantity: json["wexchange_quantity"],
//         damageQuantity: json["damage_quantity"],
//         transferFromQuantity: json["transfer_from_quantity"],
//         transferToQuantity: json["transfer_to_quantity"],
//         branchId: json["branch_id"],
//       );

//   Map<String, dynamic> toMap() => {
//         "inventory_id": inventoryId,
//         "product_id": productId,
//         "purchase_quantity": purchaseQuantity,
//         "purchase_return_quantity": purchaseReturnQuantity,
//         "sales_quantity": salesQuantity,
//         "sales_return_quantity": salesReturnQuantity,
//         "wexchange_quantity": wexchangeQuantity,
//         "damage_quantity": damageQuantity,
//         "transfer_from_quantity": transferFromQuantity,
//         "transfer_to_quantity": transferToQuantity,
//         "branch_id": branchId,
//       };
// }


// class MultipleImg {
//   final dynamic id;
//   final dynamic rank;
//   final String? image;
//   final dynamic productId;
//   final dynamic productCode;
//   final dynamic ipAddress;
//   final dynamic userId;
//   final dynamic createdAt;
//   final dynamic updatedAt;

//   MultipleImg({
//     this.id,
//     this.rank,
//     this.image,
//     this.productId,
//     this.productCode,
//     this.ipAddress,
//     this.userId,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory MultipleImg.fromMap(Map<String, dynamic> json) => MultipleImg(
//         id: json["id"],
//         rank: json["rank"],
//         image: json["image"]?.toString(),
//         productId: json["product_id"],
//         productCode: json["product_code"],
//         ipAddress: json["ip_address"],
//         userId: json["user_id"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "rank": rank,
//         "image": image,
//         "product_id": productId,
//         "product_code": productCode,
//         "ip_address": ipAddress,
//         "user_id": userId,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }

// class Relationbrand {
//     final dynamic brandSiNo;
//     final dynamic productCategorySlNo;
//     final dynamic brandName;
//     final dynamic status;
//     final dynamic brandBranchid;
//     final dynamic slug;
//     final dynamic image;
//     final dynamic topBrand;
//     final dynamic shopBrand;
//     final dynamic imgAlt;
//     final dynamic sort;
//     final dynamic createdAt;
//     final dynamic updatedAt;
//     final dynamic seoTitle;
//     final dynamic seoDesp;
//     final dynamic seoKey;
//     final dynamic coverimage;
//     final dynamic coverimgAlt;
//     final dynamic description;

//     Relationbrand({
//         required this.brandSiNo,
//         required this.productCategorySlNo,
//         required this.brandName,
//         required this.status,
//         required this.brandBranchid,
//         required this.slug,
//         required this.image,
//         required this.topBrand,
//         required this.shopBrand,
//         required this.imgAlt,
//         required this.sort,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.seoTitle,
//         required this.seoDesp,
//         required this.seoKey,
//         required this.coverimage,
//         required this.coverimgAlt,
//         required this.description,
//     });

//     factory Relationbrand.fromMap(Map<String, dynamic> json) => Relationbrand(
//         brandSiNo: json["brand_SiNo"],
//         productCategorySlNo: json["ProductCategory_SlNo"],
//         brandName: json["brand_name"],
//         status: json["status"],
//         brandBranchid: json["brand_branchid"],
//         slug: json["slug"],
//         image: json["image"],
//         topBrand: json["top_brand"],
//         shopBrand: json["shop_brand"],
//         imgAlt: json["imgAlt"],
//         sort: json["sort"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         seoTitle: json["seoTitle"],
//         seoDesp: json["seoDesp"],
//         seoKey: json["seoKey"],
//         coverimage: json["coverimage"],
//         coverimgAlt: json["coverimgAlt"],
//         description: json["description"],
//     );

//     Map<String, dynamic> toMap() => {
//         "brand_SiNo": brandSiNo,
//         "ProductCategory_SlNo": productCategorySlNo,
//         "brand_name": brandName,
//         "status": status,
//         "brand_branchid": brandBranchid,
//         "slug": slug,
//         "image": image,
//         "top_brand": topBrand,
//         "shop_brand": shopBrand,
//         "imgAlt": imgAlt,
//         "sort": sort,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "seoTitle": seoTitle,
//         "seoDesp": seoDesp,
//         "seoKey": seoKey,
//         "coverimage": coverimage,
//         "coverimgAlt": coverimgAlt,
//         "description": description,
//     };
// }


// class Relationcolor {
//   final dynamic colorSiNo;
//   final String? colorName;
//   final dynamic status;
//   final dynamic code;
//   final dynamic deletedAt;
//   final dynamic createdAt;
//   final dynamic updatedAt;

//   Relationcolor({
//     this.colorSiNo,
//     this.colorName,
//     this.status,
//     this.code,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Relationcolor.fromMap(Map<String, dynamic> json) => Relationcolor(
//         colorSiNo: json["color_SiNo"],
//         colorName: json["color_name"]?.toString(),
//         status: json["status"],
//         code: json["code"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );

//   Map<String, dynamic> toMap() => {
//         "color_SiNo": colorSiNo,
//         "color_name": colorName,
//         "status": status,
//         "code": code,
//         "deleted_at": deletedAt,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }















// // import 'dart:convert';

// // class AllProductModel {
// //     final dynamic productSlNo;
// //     final dynamic productCode;
// //     final dynamic productName;
// //     final dynamic productCategoryId;
// //     final dynamic reference;
// //     final dynamic barcode;
// //     final dynamic color;
// //     final dynamic brand;
// //     final dynamic modelId;
// //     final dynamic size;
// //     final dynamic vat;
// //     final dynamic productReOrederLevel;
// //     final dynamic productPurchaseRate;
// //     final dynamic productSellingPrice;
// //     final dynamic productMinimumSellingPrice;
// //     final dynamic productWholesaleRate;
// //     final dynamic productCorporateRate;
// //     final dynamic productOnlineRate;
// //     final dynamic onlineDiscount;
// //     final dynamic onlineDiscountPrice;
// //     final dynamic onlineAfterDiscountAmount;
// //     final dynamic startDate;
// //     final dynamic oneCartunEqual;
// //     final dynamic isService;
// //     final dynamic isSerial;
// //     final dynamic unitId;
// //     final dynamic warranty;
// //     final dynamic status;
// //     final dynamic addBy;
// //     final dynamic addTime;
// //     final dynamic updateBy;
// //     final dynamic updateTime;
// //     final dynamic lastUpdateIp;
// //     final dynamic productBranchid;
// //     final dynamic model;
// //     final dynamic slug;
// //     final dynamic shortDescription;
// //     final dynamic longDescription;
// //     final dynamic specification;
// //     final dynamic video;
// //     final dynamic warrantyLongText;
// //     final dynamic emiAvilable;
// //     final dynamic isExchange;
// //     final dynamic isFeature;
// //     final dynamic isBestDeal;
// //     final dynamic isBestSallers;
// //     final dynamic newArrival;
// //     final dynamic isOffer;
// //     final dynamic type;
// //     final dynamic mainImage;
// //     final dynamic alterImage;
// //     final dynamic mainImageAlt;
// //     final dynamic alterImageAlt;
// //     final dynamic weight;
// //     final dynamic dimensions;
// //     final dynamic note;
// //     final dynamic compatibility;
// //     final dynamic connectivity;
// //     final dynamic noiseCancellation;
// //     final dynamic microphone;
// //     final dynamic waterResistance;
// //     final dynamic powerOutput;
// //     final dynamic frequencyResponse;
// //     final dynamic material;
// //     final dynamic batteryCapacity;
// //     final dynamic camera;
// //     final dynamic network;
// //     final dynamic processor;
// //     final dynamic ram;
// //     final dynamic storage;
// //     final dynamic display;
// //     final dynamic batteryLife;
// //     final dynamic operatingSystem;
// //     final dynamic ports;
// //     final dynamic cableType;
// //     final dynamic length;
// //     final dynamic isDraft;
// //     final dynamic seoTitle;
// //     final dynamic seoKeywords;
// //     final dynamic seoDescription;
// //     final dynamic storageId;
// //     final dynamic regionId;
// //     final dynamic simId;
// //     final dynamic strapId;
// //     final dynamic networkId;
// //     final dynamic plugId;
// //     final dynamic sizeId;
// //     final dynamic specificationTypeId;
// //     final dynamic endDate;
// //     final dynamic preOrder;
// //     final dynamic isTba;
// //     final dynamic isCallForAvailablity;
// //     final dynamic isOnlineOrder;
// //     final dynamic showOnWebsite;
// //     final dynamic deletedBy;
// //     final dynamic deletedAt;
// //     final dynamic createdAt;
// //     final Inventory? inventory;
// //     final List<MultipleImg>? multipleImg;
// //     final Relationcolor? relationcolor;
// //     final Category? category;

// //     AllProductModel({
// //         required this.productSlNo,
// //         required this.productCode,
// //         required this.productName,
// //         required this.productCategoryId,
// //         required this.reference,
// //         required this.barcode,
// //         required this.color,
// //         required this.brand,
// //         required this.modelId,
// //         required this.size,
// //         required this.vat,
// //         required this.productReOrederLevel,
// //         required this.productPurchaseRate,
// //         required this.productSellingPrice,
// //         required this.productMinimumSellingPrice,
// //         required this.productWholesaleRate,
// //         required this.productCorporateRate,
// //         required this.productOnlineRate,
// //         required this.onlineDiscount,
// //         required this.onlineDiscountPrice,
// //         required this.onlineAfterDiscountAmount,
// //         required this.startDate,
// //         required this.oneCartunEqual,
// //         required this.isService,
// //         required this.isSerial,
// //         required this.unitId,
// //         required this.warranty,
// //         required this.status,
// //         required this.addBy,
// //         required this.addTime,
// //         required this.updateBy,
// //         required this.updateTime,
// //         required this.lastUpdateIp,
// //         required this.productBranchid,
// //         required this.model,
// //         required this.slug,
// //         required this.shortDescription,
// //         required this.longDescription,
// //         required this.specification,
// //         required this.video,
// //         required this.warrantyLongText,
// //         required this.emiAvilable,
// //         required this.isExchange,
// //         required this.isFeature,
// //         required this.isBestDeal,
// //         required this.isBestSallers,
// //         required this.newArrival,
// //         required this.isOffer,
// //         required this.type,
// //         required this.mainImage,
// //         required this.alterImage,
// //         required this.mainImageAlt,
// //         required this.alterImageAlt,
// //         required this.weight,
// //         required this.dimensions,
// //         required this.note,
// //         required this.compatibility,
// //         required this.connectivity,
// //         required this.noiseCancellation,
// //         required this.microphone,
// //         required this.waterResistance,
// //         required this.powerOutput,
// //         required this.frequencyResponse,
// //         required this.material,
// //         required this.batteryCapacity,
// //         required this.camera,
// //         required this.network,
// //         required this.processor,
// //         required this.ram,
// //         required this.storage,
// //         required this.display,
// //         required this.batteryLife,
// //         required this.operatingSystem,
// //         required this.ports,
// //         required this.cableType,
// //         required this.length,
// //         required this.isDraft,
// //         required this.seoTitle,
// //         required this.seoKeywords,
// //         required this.seoDescription,
// //         required this.storageId,
// //         required this.regionId,
// //         required this.simId,
// //         required this.strapId,
// //         required this.networkId,
// //         required this.plugId,
// //         required this.sizeId,
// //         required this.specificationTypeId,
// //         required this.endDate,
// //         required this.preOrder,
// //         required this.isTba,
// //         required this.isCallForAvailablity,
// //         required this.isOnlineOrder,
// //         required this.showOnWebsite,
// //         required this.deletedBy,
// //         required this.deletedAt,
// //         required this.createdAt,
// //         required this.inventory,
// //         required this.multipleImg,
// //         required this.relationcolor,
// //         required this.category,
// //     });

// //     factory AllProductModel.fromJson(String str) => AllProductModel.fromMap(json.decode(str));

// //     String toJson() => json.encode(toMap());

// //     factory AllProductModel.fromMap(Map<String, dynamic> json) => AllProductModel(
// //         productSlNo: json["Product_SlNo"],
// //         productCode: json["Product_Code"],
// //         productName: json["Product_Name"],
// //         productCategoryId: json["ProductCategory_ID"],
// //         reference: json["reference"],
// //         barcode: json["barcode"],
// //         color: json["color"],
// //         brand: json["brand"],
// //         modelId: json["model_id"],
// //         size: json["size"],
// //         vat: json["vat"],
// //         productReOrederLevel: json["Product_ReOrederLevel"],
// //         productPurchaseRate: json["Product_Purchase_Rate"],
// //         productSellingPrice: json["Product_SellingPrice"],
// //         productMinimumSellingPrice: json["Product_MinimumSellingPrice"],
// //         productWholesaleRate: json["Product_WholesaleRate"],
// //         productCorporateRate: json["Product_CorporateRate"],
// //         productOnlineRate: json["Product_OnlineRate"],
// //         onlineDiscount: json["online_discount"],
// //         onlineDiscountPrice: json["online_discount_price"],
// //         onlineAfterDiscountAmount: json["online_after_discount_amount"],
// //         startDate: json["start_date"],
// //         oneCartunEqual: json["one_cartun_equal"],
// //         isService: json["is_service"],
// //         isSerial: json["is_serial"],
// //         unitId: json["Unit_ID"],
// //         warranty: json["warranty"],
// //         status: json["status"],
// //         addBy: json["AddBy"],
// //         addTime: json["AddTime"],
// //         updateBy: json["UpdateBy"],
// //         updateTime: json["UpdateTime"],
// //         lastUpdateIp: json["last_update_ip"],
// //         productBranchid: json["Product_branchid"],
// //         model: json["model"],
// //         slug: json["slug"],
// //         shortDescription: json["short_description"],
// //         longDescription: json["long_description"],
// //         specification: json["specification"],
// //         video: json["video"],
// //         warrantyLongText: json["warranty_long_text"],
// //         emiAvilable: json["emi_avilable"],
// //         isExchange: json["is_exchange"],
// //         isFeature: json["is_feature"],
// //         isBestDeal: json["is_best_deal"],
// //         isBestSallers: json["is_best_sallers"],
// //         newArrival: json["new_arrival"],
// //         isOffer: json["is_offer"],
// //         type: json["type"],
// //         mainImage: json["main_image"],
// //         alterImage: json["alter_image"],
// //         mainImageAlt: json["main_image_alt"],
// //         alterImageAlt: json["alter_image_alt"],
// //         weight: json["weight"],
// //         dimensions: json["dimensions"],
// //         note: json["note"],
// //         compatibility: json["compatibility"],
// //         connectivity: json["connectivity"],
// //         noiseCancellation: json["noise_cancellation"],
// //         microphone: json["microphone"],
// //         waterResistance: json["water_resistance"],
// //         powerOutput: json["power_output"],
// //         frequencyResponse: json["frequency_response"],
// //         material: json["material"],
// //         batteryCapacity: json["battery_capacity"],
// //         camera: json["camera"],
// //         network: json["network"],
// //         processor: json["processor"],
// //         ram: json["ram"],
// //         storage: json["storage"],
// //         display: json["display"],
// //         batteryLife: json["battery_life"],
// //         operatingSystem: json["operating_system"],
// //         ports: json["ports"],
// //         cableType: json["cable_type"],
// //         length: json["length"],
// //         isDraft: json["is_draft"],
// //         seoTitle: json["seoTitle"],
// //         seoKeywords: json["seoKeywords"],
// //         seoDescription: json["seoDescription"],
// //         storageId: json["storage_id"],
// //         regionId: json["region_id"],
// //         simId: json["sim_id"],
// //         strapId: json["strap_id"],
// //         networkId: json["network_id"],
// //         plugId: json["plug_id"],
// //         sizeId: json["size_id"],
// //         specificationTypeId: json["specification_type_id"],
// //         endDate: json["end_date"],
// //         preOrder: json["pre_order"],
// //         isTba: json["is_tba"],
// //         isCallForAvailablity: json["is_call_for_availablity"],
// //         isOnlineOrder: json["is_online_order"],
// //         showOnWebsite: json["show_on_website"],
// //         deletedBy: json["deleted_by"],
// //         deletedAt: json["deleted_at"],
// //         createdAt: json["created_at"],
// //         inventory: json["inventory"] == null ? null : Inventory.fromMap(json["inventory"]),
// //         multipleImg: json["multiple_img"] == null || json["multiple_img"] == [] ? [] : List<MultipleImg>.from(json["multiple_img"].map((x) => MultipleImg.fromMap(x))),
// //         relationcolor: json["relationcolor"] == null ? null : Relationcolor.fromMap(json["relationcolor"]),
// //         category: json["category"] == null ? null :  Category.fromMap(json["category"]),
// //     );

// //     Map<String, dynamic> toMap() => {
// //         "Product_SlNo": productSlNo,
// //         "Product_Code": productCode,
// //         "Product_Name": productName,
// //         "ProductCategory_ID": productCategoryId,
// //         "reference": reference,
// //         "barcode": barcode,
// //         "color": color,
// //         "brand": brand,
// //         "model_id": modelId,
// //         "size": size,
// //         "vat": vat,
// //         "Product_ReOrederLevel": productReOrederLevel,
// //         "Product_Purchase_Rate": productPurchaseRate,
// //         "Product_SellingPrice": productSellingPrice,
// //         "Product_MinimumSellingPrice": productMinimumSellingPrice,
// //         "Product_WholesaleRate": productWholesaleRate,
// //         "Product_CorporateRate": productCorporateRate,
// //         "Product_OnlineRate": productOnlineRate,
// //         "online_discount": onlineDiscount,
// //         "online_discount_price": onlineDiscountPrice,
// //         "online_after_discount_amount": onlineAfterDiscountAmount,
// //         "start_date": startDate,
// //         "one_cartun_equal": oneCartunEqual,
// //         "is_service": isService,
// //         "is_serial": isSerial,
// //         "Unit_ID": unitId,
// //         "warranty": warranty,
// //         "status": status,
// //         "AddBy": addBy,
// //         "AddTime": addTime,
// //         "UpdateBy": updateBy,
// //         "UpdateTime": updateTime,
// //         "last_update_ip": lastUpdateIp,
// //         "Product_branchid": productBranchid,
// //         "model": model,
// //         "slug": slug,
// //         "short_description": shortDescription,
// //         "long_description": longDescription,
// //         "specification": specification,
// //         "video": video,
// //         "warranty_long_text": warrantyLongText,
// //         "emi_avilable": emiAvilable,
// //         "is_exchange": isExchange,
// //         "is_feature": isFeature,
// //         "is_best_deal": isBestDeal,
// //         "is_best_sallers": isBestSallers,
// //         "new_arrival": newArrival,
// //         "is_offer": isOffer,
// //         "type": type,
// //         "main_image": mainImage,
// //         "alter_image": alterImage,
// //         "main_image_alt": mainImageAlt,
// //         "alter_image_alt": alterImageAlt,
// //         "weight": weight,
// //         "dimensions": dimensions,
// //         "note": note,
// //         "compatibility": compatibility,
// //         "connectivity": connectivity,
// //         "noise_cancellation": noiseCancellation,
// //         "microphone": microphone,
// //         "water_resistance": waterResistance,
// //         "power_output": powerOutput,
// //         "frequency_response": frequencyResponse,
// //         "material": material,
// //         "battery_capacity": batteryCapacity,
// //         "camera": camera,
// //         "network": network,
// //         "processor": processor,
// //         "ram": ram,
// //         "storage": storage,
// //         "display": display,
// //         "battery_life": batteryLife,
// //         "operating_system": operatingSystem,
// //         "ports": ports,
// //         "cable_type": cableType,
// //         "length": length,
// //         "is_draft": isDraft,
// //         "seoTitle": seoTitle,
// //         "seoKeywords": seoKeywords,
// //         "seoDescription": seoDescription,
// //         "storage_id": storageId,
// //         "region_id": regionId,
// //         "sim_id": simId,
// //         "strap_id": strapId,
// //         "network_id": networkId,
// //         "plug_id": plugId,
// //         "size_id": sizeId,
// //         "specification_type_id": specificationTypeId,
// //         "end_date": endDate,
// //         "pre_order": preOrder,
// //         "is_tba": isTba,
// //         "is_call_for_availablity": isCallForAvailablity,
// //         "is_online_order": isOnlineOrder,
// //         "show_on_website": showOnWebsite,
// //         "deleted_by": deletedBy,
// //         "deleted_at": deletedAt,
// //         "created_at": createdAt,
// //         "inventory": inventory!.toMap(),
// //         "multiple_img": List<dynamic>.from(multipleImg!.map((x) => x.toJson())),
// //         "relationcolor": relationcolor!.toMap(),
// //         "category": category!.toMap(),
// //     };
// // }

// // class Category {
// //     final dynamic productCategorySlNo;
// //     final dynamic parentId;
// //     final dynamic productCategoryName;
// //     final dynamic slug;
// //     final dynamic image;
// //     final dynamic isFeature;
// //     final dynamic isMenubar;
// //     final dynamic imgAlt;
// //     final dynamic productCategoryDescription;
// //     final dynamic rank;
// //     final dynamic status;
// //     final dynamic addBy;
// //     final dynamic addTime;
// //     final dynamic updateBy;
// //     final dynamic updateTime;
// //     final dynamic deletedAt;
// //     final dynamic createdAt;
// //     final dynamic updatedAt;
// //     final dynamic seoTitle;
// //     final dynamic seoDesp;
// //     final dynamic seoKey;
// //     final dynamic coverImage;
// //     final dynamic coverImgAlt;
// //     final dynamic categoryBranchid;
// //     final Category? parents;

// //     Category({
// //         required this.productCategorySlNo,
// //         required this.parentId,
// //         required this.productCategoryName,
// //         required this.slug,
// //         required this.image,
// //         required this.isFeature,
// //         required this.isMenubar,
// //         required this.imgAlt,
// //         required this.productCategoryDescription,
// //         required this.rank,
// //         required this.status,
// //         required this.addBy,
// //         required this.addTime,
// //         required this.updateBy,
// //         required this.updateTime,
// //         required this.deletedAt,
// //         required this.createdAt,
// //         required this.updatedAt,
// //         required this.seoTitle,
// //         required this.seoDesp,
// //         required this.seoKey,
// //         required this.coverImage,
// //         required this.coverImgAlt,
// //         required this.categoryBranchid,
// //         required this.parents,
// //     });

// //     factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

// //     String toJson() => json.encode(toMap());

// //     factory Category.fromMap(Map<String, dynamic> json) => Category(
// //         productCategorySlNo: json["ProductCategory_SlNo"],
// //         parentId: json["parent_id"],
// //         productCategoryName: json["ProductCategory_Name"],
// //         slug: json["slug"],
// //         image: json["image"],
// //         isFeature: json["is_feature"],
// //         isMenubar: json["is_menubar"],
// //         imgAlt: json["imgAlt"],
// //         productCategoryDescription: json["ProductCategory_Description"],
// //         rank: json["rank"],
// //         status: json["status"],
// //         addBy: json["AddBy"],
// //         addTime: json["AddTime"],
// //         updateBy: json["UpdateBy"],
// //         updateTime: json["UpdateTime"],
// //         deletedAt: json["deleted_at"],
// //         createdAt: json["created_at"],
// //         updatedAt: json["updated_at"],
// //         seoTitle: json["seoTitle"],
// //         seoDesp: json["seoDesp"],
// //         seoKey: json["seoKey"],
// //         coverImage: json["coverImage"],
// //         coverImgAlt: json["coverImgAlt"],
// //         categoryBranchid: json["category_branchid"],
// //         parents: json["parents"] == null ?  null : Category.fromMap(json["parents"]),
// //     );

// //     Map<String, dynamic> toMap() => {
// //         "ProductCategory_SlNo": productCategorySlNo,
// //         "parent_id": parentId,
// //         "ProductCategory_Name": productCategoryName,
// //         "slug": slug,
// //         "image": image,
// //         "is_feature": isFeature,
// //         "is_menubar": isMenubar,
// //         "imgAlt": imgAlt,
// //         "ProductCategory_Description": productCategoryDescription,
// //         "rank": rank,
// //         "status": status,
// //         "AddBy": addBy,
// //         "AddTime": addTime,
// //         "UpdateBy": updateBy,
// //         "UpdateTime": updateTime,
// //         "deleted_at": deletedAt,
// //         "created_at": createdAt,
// //         "updated_at": updatedAt,
// //         "seoTitle": seoTitle,
// //         "seoDesp": seoDesp,
// //         "seoKey": seoKey,
// //         "coverImage": coverImage,
// //         "coverImgAlt": coverImgAlt,
// //         "category_branchid": categoryBranchid,
// //         "parents": parents!.toMap(),
// //     };
// // }

// // class Inventory {
// //     final dynamic inventoryId;
// //     final dynamic productId;
// //     final dynamic purchaseQuantity;
// //     final dynamic purchaseReturnQuantity;
// //     final dynamic salesQuantity;
// //     final dynamic salesReturnQuantity;
// //     final dynamic wexchangeQuantity;
// //     final dynamic damageQuantity;
// //     final dynamic transferFromQuantity;
// //     final dynamic transferToQuantity;
// //     final dynamic branchId;

// //     Inventory({
// //         required this.inventoryId,
// //         required this.productId,
// //         required this.purchaseQuantity,
// //         required this.purchaseReturnQuantity,
// //         required this.salesQuantity,
// //         required this.salesReturnQuantity,
// //         required this.wexchangeQuantity,
// //         required this.damageQuantity,
// //         required this.transferFromQuantity,
// //         required this.transferToQuantity,
// //         required this.branchId,
// //     });

// //     factory Inventory.fromJson(String str) => Inventory.fromMap(json.decode(str));

// //     String toJson() => json.encode(toMap());

// //     factory Inventory.fromMap(Map<String, dynamic> json) => Inventory(
// //         inventoryId: json["inventory_id"],
// //         productId: json["product_id"],
// //         purchaseQuantity: json["purchase_quantity"],
// //         purchaseReturnQuantity: json["purchase_return_quantity"],
// //         salesQuantity: json["sales_quantity"],
// //         salesReturnQuantity: json["sales_return_quantity"],
// //         wexchangeQuantity: json["wexchange_quantity"],
// //         damageQuantity: json["damage_quantity"],
// //         transferFromQuantity: json["transfer_from_quantity"],
// //         transferToQuantity: json["transfer_to_quantity"],
// //         branchId: json["branch_id"],
// //     );

// //     Map<String, dynamic> toMap() => {
// //         "inventory_id": inventoryId,
// //         "product_id": productId,
// //         "purchase_quantity": purchaseQuantity,
// //         "purchase_return_quantity": purchaseReturnQuantity,
// //         "sales_quantity": salesQuantity,
// //         "sales_return_quantity": salesReturnQuantity,
// //         "wexchange_quantity": wexchangeQuantity,
// //         "damage_quantity": damageQuantity,
// //         "transfer_from_quantity": transferFromQuantity,
// //         "transfer_to_quantity": transferToQuantity,
// //         "branch_id": branchId,
// //     };
// // }

// // class MultipleImg {
// //     final dynamic id;
// //     final dynamic rank;
// //     final dynamic image;
// //     final dynamic productId;
// //     final dynamic productCode;
// //     final dynamic ipAddress;
// //     final dynamic userId;
// //     final dynamic createdAt;
// //     final dynamic updatedAt;

// //     MultipleImg({
// //         required this.id,
// //         required this.rank,
// //         required this.image,
// //         required this.productId,
// //         required this.productCode,
// //         required this.ipAddress,
// //         required this.userId,
// //         required this.createdAt,
// //         required this.updatedAt,
// //     });

// //     factory MultipleImg.fromJson(String str) => MultipleImg.fromMap(json.decode(str));

// //     String toJson() => json.encode(toMap());

// //     factory MultipleImg.fromMap(Map<String, dynamic> json) => MultipleImg(
// //         id: json["id"],
// //         rank: json["rank"],
// //         image: json["image"],
// //         productId: json["product_id"],
// //         productCode: json["product_code"],
// //         ipAddress: json["ip_address"],
// //         userId: json["user_id"],
// //         createdAt: json["created_at"],
// //         updatedAt: json["updated_at"],
// //     );

// //     Map<String, dynamic> toMap() => {
// //         "id": id,
// //         "rank": rank,
// //         "image": image,
// //         "product_id": productId,
// //         "product_code": productCode,
// //         "ip_address": ipAddress,
// //         "user_id": userId,
// //         "created_at": createdAt,
// //         "updated_at": updatedAt,
// //     };
// // }

// // class Relationcolor {
// //     final dynamic colorSiNo;
// //     final dynamic colorName;
// //     final dynamic status;
// //     final dynamic code;
// //     final dynamic deletedAt;
// //     final dynamic createdAt;
// //     final dynamic updatedAt;

// //     Relationcolor({
// //         required this.colorSiNo,
// //         required this.colorName,
// //         required this.status,
// //         required this.code,
// //         required this.deletedAt,
// //         required this.createdAt,
// //         required this.updatedAt,
// //     });

// //     factory Relationcolor.fromJson(String str) => Relationcolor.fromMap(json.decode(str));

// //     String toJson() => json.encode(toMap());

// //     factory Relationcolor.fromMap(Map<String, dynamic> json) => Relationcolor(
// //         colorSiNo: json["color_SiNo"],
// //         colorName: json["color_name"],
// //         status: json["status"],
// //         code: json["code"],
// //         deletedAt: json["deleted_at"],
// //         createdAt: json["created_at"],
// //         updatedAt: json["updated_at"],
// //     );

// //     Map<String, dynamic> toMap() => {
// //         "color_SiNo": colorSiNo,
// //         "color_name": colorName,
// //         "status": status,
// //         "code": code,
// //         "deleted_at": deletedAt,
// //         "created_at": createdAt,
// //         "updated_at": updatedAt,
// //     };
// // }














// // import 'dart:convert';

// // class AllProductModel {
// //     final dynamic productSlNo;
// //     final dynamic productCode;
// //     final dynamic productName;
// //     final dynamic productCategoryId;
// //     final dynamic reference;
// //     final dynamic barcode;
// //     final dynamic color;
// //     final dynamic brand;
// //     final dynamic modelId;
// //     final dynamic size;
// //     final dynamic vat;
// //     final dynamic productReOrederLevel;
// //     final dynamic productPurchaseRate;
// //     final dynamic productSellingPrice;
// //     final dynamic productMinimumSellingPrice;
// //     final dynamic productWholesaleRate;
// //     final dynamic productCorporateRate;
// //     final dynamic productOnlineRate;
// //     final dynamic onlineDiscount;
// //     final dynamic onlineDiscountPrice;
// //     final dynamic onlineAfterDiscountAmount;
// //     final dynamic startDate;
// //     final dynamic oneCartunEqual;
// //     final dynamic isService;
// //     final dynamic isSerial;
// //     final dynamic unitId;
// //     final dynamic warranty;
// //     final dynamic status;
// //     final dynamic addBy;
// //     final dynamic addTime;
// //     final dynamic updateBy;
// //     final dynamic updateTime;
// //     final dynamic lastUpdateIp;
// //     final dynamic productBranchid;
// //     final dynamic model;
// //     final dynamic slug;
// //     final dynamic shortDescription;
// //     final dynamic longDescription;
// //     final dynamic specification;
// //     final dynamic video;
// //     final dynamic warrantyLongText;
// //     final dynamic emiAvilable;
// //     final dynamic isExchange;
// //     final dynamic isFeature;
// //     final dynamic isBestDeal;
// //     final dynamic isBestSallers;
// //     final dynamic newArrival;
// //     final dynamic isOffer;
// //     final dynamic type;
// //     final dynamic mainImage;
// //     final dynamic alterImage;
// //     final dynamic mainImageAlt;
// //     final dynamic alterImageAlt;
// //     final dynamic weight;
// //     final dynamic dimensions;
// //     final dynamic note;
// //     final dynamic compatibility;
// //     final dynamic connectivity;
// //     final dynamic noiseCancellation;
// //     final dynamic microphone;
// //     final dynamic waterResistance;
// //     final dynamic powerOutput;
// //     final dynamic frequencyResponse;
// //     final dynamic material;
// //     final dynamic batteryCapacity;
// //     final dynamic camera;
// //     final dynamic network;
// //     final dynamic processor;
// //     final dynamic ram;
// //     final dynamic storage;
// //     final dynamic display;
// //     final dynamic batteryLife;
// //     final dynamic operatingSystem;
// //     final dynamic ports;
// //     final dynamic cableType;
// //     final dynamic length;
// //     final dynamic isDraft;
// //     final dynamic seoTitle;
// //     final dynamic seoKeywords;
// //     final dynamic seoDescription;
// //     final dynamic storageId;
// //     final dynamic regionId;
// //     final dynamic simId;
// //     final dynamic strapId;
// //     final dynamic networkId;
// //     final dynamic plugId;
// //     final dynamic sizeId;
// //     final dynamic specificationTypeId;
// //     final dynamic endDate;
// //     final dynamic preOrder;
// //     final dynamic isTba;
// //     final dynamic isCallForAvailablity;
// //     final dynamic isOnlineOrder;
// //     final dynamic showOnWebsite;
// //     final dynamic deletedBy;
// //     final dynamic deletedAt;
// //     final dynamic createdAt;

// //     AllProductModel({
// //         required this.productSlNo,
// //         required this.productCode,
// //         required this.productName,
// //         required this.productCategoryId,
// //         required this.reference,
// //         required this.barcode,
// //         required this.color,
// //         required this.brand,
// //         required this.modelId,
// //         required this.size,
// //         required this.vat,
// //         required this.productReOrederLevel,
// //         required this.productPurchaseRate,
// //         required this.productSellingPrice,
// //         required this.productMinimumSellingPrice,
// //         required this.productWholesaleRate,
// //         required this.productCorporateRate,
// //         required this.productOnlineRate,
// //         required this.onlineDiscount,
// //         required this.onlineDiscountPrice,
// //         required this.onlineAfterDiscountAmount,
// //         required this.startDate,
// //         required this.oneCartunEqual,
// //         required this.isService,
// //         required this.isSerial,
// //         required this.unitId,
// //         required this.warranty,
// //         required this.status,
// //         required this.addBy,
// //         required this.addTime,
// //         required this.updateBy,
// //         required this.updateTime,
// //         required this.lastUpdateIp,
// //         required this.productBranchid,
// //         required this.model,
// //         required this.slug,
// //         required this.shortDescription,
// //         required this.longDescription,
// //         required this.specification,
// //         required this.video,
// //         required this.warrantyLongText,
// //         required this.emiAvilable,
// //         required this.isExchange,
// //         required this.isFeature,
// //         required this.isBestDeal,
// //         required this.isBestSallers,
// //         required this.newArrival,
// //         required this.isOffer,
// //         required this.type,
// //         required this.mainImage,
// //         required this.alterImage,
// //         required this.mainImageAlt,
// //         required this.alterImageAlt,
// //         required this.weight,
// //         required this.dimensions,
// //         required this.note,
// //         required this.compatibility,
// //         required this.connectivity,
// //         required this.noiseCancellation,
// //         required this.microphone,
// //         required this.waterResistance,
// //         required this.powerOutput,
// //         required this.frequencyResponse,
// //         required this.material,
// //         required this.batteryCapacity,
// //         required this.camera,
// //         required this.network,
// //         required this.processor,
// //         required this.ram,
// //         required this.storage,
// //         required this.display,
// //         required this.batteryLife,
// //         required this.operatingSystem,
// //         required this.ports,
// //         required this.cableType,
// //         required this.length,
// //         required this.isDraft,
// //         required this.seoTitle,
// //         required this.seoKeywords,
// //         required this.seoDescription,
// //         required this.storageId,
// //         required this.regionId,
// //         required this.simId,
// //         required this.strapId,
// //         required this.networkId,
// //         required this.plugId,
// //         required this.sizeId,
// //         required this.specificationTypeId,
// //         required this.endDate,
// //         required this.preOrder,
// //         required this.isTba,
// //         required this.isCallForAvailablity,
// //         required this.isOnlineOrder,
// //         required this.showOnWebsite,
// //         required this.deletedBy,
// //         required this.deletedAt,
// //         required this.createdAt,
// //     });

// //     factory AllProductModel.fromJson(String str) => AllProductModel.fromMap(json.decode(str));

// //     String toJson() => json.encode(toMap());

// //     factory AllProductModel.fromMap(Map<String, dynamic> json) => AllProductModel(
// //         productSlNo: json["Product_SlNo"],
// //         productCode: json["Product_Code"],
// //         productName: json["Product_Name"],
// //         productCategoryId: json["ProductCategory_ID"],
// //         reference: json["reference"],
// //         barcode: json["barcode"],
// //         color: json["color"],
// //         brand: json["brand"],
// //         modelId: json["model_id"],
// //         size: json["size"],
// //         vat: json["vat"],
// //         productReOrederLevel: json["Product_ReOrederLevel"],
// //         productPurchaseRate: json["Product_Purchase_Rate"],
// //         productSellingPrice: json["Product_SellingPrice"],
// //         productMinimumSellingPrice: json["Product_MinimumSellingPrice"],
// //         productWholesaleRate: json["Product_WholesaleRate"],
// //         productCorporateRate: json["Product_CorporateRate"],
// //         productOnlineRate: json["Product_OnlineRate"],
// //         onlineDiscount: json["online_discount"],
// //         onlineDiscountPrice: json["online_discount_price"],
// //         onlineAfterDiscountAmount: json["online_after_discount_amount"],
// //         startDate: json["start_date"],
// //         oneCartunEqual: json["one_cartun_equal"],
// //         isService: json["is_service"],
// //         isSerial: json["is_serial"],
// //         unitId: json["Unit_ID"],
// //         warranty: json["warranty"],
// //         status: json["status"],
// //         addBy: json["AddBy"],
// //         addTime: json["AddTime"],
// //         updateBy: json["UpdateBy"],
// //         updateTime: json["UpdateTime"],
// //         lastUpdateIp: json["last_update_ip"],
// //         productBranchid: json["Product_branchid"],
// //         model: json["model"],
// //         slug: json["slug"],
// //         shortDescription: json["short_description"],
// //         longDescription: json["long_description"],
// //         specification: json["specification"],
// //         video: json["video"],
// //         warrantyLongText: json["warranty_long_text"],
// //         emiAvilable: json["emi_avilable"],
// //         isExchange: json["is_exchange"],
// //         isFeature: json["is_feature"],
// //         isBestDeal: json["is_best_deal"],
// //         isBestSallers: json["is_best_sallers"],
// //         newArrival: json["new_arrival"],
// //         isOffer: json["is_offer"],
// //         type: json["type"],
// //         mainImage: json["main_image"],
// //         alterImage: json["alter_image"],
// //         mainImageAlt: json["main_image_alt"],
// //         alterImageAlt: json["alter_image_alt"],
// //         weight: json["weight"],
// //         dimensions: json["dimensions"],
// //         note: json["note"],
// //         compatibility: json["compatibility"],
// //         connectivity: json["connectivity"],
// //         noiseCancellation: json["noise_cancellation"],
// //         microphone: json["microphone"],
// //         waterResistance: json["water_resistance"],
// //         powerOutput: json["power_output"],
// //         frequencyResponse: json["frequency_response"],
// //         material: json["material"],
// //         batteryCapacity: json["battery_capacity"],
// //         camera: json["camera"],
// //         network: json["network"],
// //         processor: json["processor"],
// //         ram: json["ram"],
// //         storage: json["storage"],
// //         display: json["display"],
// //         batteryLife: json["battery_life"],
// //         operatingSystem: json["operating_system"],
// //         ports: json["ports"],
// //         cableType: json["cable_type"],
// //         length: json["length"],
// //         isDraft: json["is_draft"],
// //         seoTitle: json["seoTitle"],
// //         seoKeywords: json["seoKeywords"],
// //         seoDescription: json["seoDescription"],
// //         storageId: json["storage_id"],
// //         regionId: json["region_id"],
// //         simId: json["sim_id"],
// //         strapId: json["strap_id"],
// //         networkId: json["network_id"],
// //         plugId: json["plug_id"],
// //         sizeId: json["size_id"],
// //         specificationTypeId: json["specification_type_id"],
// //         endDate: json["end_date"],
// //         preOrder: json["pre_order"],
// //         isTba: json["is_tba"],
// //         isCallForAvailablity: json["is_call_for_availablity"],
// //         isOnlineOrder: json["is_online_order"],
// //         showOnWebsite: json["show_on_website"],
// //         deletedBy: json["deleted_by"],
// //         deletedAt: json["deleted_at"],
// //         createdAt: json["created_at"],
// //     );

// //     Map<String, dynamic> toMap() => {
// //         "Product_SlNo": productSlNo,
// //         "Product_Code": productCode,
// //         "Product_Name": productName,
// //         "ProductCategory_ID": productCategoryId,
// //         "reference": reference,
// //         "barcode": barcode,
// //         "color": color,
// //         "brand": brand,
// //         "model_id": modelId,
// //         "size": size,
// //         "vat": vat,
// //         "Product_ReOrederLevel": productReOrederLevel,
// //         "Product_Purchase_Rate": productPurchaseRate,
// //         "Product_SellingPrice": productSellingPrice,
// //         "Product_MinimumSellingPrice": productMinimumSellingPrice,
// //         "Product_WholesaleRate": productWholesaleRate,
// //         "Product_CorporateRate": productCorporateRate,
// //         "Product_OnlineRate": productOnlineRate,
// //         "online_discount": onlineDiscount,
// //         "online_discount_price": onlineDiscountPrice,
// //         "online_after_discount_amount": onlineAfterDiscountAmount,
// //         "start_date": startDate,
// //         "one_cartun_equal": oneCartunEqual,
// //         "is_service": isService,
// //         "is_serial": isSerial,
// //         "Unit_ID": unitId,
// //         "warranty": warranty,
// //         "status": status,
// //         "AddBy": addBy,
// //         "AddTime": addTime,
// //         "UpdateBy": updateBy,
// //         "UpdateTime": updateTime,
// //         "last_update_ip": lastUpdateIp,
// //         "Product_branchid": productBranchid,
// //         "model": model,
// //         "slug": slug,
// //         "short_description": shortDescription,
// //         "long_description": longDescription,
// //         "specification": specification,
// //         "video": video,
// //         "warranty_long_text": warrantyLongText,
// //         "emi_avilable": emiAvilable,
// //         "is_exchange": isExchange,
// //         "is_feature": isFeature,
// //         "is_best_deal": isBestDeal,
// //         "is_best_sallers": isBestSallers,
// //         "new_arrival": newArrival,
// //         "is_offer": isOffer,
// //         "type": type,
// //         "main_image": mainImage,
// //         "alter_image": alterImage,
// //         "main_image_alt": mainImageAlt,
// //         "alter_image_alt": alterImageAlt,
// //         "weight": weight,
// //         "dimensions": dimensions,
// //         "note": note,
// //         "compatibility": compatibility,
// //         "connectivity": connectivity,
// //         "noise_cancellation": noiseCancellation,
// //         "microphone": microphone,
// //         "water_resistance": waterResistance,
// //         "power_output": powerOutput,
// //         "frequency_response": frequencyResponse,
// //         "material": material,
// //         "battery_capacity": batteryCapacity,
// //         "camera": camera,
// //         "network": network,
// //         "processor": processor,
// //         "ram": ram,
// //         "storage": storage,
// //         "display": display,
// //         "battery_life": batteryLife,
// //         "operating_system": operatingSystem,
// //         "ports": ports,
// //         "cable_type": cableType,
// //         "length": length,
// //         "is_draft": isDraft,
// //         "seoTitle": seoTitle,
// //         "seoKeywords": seoKeywords,
// //         "seoDescription": seoDescription,
// //         "storage_id": storageId,
// //         "region_id": regionId,
// //         "sim_id": simId,
// //         "strap_id": strapId,
// //         "network_id": networkId,
// //         "plug_id": plugId,
// //         "size_id": sizeId,
// //         "specification_type_id": specificationTypeId,
// //         "end_date": endDate,
// //         "pre_order": preOrder,
// //         "is_tba": isTba,
// //         "is_call_for_availablity": isCallForAvailablity,
// //         "is_online_order": isOnlineOrder,
// //         "show_on_website": showOnWebsite,
// //         "deleted_by": deletedBy,
// //         "deleted_at": deletedAt,
// //         "created_at": createdAt,
// //     };
// // }










// // import 'dart:convert';

// // class AllProductModel {
// //   final int id;
// //   final int categoryId;
// //   final int brandId;
// //   final String name;
// //   final String slug;
// //   final dynamic model;
// //   final String productCode;
// //   final String keyFeature;
// //   final String description;
// //   final String sellingPrice;
// //   final String discount;
// //   final int quantity;
// //   final String image;
// //   final String ipAddress;
// //   final int popular;
// //   final dynamic featured;
// //   final dynamic specialOffer;
// //   final int status;
// //   final dynamic deletedAt;
// //   final String createdAt;
// //   final String updatedAt;
// //   final String discountPrice;

// //   AllProductModel({
// //     required this.id,
// //     required this.categoryId,
// //     required this.brandId,
// //     required this.name,
// //     required this.slug,
// //     required this.model,
// //     required this.productCode,
// //     required this.keyFeature,
// //     required this.description,
// //     required this.sellingPrice,
// //     required this.discount,
// //     required this.quantity,
// //     required this.image,
// //     required this.ipAddress,
// //     required this.popular,
// //     required this.featured,
// //     required this.specialOffer,
// //     required this.status,
// //     required this.deletedAt,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.discountPrice,
// //   });

// //   factory AllProductModel.fromJson(String str) => AllProductModel.fromMap(json.decode(str));

// //   String toJson() => json.encode(toMap());

// //   factory AllProductModel.fromMap(Map<String, dynamic> json) => AllProductModel(
// //     id: json["id"]??0,
// //     categoryId: json["category_id"]??0,
// //     brandId: json["brand_id"]??0,
// //     name: json["name"]??"",
// //     slug: json["slug"]??"",
// //     model: json["model"],
// //     productCode: json["product_code"]??"",
// //     keyFeature: json["key_feature"]??"",
// //     description: json["description"]??"",
// //     sellingPrice: json["selling_price"]??"",
// //     discount: json["discount"]??"",
// //     quantity: json["quantity"]??0,
// //     image: json["image"]??"",
// //     ipAddress: json["ip_address"]??"",
// //     popular: json["popular"]??0,
// //     featured: json["featured"],
// //     specialOffer: json["special_offer"],
// //     status: json["status"]??0,
// //     deletedAt: json["deleted_at"],
// //     createdAt: json["created_at"]??"",
// //     updatedAt: json["updated_at"]??"",
// //     discountPrice: json["discount_price"]??"",
// //   );

// //   Map<String, dynamic> toMap() => {
// //     "id": id,
// //     "category_id": categoryId,
// //     "brand_id": brandId,
// //     "name": name,
// //     "slug": slug,
// //     "model": model,
// //     "product_code": productCode,
// //     "key_feature": keyFeature,
// //     "description": description,
// //     "selling_price": sellingPrice,
// //     "discount": discount,
// //     "quantity": quantity,
// //     "image": image,
// //     "ip_address": ipAddress,
// //     "popular": popular,
// //     "featured": featured,
// //     "special_offer": specialOffer,
// //     "status": status,
// //     "deleted_at": deletedAt,
// //     "created_at": createdAt,
// //     "updated_at": updatedAt,
// //     "discount_price": discountPrice,
// //   };
// // }
