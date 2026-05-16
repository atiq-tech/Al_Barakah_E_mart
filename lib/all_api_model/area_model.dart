import 'dart:convert';

class AreaModel {
  final int id;
  final String name;
  final String amount;
  final int status;
  final String createdAt;
  final String updatedAt;

  AreaModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AreaModel.fromJson(String str) => AreaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AreaModel.fromMap(Map<String, dynamic> json) => AreaModel(
    id: json["id"]??0,
    name: json["name"]??"",
    amount: json["amount"]??"",
    status: json["status"]??0,
    createdAt: json["created_at"]??"",
    updatedAt: json["updated_at"]??"",
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "amount": amount,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}



// import 'dart:convert';
//
// class AreaModel {
//   final int id;
//   final String name;
//   final String amount;
//   final String status;
//   final String createdAt;
//   final String updatedAt;
//
//   AreaModel({
//     required this.id,
//     required this.name,
//     required this.amount,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory AreaModel.fromJson(String str) => AreaModel.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory AreaModel.fromMap(Map<String, dynamic> json) => AreaModel(
//     id: json["id"]??0,
//     name: json["name"]??"",
//     amount: json["amount"]??"",
//     status: json["status"]??"",
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "name": name,
//     "amount": amount,
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
