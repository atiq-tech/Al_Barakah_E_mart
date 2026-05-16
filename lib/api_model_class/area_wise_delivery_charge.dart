import 'dart:convert';

class ApiAreaWiseDeliveryCharse {
  final String districtSlNo;
  final String deliveryOptionId;
  final String districtName;
  final String status;
  final String addBy;
  final String addTime;
  final String updateBy;
  final String updateTime;
  final String areaBranchid;
  final String deliveryOptionName;
  final String deliveryCharge;

  ApiAreaWiseDeliveryCharse({
    required this.districtSlNo,
    required this.deliveryOptionId,
    required this.districtName,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.areaBranchid,
    required this.deliveryOptionName,
    required this.deliveryCharge,
  });

  factory ApiAreaWiseDeliveryCharse.fromJson(String str) => ApiAreaWiseDeliveryCharse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApiAreaWiseDeliveryCharse.fromMap(Map<String, dynamic> json) => ApiAreaWiseDeliveryCharse(
    districtSlNo: json["District_SlNo"]??"",
    deliveryOptionId: json["Delivery_option_id"]??"",
    districtName: json["District_Name"]??"",
    status: json["status"]??"",
    addBy: json["AddBy"]??"",
    addTime: json["AddTime"]??"",
    updateBy: json["UpdateBy"]??"",
    updateTime: json["UpdateTime"]??"",
    areaBranchid: json["area_branchid"]??"",
    deliveryOptionName: json["delivery_option_name"]??"",
    deliveryCharge: json["delivery_charge"]??"",
  );

  Map<String, dynamic> toMap() => {
    "District_SlNo": districtSlNo,
    "Delivery_option_id": deliveryOptionId,
    "District_Name": districtName,
    "status": status,
    "AddBy": addBy,
    "AddTime": addTime,
    "UpdateBy": updateBy,
    "UpdateTime": updateTime,
    "area_branchid": areaBranchid,
    "delivery_option_name": deliveryOptionName,
    "delivery_charge": deliveryCharge,
  };
}
