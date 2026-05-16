import 'dart:convert';

class GetBrandsModel {
    final dynamic brandSiNo;
    final dynamic productCategorySlNo;
    final dynamic brandName;
    final dynamic status;
    final dynamic brandBranchid;
    final dynamic slug;
    final dynamic image;
    final dynamic topBrand;
    final dynamic shopBrand;
    final dynamic imgAlt;
    final dynamic sort;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic seoTitle;
    final dynamic seoDesp;
    final dynamic seoKey;
    final dynamic coverimage;
    final dynamic coverimgAlt;
    final dynamic description;

    GetBrandsModel({
        required this.brandSiNo,
        required this.productCategorySlNo,
        required this.brandName,
        required this.status,
        required this.brandBranchid,
        required this.slug,
        required this.image,
        required this.topBrand,
        required this.shopBrand,
        required this.imgAlt,
        required this.sort,
        required this.createdAt,
        required this.updatedAt,
        required this.seoTitle,
        required this.seoDesp,
        required this.seoKey,
        required this.coverimage,
        required this.coverimgAlt,
        required this.description,
    });

    factory GetBrandsModel.fromJson(String str) => GetBrandsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetBrandsModel.fromMap(Map<String, dynamic> json) => GetBrandsModel(
        brandSiNo: json["brand_SiNo"],
        productCategorySlNo: json["ProductCategory_SlNo"],
        brandName: json["brand_name"],
        status: json["status"],
        brandBranchid: json["brand_branchid"],
        slug: json["slug"],
        image: json["image"],
        topBrand: json["top_brand"],
        shopBrand: json["shop_brand"],
        imgAlt: json["imgAlt"],
        sort: json["sort"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        seoTitle: json["seoTitle"],
        seoDesp: json["seoDesp"],
        seoKey: json["seoKey"],
        coverimage: json["coverimage"],
        coverimgAlt: json["coverimgAlt"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "brand_SiNo": brandSiNo,
        "ProductCategory_SlNo": productCategorySlNo,
        "brand_name": brandName,
        "status": status,
        "brand_branchid": brandBranchid,
        "slug": slug,
        "image": image,
        "top_brand": topBrand,
        "shop_brand": shopBrand,
        "imgAlt": imgAlt,
        "sort": sort,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "seoTitle": seoTitle,
        "seoDesp": seoDesp,
        "seoKey": seoKey,
        "coverimage": coverimage,
        "coverimgAlt": coverimgAlt,
        "description": description,
    };
}

















// import 'dart:convert';

// class GetBrandsModel {
//   final int id;
//   final String name;
//   final String image;
//   final dynamic deletedAt;
//   final String createdAt;
//   final String updatedAt;

//   GetBrandsModel({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory GetBrandsModel.fromJson(String str) => GetBrandsModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory GetBrandsModel.fromMap(Map<String, dynamic> json) => GetBrandsModel(
//     id: json["id"]??0,
//     name: json["name"]??"",
//     image: json["image"]??"",
//     deletedAt: json["deleted_at"],
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//   );

//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "name": name,
//     "image": image,
//     "deleted_at": deletedAt,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
