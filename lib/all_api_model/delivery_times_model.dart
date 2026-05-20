import 'dart:convert';

class DeliveryTimesModel {
    final dynamic id;
    final dynamic time;
    final dynamic groupId;
    final dynamic createdAt;
    final dynamic updatedAt;

    DeliveryTimesModel({
        required this.id,
        required this.time,
        required this.groupId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory DeliveryTimesModel.fromJson(String str) => DeliveryTimesModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DeliveryTimesModel.fromMap(Map<String, dynamic> json) => DeliveryTimesModel(
        id: json["id"],
        time: json["time"],
        groupId: json["group_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "time": time,
        "group_id": groupId,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
