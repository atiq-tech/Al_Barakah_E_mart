part of 'product.dart';
class ProductDetailsAdapter extends TypeAdapter<ProductDetails> {
  @override
  final int typeId = 1;

  @override
  ProductDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDetails(
      productName: fields[0] as String?,
      productPrice: fields[1] as double?,
      productQuantity: fields[2] as int?,
      productImage: fields[3] as String?,
      product_id: fields[4] as String?,
      size_id: fields[6] as String?,
      color_id: fields[5] as String?,
      main_price: fields[7] as double?,
      cashback_percent: fields[8] as String?,
      slug: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductDetails obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.productPrice)
      ..writeByte(2)
      ..write(obj.productQuantity)
      ..writeByte(3)
      ..write(obj.productImage)
      ..writeByte(4)
      ..write(obj.product_id)
      ..writeByte(5)
      ..write(obj.color_id)
      ..writeByte(6)
      ..write(obj.size_id)
      ..writeByte(7)
      ..write(obj.main_price)
      ..writeByte(8)
      ..write(obj.cashback_percent)
      ..writeByte(9)
      ..write(obj.slug);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
