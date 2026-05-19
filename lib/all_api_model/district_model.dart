import 'dart:convert';

class DistrictModel {
    final dynamic districtSlNo;
    final dynamic districtName;
    final dynamic status;
    final dynamic addBy;
    final dynamic createdAt;
    final dynamic updateBy;
    final dynamic updatedAt;
    final dynamic deletedBy;
    final dynamic deletedTime;
    final dynamic lastUpdateIp;

    DistrictModel({
        required this.districtSlNo,
        required this.districtName,
        required this.status,
        required this.addBy,
        required this.createdAt,
        required this.updateBy,
        required this.updatedAt,
        required this.deletedBy,
        required this.deletedTime,
        required this.lastUpdateIp,
    });

    factory DistrictModel.fromJson(String str) => DistrictModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DistrictModel.fromMap(Map<String, dynamic> json) => DistrictModel(
        districtSlNo: json["District_SlNo"],
        districtName: json["District_Name"],
        status: json["status"],
        addBy: json["AddBy"],
        createdAt: json["created_at"],
        updateBy: json["UpdateBy"],
        updatedAt: json["updated_at"],
        deletedBy: json["DeletedBy"],
        deletedTime: json["DeletedTime"],
        lastUpdateIp: json["last_update_ip"],
    );

    Map<String, dynamic> toMap() => {
        "District_SlNo": districtSlNo,
        "District_Name": districtName,
        "status": status,
        "AddBy": addBy,
        "created_at": createdAt,
        "UpdateBy": updateBy,
        "updated_at": updatedAt,
        "DeletedBy": deletedBy,
        "DeletedTime": deletedTime,
        "last_update_ip": lastUpdateIp,
    };
}
