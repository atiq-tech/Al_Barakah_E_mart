import 'dart:convert';

class GetSlidersModel {
    final dynamic id;
    final dynamic image;
    final dynamic link;
    final dynamic createdAt;
    final dynamic updatedAt;

    GetSlidersModel({
        required this.id,
        required this.image,
        required this.link,
        required this.createdAt,
        required this.updatedAt,
    });

    factory GetSlidersModel.fromJson(String str) => GetSlidersModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetSlidersModel.fromMap(Map<String, dynamic> json) => GetSlidersModel(
        id: json["id"],
        image: json["image"],
        link: json["link"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
        "link": link,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}




// import 'dart:convert';
//
// class GetSlidersModel {
//   final int id;
//   final String title;
//   final String image;
//   final String status;
//   final dynamic deletedAt;
//   final String createdAt;
//   final String updatedAt;
//
//   GetSlidersModel({
//     required this.id,
//     required this.title,
//     required this.image,
//     required this.status,
//     required this.deletedAt,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory GetSlidersModel.fromJson(String str) => GetSlidersModel.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory GetSlidersModel.fromMap(Map<String, dynamic> json) => GetSlidersModel(
//     id: json["id"]??0,
//     title: json["title"]??"",
//     image: json["image"]??"",
//     status: json["status"]??"",
//     deletedAt: json["deleted_at"],
//     createdAt: json["created_at"]??"",
//     updatedAt: json["updated_at"]??"",
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "title": title,
//     "image": image,
//     "status": status,
//     "deleted_at": deletedAt,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
