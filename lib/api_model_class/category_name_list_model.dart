class Category_Name_List_Model {
  String? _productCategorySlNo;
  String? _productCategoryName;
  String? _productCategoryImage;
  String? _status;
  String? _addBy;
  String? _addTime;
  String? _updateBy;
  String? _updateTime;
  String? _categoryBranchid;

  Category_Name_List_Model(
      {String? productCategorySlNo,
        String? productCategoryName,
        String? productCategoryImage,
        String? status,
        String? addBy,
        String? addTime,
        String? updateBy,
        String? updateTime,
        String? categoryBranchid}) {
    if (productCategorySlNo != null) {
      _productCategorySlNo = productCategorySlNo;
    }
    if (productCategoryName != null) {
      _productCategoryName = productCategoryName;
    }
    if (productCategoryImage != null) {
      _productCategoryImage = productCategoryImage;
    }
    if (status != null) {
      _status = status;
    }
    if (addBy != null) {
      _addBy = addBy;
    }
    if (addTime != null) {
      _addTime = addTime;
    }
    if (updateBy != null) {
      _updateBy = updateBy;
    }
    if (updateTime != null) {
      _updateTime = updateTime;
    }
    if (categoryBranchid != null) {
      _categoryBranchid = categoryBranchid;
    }
  }

  String? get productCategorySlNo => _productCategorySlNo;
  set productCategorySlNo(String? productCategorySlNo) =>
      _productCategorySlNo = productCategorySlNo;
  String? get productCategoryName => _productCategoryName;
  set productCategoryName(String? productCategoryName) =>
      _productCategoryName = productCategoryName;
  String? get productCategoryImage => _productCategoryImage;
  set productCategoryImage(String? productCategoryImage) =>
      _productCategoryImage = productCategoryImage;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get addBy => _addBy;
  set addBy(String? addBy) => _addBy = addBy;
  String? get addTime => _addTime;
  set addTime(String? addTime) => _addTime = addTime;
  String? get updateBy => _updateBy;
  set updateBy(String? updateBy) => _updateBy = updateBy;
  String? get updateTime => _updateTime;
  set updateTime(String? updateTime) => _updateTime = updateTime;
  String? get categoryBranchid => _categoryBranchid;
  set categoryBranchid(String? categoryBranchid) =>
      _categoryBranchid = categoryBranchid;

  Category_Name_List_Model.fromJson(Map<String, dynamic> json) {
    _productCategorySlNo = json['ProductCategory_SlNo'];
    _productCategoryName = json['ProductCategory_Name'];
    _productCategoryImage = json['ProductCategory_Image'];
    _status = json['status'];
    _addBy = json['AddBy'];
    _addTime = json['AddTime'];
    _updateBy = json['UpdateBy'];
    _updateTime = json['UpdateTime'];
    _categoryBranchid = json['category_branchid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductCategory_SlNo'] = _productCategorySlNo;
    data['ProductCategory_Name'] = _productCategoryName;
    data['ProductCategory_Image'] = _productCategoryImage;
    data['status'] = _status;
    data['AddBy'] = _addBy;
    data['AddTime'] = _addTime;
    data['UpdateBy'] = _updateBy;
    data['UpdateTime'] = _updateTime;
    data['category_branchid'] = _categoryBranchid;
    return data;
  }
}
