import 'package:barber/models/helper.dart';

class SliderModel {
  SliderModel({
    this.img,
    this.order,
    this.text,
    this.link,
    this.created_at,
    this.updated_at,
  });

  final String img;
  final int order;
  final String text;
  final String link;
  final DateTime created_at;
  final DateTime updated_at;

  factory SliderModel.fromJson(dynamic json) {
    return SliderModel(
      img: fixPhotoUrl(url: json['img']),
      order: json["order"],
      text: json["title"],
      link: json["desc"],
      created_at: DateTime.parse(json["created_at"]),
      updated_at: DateTime.parse(json["updated_at"]),

    );
  }

//  *************************

  Map<String, dynamic> toJson() => {
    "img": img,
    "order": order,
    "text": text,
    "link": link,
    "created_at": created_at.toIso8601String(),
    "updated_at": updated_at.toIso8601String(),
  };
}



//  Map<String, dynamic> toJson() => {
//        "phont": phont,
//        "phone": phone,
//        "title": title,
//        "desc": desc,
//        "date": date.toIso8601String(),
//        "type": type,
//      };


/*import 'dart:convert';

import 'package:barber/models/api_response.dart';

SliderResponse sliderResponseFromJson(String str) =>
    SliderResponse.fromJson(json.decode(str));

String sliderResponseToJson(SliderResponse data) => json.encode(data.toJson());

class SliderModel extends ApiResponse {
  SliderResponse({
    status,
    code,
    message,
    this.data,
  }) : super(
    status: status,
    code: code,
    message: message,
  );

  List<Datum> data;

  factory SliderResponse.fromJson(Map<String, dynamic> json) => SliderResponse(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
*/