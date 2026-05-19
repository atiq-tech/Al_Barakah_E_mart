import 'dart:convert';

class DepartmentModel {
    final dynamic departmentSlNo;
    final dynamic departmentName;
    final dynamic status;
    final dynamic addBy;
    final dynamic addTime;
    final dynamic updateBy;
    final dynamic updateTime;
    final dynamic deletedBy;
    final dynamic deletedTime;
    final dynamic lastUpdateIp;

    DepartmentModel({
        required this.departmentSlNo,
        required this.departmentName,
        required this.status,
        required this.addBy,
        required this.addTime,
        required this.updateBy,
        required this.updateTime,
        required this.deletedBy,
        required this.deletedTime,
        required this.lastUpdateIp,
    });

    factory DepartmentModel.fromJson(String str) => DepartmentModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DepartmentModel.fromMap(Map<String, dynamic> json) => DepartmentModel(
        departmentSlNo: json["Department_SlNo"],
        departmentName: json["Department_Name"],
        status: json["status"],
        addBy: json["AddBy"],
        addTime: json["AddTime"],
        updateBy: json["UpdateBy"],
        updateTime: json["UpdateTime"],
        deletedBy: json["DeletedBy"],
        deletedTime: json["DeletedTime"],
        lastUpdateIp: json["last_update_ip"],
    );

    Map<String, dynamic> toMap() => {
        "Department_SlNo": departmentSlNo,
        "Department_Name": departmentName,
        "status": status,
        "AddBy": addBy,
        "AddTime": addTime,
        "UpdateBy": updateBy,
        "UpdateTime": updateTime,
        "DeletedBy": deletedBy,
        "DeletedTime": deletedTime,
        "last_update_ip": lastUpdateIp,
    };
}
