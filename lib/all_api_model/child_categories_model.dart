import 'dart:convert';

class ChildCategoriesModel {
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
    final List<dynamic> products;
    final dynamic parents;
    final List<ChildCategoriesModel> children;

    ChildCategoriesModel({
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
        required this.products,
        required this.parents,
        required this.children,
    });

    factory ChildCategoriesModel.fromJson(String str) => ChildCategoriesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ChildCategoriesModel.fromMap(Map<String, dynamic> json) => ChildCategoriesModel(
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
        products: json["products"] == null || json["products"] == [] ? [] : List<dynamic>.from(json["products"].map((x) => x)),
        parents: json["parents"],
        children: json["children"] == null || json["children"] == [] ? [] : List<ChildCategoriesModel>.from(json["children"].map((x) => ChildCategoriesModel.fromMap(x))),
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
        "products": List<dynamic>.from(products.map((x) => x)),
        "parents": parents,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
    };
}






















// import 'dart:convert';

// class ChildCategoriesModel {
//   final List<Category> categories;
//   final List<Product> products;

//   ChildCategoriesModel({
//     required this.categories,
//     required this.products,
//   });

//   factory ChildCategoriesModel.fromJson(String str) => ChildCategoriesModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory ChildCategoriesModel.fromMap(Map<String, dynamic> json) => ChildCategoriesModel(
//     categories: json["categories"] == null || json["categories"] == [] ? [] : List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
//     products: json["products"] == null || json["products"] == [] ? [] : List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
//   );

//   Map<String, dynamic> toMap() => {
//     "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
//     "products": List<dynamic>.from(products.map((x) => x.toMap())),
//   };
// }

// class Category {
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

//   Category({
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

//   factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Category.fromMap(Map<String, dynamic> json) => Category(
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
//     productsCount: json["products_count"]??0,
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

// class Product {
//   final int id;
//   final int categoryId;
//   final int brandId;
//   final String name;
//   final String slug;
//   final dynamic model;
//   final String productCode;
//   final String keyFeature;
//   final dynamic description;
//   final String sellingPrice;
//   final String discount;
//   final int quantity;
//   final String image;
//   final String ipAddress;
//   final dynamic popular;
//   final dynamic featured;
//   final int specialOffer;
//   final int status;
//   final dynamic deletedAt;
//   final String createdAt;
//   final String updatedAt;
//   final String discountPrice;

//   Product({
//     required this.id,
//     required this.categoryId,
//     required this.brandId,
//     required this.name,
//     required this.slug,
//     required this.model,
//     required this.productCode,
//     required this.keyFeature,
//     required this.description,
//     required this.sellingPrice,
//     required this.discount,
//     required this.quantity,
//     required this.image,
//     required this.ipAddress,
//     required this.popular,
//     required this.featured,
//     required this.specialOffer,
//     required this.status,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.discountPrice,
//   });

//   factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Product.fromMap(Map<String, dynamic> json) => Product(
//     id: json["id"]??0,
//     categoryId: json["category_id"]??0,
//     brandId: json["brand_id"]??0,
//     name: json["name"]??"",
//     slug: json["slug"]??"",
//     model: json["model"],
//     productCode: json["product_code"]??"",
//     keyFeature: json["key_feature"]??"",
//     description: json["description"],
//     sellingPrice: json["selling_price"]??"",
//     discount: json["discount"]??"",
//     quantity: json["quantity"]??0,
//     image: json["image"]??"",
//     ipAddress: json["ip_address"]??"",
//     popular: json["popular"],
//     featured: json["featured"],
//     specialOffer: json["special_offer"]??0,
//     status: json["status"]??0,
//     deletedAt: json["deleted_at"],
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//     discountPrice: json["discount_price"]??"",
//   );

//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "category_id": categoryId,
//     "brand_id": brandId,
//     "name": name,
//     "slug": slug,
//     "model": model,
//     "product_code": productCode,
//     "key_feature": keyFeature,
//     "description": description,
//     "selling_price": sellingPrice,
//     "discount": discount,
//     "quantity": quantity,
//     "image": image,
//     "ip_address": ipAddress,
//     "popular": popular,
//     "featured": featured,
//     "special_offer": specialOffer,
//     "status": status,
//     "deleted_at": deletedAt,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "discount_price": discountPrice,
//   };
// }




// import 'dart:convert';
//
// class ChildCategoriesModel {
//   final List<Category> categories;
//   final List<Product> products;
//
//   ChildCategoriesModel({
//     required this.categories,
//     required this.products,
//   });
//
//   factory ChildCategoriesModel.fromJson(String str) => ChildCategoriesModel.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory ChildCategoriesModel.fromMap(Map<String, dynamic> json) => ChildCategoriesModel(
//     categories: json["categories"] == null|| json["categories"] == [] ? [] : List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
//     products: json["products"] == null|| json["products"] == [] ? [] : List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "categories": List<dynamic>.from(categories.map((x) => x.toMap())),
//     "products": List<dynamic>.from(products.map((x) => x.toMap())),
//   };
// }
//
// class Category {
//   final int id;
//   final String parentId;
//   final String name;
//   final String slug;
//   final dynamic description;
//   final String image;
//   final String createdBy;
//   final String ipAddress;
//   final dynamic deletedAt;
//   final String createdAt;
//   final String updatedAt;
//   final String productsCount;
//
//   Category({
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
//
//   factory Category.fromJson(String str) => Category.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Category.fromMap(Map<String, dynamic> json) => Category(
//     id: json["id"]??0,
//     parentId: json["parent_id"]??"",
//     name: json["name"]??"",
//     slug: json["slug"]??"",
//     description: json["description"],
//     image: json["image"]??"",
//     createdBy: json["created_by"]??"",
//     ipAddress: json["ip_address"]??"",
//     deletedAt: json["deleted_at"],
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//     productsCount: json["products_count"]??"",
//   );
//
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
//
// class Product {
//   final int id;
//   final String categoryId;
//   final String brandId;
//   final String name;
//   final String slug;
//   final dynamic model;
//   final String productCode;
//   final String keyFeature;
//   final dynamic description;
//   final String sellingPrice;
//   final String discount;
//   final String quantity;
//   final String image;
//   final String ipAddress;
//   final String popular;
//   final dynamic featured;
//   final dynamic specialOffer;
//   final String status;
//   final dynamic deletedAt;
//   final String createdAt;
//   final String updatedAt;
//   final String discountPrice;
//
//   Product({
//     required this.id,
//     required this.categoryId,
//     required this.brandId,
//     required this.name,
//     required this.slug,
//     required this.model,
//     required this.productCode,
//     required this.keyFeature,
//     required this.description,
//     required this.sellingPrice,
//     required this.discount,
//     required this.quantity,
//     required this.image,
//     required this.ipAddress,
//     required this.popular,
//     required this.featured,
//     required this.specialOffer,
//     required this.status,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.discountPrice,
//   });
//
//   factory Product.fromJson(String str) => Product.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory Product.fromMap(Map<String, dynamic> json) => Product(
//     id: json["id"]??0,
//     categoryId: json["category_id"]??"",
//     brandId: json["brand_id"]??"",
//     name: json["name"]??"",
//     slug: json["slug"]??"",
//     model: json["model"],
//     productCode: json["product_code"]??"",
//     keyFeature: json["key_feature"]??"",
//     description: json["description"],
//     sellingPrice: json["selling_price"]??"",
//     discount: json["discount"]??"",
//     quantity: json["quantity"]??"",
//     image: json["image"]??"",
//     ipAddress: json["ip_address"]??"",
//     popular: json["popular"]??"",
//     featured: json["featured"],
//     specialOffer: json["special_offer"],
//     status: json["status"]??"",
//     deletedAt: json["deleted_at"],
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//     discountPrice: json["discount_price"]??"",
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "category_id": categoryId,
//     "brand_id": brandId,
//     "name": name,
//     "slug": slug,
//     "model": model,
//     "product_code": productCode,
//     "key_feature": keyFeature,
//     "description": description,
//     "selling_price": sellingPrice,
//     "discount": discount,
//     "quantity": quantity,
//     "image": image,
//     "ip_address": ipAddress,
//     "popular": popular,
//     "featured": featured,
//     "special_offer": specialOffer,
//     "status": status,
//     "deleted_at": deletedAt,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "discount_price": discountPrice,
//   };
// }
