import 'dart:convert';

class ThanaModel {
    final dynamic id;
    final dynamic name;
    final dynamic districtId;
    final dynamic status;
    final dynamic addBy;
    final dynamic createdAt;
    final dynamic updateBy;
    final dynamic updatedAt;
    final dynamic ipAddress;

    ThanaModel({
        required this.id,
        required this.name,
        required this.districtId,
        required this.status,
        required this.addBy,
        required this.createdAt,
        required this.updateBy,
        required this.updatedAt,
        required this.ipAddress,
    });

    factory ThanaModel.fromJson(String str) => ThanaModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ThanaModel.fromMap(Map<String, dynamic> json) => ThanaModel(
        id: json["id"],
        name: json["name"],
        districtId: json["district_id"],
        status: json["status"],
        addBy: json["add_by"],
        createdAt: json["created_at"],
        updateBy: json["update_by"],
        updatedAt: json["updated_at"],
        ipAddress: json["ip_address"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "district_id": districtId,
        "status": status,
        "add_by": addBy,
        "created_at": createdAt,
        "update_by": updateBy,
        "updated_at": updatedAt,
        "ip_address": ipAddress,
    };
}
