// To parse this JSON data, do
//
//     final sliderImageModel = sliderImageModelFromJson(jsonString);

import 'dart:convert';

class SliderImageModel {
  final String id;
  final String sliderTitle;
  final String sliderDescription;
  final String sliderTag;
  final String isButton;
  final String buttonName;
  final String buttonUrl;
  final String image;
  final String status;
  final String sliderBranchid;

  SliderImageModel({
    required this.id,
    required this.sliderTitle,
    required this.sliderDescription,
    required this.sliderTag,
    required this.isButton,
    required this.buttonName,
    required this.buttonUrl,
    required this.image,
    required this.status,
    required this.sliderBranchid,
  });

  factory SliderImageModel.fromJson(String str) => SliderImageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SliderImageModel.fromMap(Map<String, dynamic> json) => SliderImageModel(
    id: json["id"],
    sliderTitle: json["slider_title"],
    sliderDescription: json["slider_description"],
    sliderTag: json["slider_tag"],
    isButton: json["is_button"],
    buttonName: json["button_name"],
    buttonUrl: json["button_url"],
    image: json["image"],
    status: json["status"],
    sliderBranchid: json["slider_branchid"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "slider_title": sliderTitle,
    "slider_description": sliderDescription,
    "slider_tag": sliderTag,
    "is_button": isButton,
    "button_name": buttonName,
    "button_url": buttonUrl,
    "image": image,
    "status": status,
    "slider_branchid": sliderBranchid,
  };
}
