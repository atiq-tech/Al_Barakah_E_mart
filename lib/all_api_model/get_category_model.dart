import 'dart:convert';

class GetCategoriesModel {
    final dynamic productCategorySlNo;
    final dynamic productCategoryName;
    final dynamic slug;
    final dynamic productCategoryDescription;
    final dynamic image;
    final dynamic rankId;
    final dynamic status;
    final dynamic addBy;
    final dynamic createdAt;
    final dynamic updateBy;
    final dynamic updatedAt;
    final dynamic deletedBy;
    final dynamic deletedTime;
    final dynamic lastUpdateIp;
    final dynamic branchId;
    final List<SubCategory>? subCategory;

    GetCategoriesModel({
        required this.productCategorySlNo,
        required this.productCategoryName,
        required this.slug,
        required this.productCategoryDescription,
        required this.image,
        required this.rankId,
        required this.status,
        required this.addBy,
        required this.createdAt,
        required this.updateBy,
        required this.updatedAt,
        required this.deletedBy,
        required this.deletedTime,
        required this.lastUpdateIp,
        required this.branchId,
        required this.subCategory,
    });

    factory GetCategoriesModel.fromJson(String str) => GetCategoriesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetCategoriesModel.fromMap(Map<String, dynamic> json) => GetCategoriesModel(
        productCategorySlNo: json["ProductCategory_SlNo"],
        productCategoryName: json["ProductCategory_Name"],
        slug: json["slug"],
        productCategoryDescription: json["ProductCategory_Description"],
        image: json["image"],
        rankId: json["rank_id"],
        status: json["status"],
        addBy: json["AddBy"],
        createdAt: json["created_at"],
        updateBy: json["UpdateBy"],
        updatedAt: json["updated_at"],
        deletedBy: json["DeletedBy"],
        deletedTime: json["DeletedTime"],
        lastUpdateIp: json["last_update_ip"],
        branchId: json["branch_id"],
        subCategory: json["sub_category"] == null || json["sub_category"] == [] ? [] : List<SubCategory>.from(json["sub_category"].map((x) => SubCategory.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ProductCategory_SlNo": productCategorySlNo,
        "ProductCategory_Name": productCategoryName,
        "slug": slug,
        "ProductCategory_Description": productCategoryDescription,
        "image": image,
        "rank_id": rankId,
        "status": status,
        "AddBy": addBy,
        "created_at": createdAt,
        "UpdateBy": updateBy,
        "updated_at": updatedAt,
        "DeletedBy": deletedBy,
        "DeletedTime": deletedTime,
        "last_update_ip": lastUpdateIp,
        "branch_id": branchId,
        "sub_category": List<dynamic>.from(subCategory!.map((x) => x.toJson())),
    };
}

class SubCategory {
    final dynamic id;
    final dynamic categoryId;
    final dynamic name;
    final dynamic slug;
    final dynamic image;
    final dynamic status;
    final dynamic addBy;
    final dynamic createdAt;
    final dynamic updateBy;
    final dynamic updatedAt;
    final dynamic deleteBy;
    final dynamic deleteTime;
    final dynamic lastUpdateIp;
    final dynamic branchId;

    SubCategory({
        required this.id,
        required this.categoryId,
        required this.name,
        required this.slug,
        required this.image,
        required this.status,
        required this.addBy,
        required this.createdAt,
        required this.updateBy,
        required this.updatedAt,
        required this.deleteBy,
        required this.deleteTime,
        required this.lastUpdateIp,
        required this.branchId,
    });

    factory SubCategory.fromJson(String str) => SubCategory.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        status: json["status"],
        addBy: json["add_by"],
        createdAt: json["created_at"],
        updateBy: json["update_by"],
        updatedAt: json["updated_at"],
        deleteBy: json["delete_by"],
        deleteTime: json["delete_time"],
        lastUpdateIp: json["last_update_ip"],
        branchId: json["branch_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "slug": slug,
        "image": image,
        "status": status,
        "add_by": addBy,
        "created_at": createdAt,
        "update_by": updateBy,
        "updated_at": updatedAt,
        "delete_by": deleteBy,
        "delete_time": deleteTime,
        "last_update_ip": lastUpdateIp,
        "branch_id": branchId,
    };
}














// import 'dart:convert';

// class GetCategoriesModel {
//     final dynamic productCategorySlNo;
//     final dynamic parentId;
//     final dynamic productCategoryName;
//     final dynamic slug;
//     final dynamic image;
//     final dynamic isFeature;
//     final dynamic isMenubar;
//     final dynamic imgAlt;
//     final dynamic productCategoryDescription;
//     final dynamic rank;
//     final dynamic status;
//     final dynamic addBy;
//     final dynamic addTime;
//     final dynamic updateBy;
//     final dynamic updateTime;
//     final dynamic deletedAt;
//     final dynamic createdAt;
//     final dynamic updatedAt;
//     final dynamic seoTitle;
//     final dynamic seoDesp;
//     final dynamic seoKey;
//     final dynamic coverImage;
//     final dynamic coverImgAlt;
//     final dynamic categoryBranchid;
//     final List<GetCategoriesModel>? children;

//     GetCategoriesModel({
//         required this.productCategorySlNo,
//         required this.parentId,
//         required this.productCategoryName,
//         required this.slug,
//         required this.image,
//         required this.isFeature,
//         required this.isMenubar,
//         required this.imgAlt,
//         required this.productCategoryDescription,
//         required this.rank,
//         required this.status,
//         required this.addBy,
//         required this.addTime,
//         required this.updateBy,
//         required this.updateTime,
//         required this.deletedAt,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.seoTitle,
//         required this.seoDesp,
//         required this.seoKey,
//         required this.coverImage,
//         required this.coverImgAlt,
//         required this.categoryBranchid,
//         required this.children,
//     });

//     factory GetCategoriesModel.fromJson(String str) => GetCategoriesModel.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory GetCategoriesModel.fromMap(Map<String, dynamic> json) => GetCategoriesModel(
//         productCategorySlNo: json["ProductCategory_SlNo"],
//         parentId: json["parent_id"],
//         productCategoryName: json["ProductCategory_Name"],
//         slug: json["slug"],
//         image: json["image"],
//         isFeature: json["is_feature"],
//         isMenubar: json["is_menubar"],
//         imgAlt: json["imgAlt"],
//         productCategoryDescription: json["ProductCategory_Description"],
//         rank: json["rank"],
//         status: json["status"],
//         addBy: json["AddBy"],
//         addTime: json["AddTime"],
//         updateBy: json["UpdateBy"],
//         updateTime: json["UpdateTime"],
//         deletedAt: json["deleted_at"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         seoTitle: json["seoTitle"],
//         seoDesp: json["seoDesp"],
//         seoKey: json["seoKey"],
//         coverImage: json["coverImage"],
//         coverImgAlt: json["coverImgAlt"],
//         categoryBranchid: json["category_branchid"],
//         children: json["children"]== null || json["children"] == [] ? [] : List<GetCategoriesModel>.from(json["children"].map((x) => GetCategoriesModel.fromMap(x))),
//     );

//     Map<String, dynamic> toMap() => {
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
//         "children": List<dynamic>.from(children!.map((x) => x.toJson())),
//     };
// }

