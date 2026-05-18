class AddToCartModel {
  int? id;
  String? productName;
  int? quantity;
  String? image;
  String? slug;
  double? discountPrice;

  AddToCartModel({
    required this.id,
    required this.productName,
    required this.image,
    required this.quantity,
    required this.slug,
    required this.discountPrice,
  });

  // ==== fromJson factory ====
  factory AddToCartModel.fromJson(Map<String, dynamic> json) {
    return AddToCartModel(
      id: json['id'],
      productName: json['productName'],
      image: json['image'],
      quantity: json['quantity'] ?? 1,
      slug: json['slug'],
      discountPrice: (json['discountPrice'] as num).toDouble(),
    );
  }

  // ==== toJson method ====
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'image': image,
      'quantity': quantity,
      'slug': slug,
      'discountPrice': discountPrice,
    };
  }
}






// class AddToCartModel {
//   int? id;
//   String? productName;
//   //double? salePrice;
//   int? quantity;
//   String? image;
//   String? slug;
//   double? discountPrice;

//   AddToCartModel(
//       {
//         required this.id,
//         required this.productName,
//         required this.image,
//         required this.quantity,
//         //required this.salePrice,
//         required this.slug,
//         required this.discountPrice,
//       }
// );
// }


