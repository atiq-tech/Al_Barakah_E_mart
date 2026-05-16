import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class ProductDetails {
  @HiveField(0)
  final String? productName;

  @HiveField(1)
  final double? productPrice;

  @HiveField(2)
  int? productQuantity;

  @HiveField(3)
  String? productImage;

//new values
  @HiveField(4)
  String? product_id;

  @HiveField(5)
  String? color_id;

  @HiveField(6)
  String? size_id;

  @HiveField(7)
  double? main_price;

  @HiveField(8)
  String? cashback_percent;

  @HiveField(8)
  String? slug;

  ProductDetails({
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.productImage,
    required this.product_id,
    required this.size_id,
    required this.color_id,
    required this.main_price,
    required this.cashback_percent,
    required this.slug,
  });
}
