import 'dart:convert';

class ProductDetailsModel {
  final Product? product;
  final List<Product> relatedProducts;

  ProductDetailsModel({required this.product, required this.relatedProducts});

  factory ProductDetailsModel.fromJson(String str) =>
      ProductDetailsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailsModel.fromMap(Map<String, dynamic> json) {
    final productsData = json["products"] ?? json["product"];
    final relatedData = json["relatedProducts"] ?? json["related_products"];

    return ProductDetailsModel(
      product: _parseProduct(productsData),
      relatedProducts: _parseProductList(relatedData),
    );
  }

  Map<String, dynamic> toMap() => {
    "products": product == null ? [] : [product!.toMap()],
    "relatedProducts": relatedProducts.map((x) => x.toMap()).toList(),
  };

  static Product? _parseProduct(dynamic data) {
    if (data == null) return null;
    if (data is List) {
      if (data.isEmpty) return null;
      final first = data.first;
      return first is Map<String, dynamic> ? Product.fromMap(first) : null;
    }
    if (data is Map<String, dynamic>) return Product.fromMap(data);
    return null;
  }

  static List<Product> _parseProductList(dynamic data) {
    if (data == null || data is! List) return [];
    return data
        .whereType<Map<String, dynamic>>()
        .map((x) => Product.fromMap(x))
        .toList();
  }
}

class Product {
  final dynamic productSlNo;
  final dynamic supplierId;
  final dynamic productType;
  final dynamic productCode;
  final dynamic productName;
  final dynamic slug;
  final dynamic productCategoryId;
  final dynamic subCategoryId;
  final dynamic companyId;
  final dynamic color;
  final dynamic brand;
  final dynamic size;
  final dynamic shortDescription;
  final dynamic productDescription;
  final dynamic vat;
  final dynamic productReOrederLevel;
  final dynamic productPurchaseRate;
  final dynamic productSellingPrice;
  final dynamic productMinimumSellingPrice;
  final dynamic productWholesaleRate;
  final dynamic oneCartonToPcs;
  final dynamic quantity;
  final dynamic discount;
  final dynamic sd;
  final dynamic productImage;
  final dynamic thumImage;
  final dynamic isService;
  final dynamic isFeatured;
  final dynamic isOffer;
  final dynamic isArrival;
  final dynamic isPopular;
  final dynamic isWebsite;
  final dynamic unitId;
  final dynamic status;
  final dynamic addBy;
  final dynamic createdAt;
  final dynamic updateBy;
  final dynamic updatedAt;
  final dynamic deletedBy;
  final dynamic deletedTime;
  final dynamic lastUpdateIp;
  final dynamic branchId;
  final dynamic discountPriceValue;
  final dynamic stock;
  final Category? category;
  final List<MultipleImg> productImages;

  Product({
    this.productSlNo,
    this.supplierId,
    this.productType,
    this.productCode,
    this.productName,
    this.slug,
    this.productCategoryId,
    this.subCategoryId,
    this.companyId,
    this.color,
    this.brand,
    this.size,
    this.shortDescription,
    this.productDescription,
    this.vat,
    this.productReOrederLevel,
    this.productPurchaseRate,
    this.productSellingPrice,
    this.productMinimumSellingPrice,
    this.productWholesaleRate,
    this.oneCartonToPcs,
    this.quantity,
    this.discount,
    this.sd,
    this.productImage,
    this.thumImage,
    this.isService,
    this.isFeatured,
    this.isOffer,
    this.isArrival,
    this.isPopular,
    this.isWebsite,
    this.unitId,
    this.status,
    this.addBy,
    this.createdAt,
    this.updateBy,
    this.updatedAt,
    this.deletedBy,
    this.deletedTime,
    this.lastUpdateIp,
    this.branchId,
    this.discountPriceValue,
    this.stock,
    this.category,
    required this.productImages,
  });

  String? get mainImage => productImage?.toString();
  String? get alterImage => thumImage?.toString();
  String get longDescription => productDescription?.toString() ?? "";
  String get discountPrice =>
      discountPriceValue?.toString() ?? productSellingPrice?.toString() ?? "0";
  String get sellingPrice => productSellingPrice?.toString() ?? "";
  List<MultipleImg> get multipleImg => productImages;

  int getCurrentStock() {
    final value = stock;
    if (value is int) return value < 0 ? 0 : value;
    return int.tryParse(value?.toString() ?? "0") ?? 0;
  }

  String get stockStatus =>
      getCurrentStock() == 0 ? "Out of Stock" : "In Stock";

  bool checkHasDiscount(dynamic startDateStr, dynamic endDateStr) => false;
  bool get hasDiscount => false;
  double get finalPrice => double.tryParse(discountPrice) ?? 0;

  dynamic get onlineAfterDiscountAmount => discountPriceValue;
  dynamic get productOnlineRate => productSellingPrice;
  dynamic get onlineDiscount => discount;
  dynamic get startDate => null;
  dynamic get endDate => null;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    productSlNo: json["Product_SlNo"],
    supplierId: json["supplier_id"],
    productType: json["Product_Type"],
    productCode: json["Product_Code"]?.toString(),
    productName: json["Product_Name"]?.toString() ?? "",
    slug: json["slug"]?.toString() ?? "",
    productCategoryId: json["ProductCategory_ID"],
    subCategoryId: json["sub_category_id"],
    companyId: json["company_id"],
    color: json["color"],
    brand: json["brand"],
    size: json["size"],
    shortDescription: json["short_description"]?.toString() ?? "",
    productDescription:
        json["Product_description"]?.toString() ??
        json["long_description"]?.toString() ??
        "",
    vat: json["vat"],
    productReOrederLevel: json["Product_ReOrederLevel"],
    productPurchaseRate: json["Product_Purchase_Rate"],
    productSellingPrice: json["Product_SellingPrice"],
    productMinimumSellingPrice: json["Product_MinimumSellingPrice"],
    productWholesaleRate: json["Product_WholesaleRate"],
    oneCartonToPcs: json["one_carton_to_pcs"],
    quantity: json["quantity"],
    discount: json["discount"],
    sd: json["sd"],
    productImage: json["Product_Image"] ?? json["main_image"],
    thumImage: json["thum_image"] ?? json["alter_image"],
    isService: json["is_service"],
    isFeatured: json["is_featured"],
    isOffer: json["is_offer"],
    isArrival: json["is_arrival"],
    isPopular: json["is_popular"],
    isWebsite: json["is_website"],
    unitId: json["Unit_ID"],
    status: json["status"],
    addBy: json["AddBy"],
    createdAt: json["created_at"],
    updateBy: json["UpdateBy"],
    updatedAt: json["updated_at"],
    deletedBy: json["DeletedBy"],
    deletedTime: json["DeletedTime"],
    lastUpdateIp: json["last_update_ip"],
    branchId: json["branch_id"],
    discountPriceValue: json["discount_price"],
    stock: json["stock"],
    category: json["category"] == null
        ? null
        : Category.fromMap(json["category"]),
    productImages: json["product_images"] == null
        ? []
        : List<MultipleImg>.from(
            (json["product_images"] as List).map((x) => MultipleImg.fromMap(x)),
          ),
  );

  Map<String, dynamic> toMap() => {
    "Product_SlNo": productSlNo,
    "supplier_id": supplierId,
    "Product_Type": productType,
    "Product_Code": productCode,
    "Product_Name": productName,
    "slug": slug,
    "ProductCategory_ID": productCategoryId,
    "sub_category_id": subCategoryId,
    "company_id": companyId,
    "color": color,
    "brand": brand,
    "size": size,
    "short_description": shortDescription,
    "Product_description": productDescription,
    "vat": vat,
    "Product_ReOrederLevel": productReOrederLevel,
    "Product_Purchase_Rate": productPurchaseRate,
    "Product_SellingPrice": productSellingPrice,
    "Product_MinimumSellingPrice": productMinimumSellingPrice,
    "Product_WholesaleRate": productWholesaleRate,
    "one_carton_to_pcs": oneCartonToPcs,
    "quantity": quantity,
    "discount": discount,
    "sd": sd,
    "Product_Image": productImage,
    "thum_image": thumImage,
    "is_service": isService,
    "is_featured": isFeatured,
    "is_offer": isOffer,
    "is_arrival": isArrival,
    "is_popular": isPopular,
    "is_website": isWebsite,
    "Unit_ID": unitId,
    "status": status,
    "AddBy": addBy,
    "created_at": createdAt,
    "UpdateBy": updateBy,
    "updated_at": updatedAt,
    "DeletedBy": deletedBy,
    "DeletedTime": deletedTime,
    "last_update_ip": lastUpdateIp,
    "branch_id": branchId,
    "discount_price": discountPriceValue,
    "stock": stock,
    "category": category?.toMap(),
    "product_images": productImages.map((x) => x.toMap()).toList(),
  };
}

class Category {
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

  Category({
    this.productCategorySlNo,
    this.productCategoryName,
    this.slug,
    this.productCategoryDescription,
    this.image,
    this.rankId,
    this.status,
    this.addBy,
    this.createdAt,
    this.updateBy,
    this.updatedAt,
    this.deletedBy,
    this.deletedTime,
    this.lastUpdateIp,
    this.branchId,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    productCategorySlNo: json["ProductCategory_SlNo"],
    productCategoryName: json["ProductCategory_Name"]?.toString(),
    slug: json["slug"]?.toString(),
    productCategoryDescription: json["ProductCategory_Description"]?.toString(),
    image: json["image"]?.toString(),
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
  };
}

class MultipleImg {
  final dynamic id;
  final dynamic productId;
  final String? image;
  final dynamic createdAt;
  final dynamic updatedAt;

  MultipleImg({
    this.id,
    this.productId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory MultipleImg.fromMap(Map<String, dynamic> json) => MultipleImg(
    id: json["id"],
    productId: json["product_id"],
    image: json["image"]?.toString(),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "product_id": productId,
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
