class Api_Model_Product_Collor {
  String? _id;
  String? _productId;
  String? _colorId;
  String? _image1;
  String? _image2;
  String? _image3;
  String? _image4;
  String? _productCode;
  String? _productName;
  String? _colorName;
  String? _colorCode;

  Api_Model_Product_Collor(
      {String? id,
        String? productId,
        String? colorId,
        String? image1,
        String? image2,
        String? image3,
        String? image4,
        String? productCode,
        String? productName,
        String? colorName,
        String? colorCode}) {
    if (id != null) {
      _id = id;
    }
    if (productId != null) {
      _productId = productId;
    }
    if (colorId != null) {
      _colorId = colorId;
    }
    if (image1 != null) {
      _image1 = image1;
    }
    if (image2 != null) {
      _image2 = image2;
    }
    if (image3 != null) {
      _image3 = image3;
    }
    if (image4 != null) {
      _image4 = image4;
    }
    if (productCode != null) {
      _productCode = productCode;
    }
    if (productName != null) {
      _productName = productName;
    }
    if (colorName != null) {
      _colorName = colorName;
    }
    if (colorCode != null) {
      _colorCode = colorCode;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get productId => _productId;
  set productId(String? productId) => _productId = productId;
  String? get colorId => _colorId;
  set colorId(String? colorId) => _colorId = colorId;
  String? get image1 => _image1;
  set image1(String? image1) => _image1 = image1;
  String? get image2 => _image2;
  set image2(String? image2) => _image2 = image2;
  String? get image3 => _image3;
  set image3(String? image3) => _image3 = image3;
  String? get image4 => _image4;
  set image4(String? image4) => _image4 = image4;
  String? get productCode => _productCode;
  set productCode(String? productCode) => _productCode = productCode;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  String? get colorName => _colorName;
  set colorName(String? colorName) => _colorName = colorName;
  String? get colorCode => _colorCode;
  set colorCode(String? colorCode) => _colorCode = colorCode;

  Api_Model_Product_Collor.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _colorId = json['color_id'];
    _image1 = json['image_1'];
    _image2 = json['image_2'];
    _image3 = json['image_3'];
    _image4 = json['image_4'];
    _productCode = json['Product_Code'];
    _productName = json['Product_Name'];
    _colorName = json['color_name'];
    _colorCode = json['color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['product_id'] = _productId;
    data['color_id'] = _colorId;
    data['image_1'] = _image1;
    data['image_2'] = _image2;
    data['image_3'] = _image3;
    data['image_4'] = _image4;
    data['Product_Code'] = _productCode;
    data['Product_Name'] = _productName;
    data['color_name'] = _colorName;
    data['color_code'] = _colorCode;
    return data;
  }
}
