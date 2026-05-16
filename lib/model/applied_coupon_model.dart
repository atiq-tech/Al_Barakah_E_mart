import 'dart:convert';

class AppliedCouponModel {
  final String id;
  final String date;
  final String expireDate;
  final String couponCode;
  final String couponName;
  final String faceValue;
  final String value;
  final String status;
  final String addBy;
  final String addTime;
  final String updateBy;
  final String updateTime;
  final String branchId;
  final String customerId;
  final String usedTime;

  AppliedCouponModel({
    required this.id,
    required this.date,
    required this.expireDate,
    required this.couponCode,
    required this.couponName,
    required this.faceValue,
    required this.value,
    required this.status,
    required this.addBy,
    required this.addTime,
    required this.updateBy,
    required this.updateTime,
    required this.branchId,
    required this.customerId,
    required this.usedTime,
  });

  factory AppliedCouponModel.fromJson(String str) => AppliedCouponModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AppliedCouponModel.fromMap(Map<String, dynamic> json) => AppliedCouponModel(
    id: json["id"]??"",
    date: json["date"]??"",
    expireDate: json["expire_date"]??"",
    couponCode: json["coupon_code"]??"",
    couponName: json["coupon_name"]??"",
    faceValue: json["face_value"]??"",
    value: json["value"]??"",
    status: json["status"]??"",
    addBy: json["add_by"]??"",
    addTime: json["add_time"]??"",
    updateBy: json["update_by"]??"",
    updateTime: json["update_time"]??"",
    branchId: json["branch_id"]??"",
    customerId: json["customer_id"]??"",
    usedTime: json["used_time"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "date": date,
    "expire_date": expireDate,
    "coupon_code": couponCode,
    "coupon_name": couponName,
    "face_value": faceValue,
    "value": value,
    "status": status,
    "add_by": addBy,
    "add_time": addTime,
    "update_by": updateBy,
    "update_time": updateTime,
    "branch_id": branchId,
    "customer_id": customerId,
    "used_time": usedTime,
  };
}
