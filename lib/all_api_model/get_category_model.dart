import 'dart:convert';

class GetCategoriesModel {
    final dynamic productCategorySlNo;
    final dynamic parentId;
    final dynamic productCategoryName;
    final dynamic slug;
    final dynamic image;
    final dynamic isFeature;
    final dynamic isMenubar;
    final dynamic imgAlt;
    final dynamic productCategoryDescription;
    final dynamic rank;
    final dynamic status;
    final dynamic addBy;
    final dynamic addTime;
    final dynamic updateBy;
    final dynamic updateTime;
    final dynamic deletedAt;
    final dynamic createdAt;
    final dynamic updatedAt;
    final dynamic seoTitle;
    final dynamic seoDesp;
    final dynamic seoKey;
    final dynamic coverImage;
    final dynamic coverImgAlt;
    final dynamic categoryBranchid;
    final List<GetCategoriesModel>? children;

    GetCategoriesModel({
        required this.productCategorySlNo,
        required this.parentId,
        required this.productCategoryName,
        required this.slug,
        required this.image,
        required this.isFeature,
        required this.isMenubar,
        required this.imgAlt,
        required this.productCategoryDescription,
        required this.rank,
        required this.status,
        required this.addBy,
        required this.addTime,
        required this.updateBy,
        required this.updateTime,
        required this.deletedAt,
        required this.createdAt,
        required this.updatedAt,
        required this.seoTitle,
        required this.seoDesp,
        required this.seoKey,
        required this.coverImage,
        required this.coverImgAlt,
        required this.categoryBranchid,
        required this.children,
    });

    factory GetCategoriesModel.fromJson(String str) => GetCategoriesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetCategoriesModel.fromMap(Map<String, dynamic> json) => GetCategoriesModel(
        productCategorySlNo: json["ProductCategory_SlNo"],
        parentId: json["parent_id"],
        productCategoryName: json["ProductCategory_Name"],
        slug: json["slug"],
        image: json["image"],
        isFeature: json["is_feature"],
        isMenubar: json["is_menubar"],
        imgAlt: json["imgAlt"],
        productCategoryDescription: json["ProductCategory_Description"],
        rank: json["rank"],
        status: json["status"],
        addBy: json["AddBy"],
        addTime: json["AddTime"],
        updateBy: json["UpdateBy"],
        updateTime: json["UpdateTime"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        seoTitle: json["seoTitle"],
        seoDesp: json["seoDesp"],
        seoKey: json["seoKey"],
        coverImage: json["coverImage"],
        coverImgAlt: json["coverImgAlt"],
        categoryBranchid: json["category_branchid"],
        children: json["children"]== null || json["children"] == [] ? [] : List<GetCategoriesModel>.from(json["children"].map((x) => GetCategoriesModel.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ProductCategory_SlNo": productCategorySlNo,
        "parent_id": parentId,
        "ProductCategory_Name": productCategoryName,
        "slug": slug,
        "image": image,
        "is_feature": isFeature,
        "is_menubar": isMenubar,
        "imgAlt": imgAlt,
        "ProductCategory_Description": productCategoryDescription,
        "rank": rank,
        "status": status,
        "AddBy": addBy,
        "AddTime": addTime,
        "UpdateBy": updateBy,
        "UpdateTime": updateTime,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "seoTitle": seoTitle,
        "seoDesp": seoDesp,
        "seoKey": seoKey,
        "coverImage": coverImage,
        "coverImgAlt": coverImgAlt,
        "category_branchid": categoryBranchid,
        "children": List<dynamic>.from(children!.map((x) => x.toJson())),
    };
}











// import 'dart:convert';

// class GetCategoriesModel {
//   final int id;
//   final int parentId;
//   final String name;
//   final String slug;
//   final dynamic description;
//   final String image;
//   final int createdBy;
//   final String ipAddress;
//   final dynamic deletedAt;
//   final String createdAt;
//   final String updatedAt;
//   final int productsCount;

//   GetCategoriesModel({
//     required this.id,
//     required this.parentId,
//     required this.name,
//     required this.slug,
//     required this.description,
//     required this.image,
//     required this.createdBy,
//     required this.ipAddress,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.productsCount,
//   });

//   factory GetCategoriesModel.fromJson(String str) => GetCategoriesModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory GetCategoriesModel.fromMap(Map<String, dynamic> json) => GetCategoriesModel(
//     id: json["id"]??0,
//     parentId: json["parent_id"]??0,
//     name: json["name"]??"",
//     slug: json["slug"]??"",
//     description: json["description"],
//     image: json["image"]??"",
//     createdBy: json["created_by"]??0,
//     ipAddress: json["ip_address"]??"",
//     deletedAt: json["deleted_at"],
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//     productsCount: json["products_count"]??0
//   );

//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "parent_id": parentId,
//     "name": name,
//     "slug": slug,
//     "description": description,
//     "image": image,
//     "created_by": createdBy,
//     "ip_address": ipAddress,
//     "deleted_at": deletedAt,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "products_count": productsCount,
//   };
// }
