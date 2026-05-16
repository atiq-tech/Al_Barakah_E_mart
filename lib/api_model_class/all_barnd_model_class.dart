class Brand_List_Model_Class {
  String? _brandSiNo;
  String? _brandName;
  String? _image;
  String? _status;
  String? _brandBranchid;

  Brand_List_Model_Class(
      {String? brandSiNo,
        String? brandName,
        String? image,
        String? status,
        String? brandBranchid}) {
    if (brandSiNo != null) {
      _brandSiNo = brandSiNo;
    }
    if (brandName != null) {
      _brandName = brandName;
    }
    if (image != null) {
      _image = image;
    }
    if (status != null) {
      _status = status;
    }
    if (brandBranchid != null) {
      _brandBranchid = brandBranchid;
    }
  }

  String? get brandSiNo => _brandSiNo;
  set brandSiNo(String? brandSiNo) => _brandSiNo = brandSiNo;
  String? get brandName => _brandName;
  set brandName(String? brandName) => _brandName = brandName;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get status => _status;
  set status(String? status) => _status = status;
  String? get brandBranchid => _brandBranchid;
  set brandBranchid(String? brandBranchid) => _brandBranchid = brandBranchid;

  Brand_List_Model_Class.fromJson(Map<String, dynamic> json) {
    _brandSiNo = json['brand_SiNo'];
    _brandName = json['brand_name'];
    _image = json['image'];
    _status = json['status'];
    _brandBranchid = json['brand_branchid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand_SiNo'] = _brandSiNo;
    data['brand_name'] = _brandName;
    data['image'] = _image;
    data['status'] = _status;
    data['brand_branchid'] = _brandBranchid;
    return data;
  }
}
