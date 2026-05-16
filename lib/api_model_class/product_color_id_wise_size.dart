class Product_Color_id_wise_size_Model_Class {
  String? _id;
  String? _productId;
  String? _colorId;
  String? _sizeId;
  String? _purchaseRate;
  String? _salePrice;
  String? _mainPrice;
  String? _cashbackPercent;
  String? _cashbackAmount;
  String? _reorderLevel;
  String? _sizeSiNo;
  String? _sizeName;
  String? _status;
  String? _sizeBranchid;

  Product_Color_id_wise_size_Model_Class(
      {String? id,
        String? productId,
        String? colorId,
        String? sizeId,
        String? purchaseRate,
        String? salePrice,
        String? mainPrice,
        String? cashbackPercent,
        String? cashbackAmount,
        String? reorderLevel,
        String? sizeSiNo,
        String? sizeName,
        String? status,
        String? sizeBranchid}) {
    if (id != null) {
      _id = id;
    }
    if (productId != null) {
      _productId = productId;
    }
    if (colorId != null) {
      _colorId = colorId;
    }
    if (sizeId != null) {
      _sizeId = sizeId;
    }
    if (purchaseRate != null) {
      _purchaseRate = purchaseRate;
    }
    if (salePrice != null) {
      _salePrice = salePrice;
    }
    if (mainPrice != null) {
      _mainPrice = mainPrice;
    }
    if (cashbackPercent != null) {
      _cashbackPercent = cashbackPercent;
    }
    if (cashbackAmount != null) {
      _cashbackAmount = cashbackAmount;
    }
    if (reorderLevel != null) {
      _reorderLevel = reorderLevel;
    }
    if (sizeSiNo != null) {
      _sizeSiNo = sizeSiNo;
    }
    if (sizeName != null) {
      _sizeName = sizeName;
    }
    if (status != null) {
      _status = status;
    }
    if (sizeBranchid != null) {
      _sizeBranchid = sizeBranchid;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get productId => _productId;
  set productId(String? productId) => _productId = productId;
  String? get colorId => _colorId;
  set colorId(String? colorId) => _colorId = colorId;
  String? get sizeId => _sizeId;
  set sizeId(String? sizeId) => _sizeId = sizeId;
  String? get purchaseRate => _purchaseRate;
  set purchaseRate(String? purchaseRate) => _purchaseRate = purchaseRate;
  String? get salePrice => _salePrice;
  set salePrice(String? salePrice) => _salePrice = salePrice;
  String? get mainPrice => _mainPrice;
  set mainPrice(String? mainPrice) => _mainPrice = mainPrice;
  String? get cashbackPercent => _cashbackPercent;
  set cashbackPercent(String? cashbackPercent) =>
      _cashbackPercent = cashbackPercent;
  String? get cashbackAmount => _cashbackAmount;
  set cashbackAmount(String? cashbackAmount) =>
      _cashbackAmount = cashbackAmount;
  String? get reorderLevel => _reorderLevel;
  set reorderLevel(String? reorderLevel) => _reorderLevel = reorderLevel;
  String? get sizeSiNo => _sizeSiNo;
  set sizeSiNo(String? sizeSiNo) => _sizeSiNo = sizeSiNo;
  String? get sizeName => _sizeName;
  set sizeName(String? sizeName) => _sizeName = sizeName;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get sizeBranchid => _sizeBranchid;
  set sizeBranchid(String? sizeBranchid) => _sizeBranchid = sizeBranchid;

  Product_Color_id_wise_size_Model_Class.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _colorId = json['color_id'];
    _sizeId = json['size_id'];
    _purchaseRate = json['purchase_rate'];
    _salePrice = json['sale_price'];
    _mainPrice = json['main_price'];
    _cashbackPercent = json['cashback_percent'];
    _cashbackAmount = json['cashback_amount'];
    _reorderLevel = json['reorder_level'];
    _sizeSiNo = json['size_SiNo'];
    _sizeName = json['size_name'];
    _status = json['status'];
    _sizeBranchid = json['size_branchid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['product_id'] = _productId;
    data['color_id'] = _colorId;
    data['size_id'] = _sizeId;
    data['purchase_rate'] = _purchaseRate;
    data['sale_price'] = _salePrice;
    data['main_price'] = _mainPrice;
    data['cashback_percent'] = _cashbackPercent;
    data['cashback_amount'] = _cashbackAmount;
    data['reorder_level'] = _reorderLevel;
    data['size_SiNo'] = _sizeSiNo;
    data['size_name'] = _sizeName;
    data['status'] = _status;
    data['size_branchid'] = _sizeBranchid;
    return data;
  }
}
