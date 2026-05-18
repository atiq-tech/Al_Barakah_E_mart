import 'dart:convert';

class SliderModel {
    final String image;
    final String offerLink;

    SliderModel({
        required this.image,
        required this.offerLink,
    });

    factory SliderModel.fromJson(String str) => SliderModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SliderModel.fromMap(Map<String, dynamic> json) => SliderModel(
        image: json["image"],
        offerLink: json["offer_link"],
    );

    Map<String, dynamic> toMap() => {
        "image": image,
        "offer_link": offerLink,
    };
}
