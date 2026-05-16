import 'dart:convert';

class GetWishListModel {
  final int id;
  final int customerId;
  final int productId;
  final String createdAt;
  final String updatedAt;
  final Product product;

  GetWishListModel({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory GetWishListModel.fromJson(String str) => GetWishListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetWishListModel.fromMap(Map<String, dynamic> json) => GetWishListModel(
    id: json["id"]??0,
    customerId: json["customer_id"]??0,
    productId: json["product_id"]??0,
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    product: Product.fromMap(json["product"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customer_id": customerId,
    "product_id": productId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "product": product.toMap(),
  };
}

class Product {
  final int id;
  final int categoryId;
  final int brandId;
  final String name;
  final String slug;
  final dynamic model;
  final String productCode;
  final String keyFeature;
  final dynamic description;
  final String sellingPrice;
  final String discount;
  final int quantity;
  final String image;
  final String ipAddress;
  final int popular;
  final dynamic featured;
  final dynamic specialOffer;
  final int status;
  final dynamic deletedAt;
  final String createdAt;
  final String updatedAt;
  final String discountPrice;

  Product({
    required this.id,
    required this.categoryId,
    required this.brandId,
    required this.name,
    required this.slug,
    required this.model,
    required this.productCode,
    required this.keyFeature,
    required this.description,
    required this.sellingPrice,
    required this.discount,
    required this.quantity,
    required this.image,
    required this.ipAddress,
    required this.popular,
    required this.featured,
    required this.specialOffer,
    required this.status,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.discountPrice,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"]??0,
    categoryId: json["category_id"]??0,
    brandId: json["brand_id"]??0,
    name: json["name"]??"",
    slug: json["slug"]??"",
    model: json["model"],
    productCode: json["product_code"]??"",
    keyFeature: json["key_feature"]??"",
    description: json["description"],
    sellingPrice: json["selling_price"]??"",
    discount: json["discount"]??"",
    quantity: json["quantity"]??0,
    image: json["image"]??"",
    ipAddress: json["ip_address"]??"",
    popular: json["popular"]??0,
    featured: json["featured"],
    specialOffer: json["special_offer"],
    status: json["status"]??0,
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
    discountPrice: json["discount_price"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "category_id": categoryId,
    "brand_id": brandId,
    "name": name,
    "slug": slug,
    "model": model,
    "product_code": productCode,
    "key_feature": keyFeature,
    "description": description,
    "selling_price": sellingPrice,
    "discount": discount,
    "quantity": quantity,
    "image": image,
    "ip_address": ipAddress,
    "popular": popular,
    "featured": featured,
    "special_offer": specialOffer,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "discount_price": discountPrice,
  };
}




// import 'dart:convert';
//
// class GetWishListModel {
//   final int id;
//   final String customerId;
//   final String productId;
//   final String createdAt;
//   final String updatedAt;
//   final Product product;
//
//   GetWishListModel({
//     required this.id,
//     required this.customerId,
//     required this.productId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.product,
//   });
//
//   factory GetWishListModel.fromJson(String str) => GetWishListModel.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory GetWishListModel.fromMap(Map<String, dynamic> json) => GetWishListModel(
//     id: json["id"]??0,
//     customerId: json["customer_id"]??"",
//     productId: json["product_id"]??"",
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//     product: Product.fromMap(json["product"]),
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "customer_id": customerId,
//     "product_id": productId,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "product": product.toMap(),
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
//   final String description;
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
//     description: json["description"]??"",
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
//     discountPrice: json["discount_price"],
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
