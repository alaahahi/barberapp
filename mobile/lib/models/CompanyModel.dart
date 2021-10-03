

import 'helper.dart';

class CompanyModel {
  CompanyModel({
    this.color,
    this.order,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.openMinute,
    this.closeMinute,
    this.locationLat,
    this.locationLng,
    this.featured,
    this.categoryId,
    this.lang,
    this.companyId,
    this.id,
    this.title,
    this.photo,
    this.statues,
    this.category,
    this.desc,
    this.logo,
    // this.distance,
    this.ratting,
    this.openMins,
    this.closeMins,
    this.phone,
    this.info,
  });

  final int id;
  final String title;
  final String photo;
  final String desc;
  final String logo;
  final String category;
  final String statues;
  // final double distance;
  final String phone;
  final String info;
  final int openMins;
  final int closeMins;
  final String color;
  final int order;
  final int visible;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int openMinute;
  final  int closeMinute;
  final int ratting;
  final double locationLat;
  final double locationLng;
  final int featured;
  final int categoryId;
  final String lang;
  final int companyId;

  factory CompanyModel.fromJson(dynamic json) {
    return CompanyModel(
      id: int.parse((json['companyId'] ?? json['id']).toString()),
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      photo: fixPhotoUrl(url: json['photo']),
      logo: fixPhotoUrl(url: json['logo']) ?? '',
      category: json['category'] ?? '',
      // categoryId: json['categoryId'] ?? '',
      ratting: json["ratting"] == null ? null : json["ratting"],
      closeMins: int.parse(json['close_minute'].toString()),
      openMins: int.parse(json['open_minute'].toString()),
      phone: json['phone'],
      info: json['info'],
      color: json["color"],
      order: json["order"],
      visible: json["visible"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      openMinute: json["open_minute"],
      closeMinute: json["close_minute"],
      locationLat: json["location_lat"].toDouble(),
      locationLng: json["location_lng"].toDouble(),
      featured: json["featured"],
      categoryId: json["categoryId"],
      lang: json["lang"],
      companyId: json["companyId"],
      //
    );
  }

  bool get isOpen {
    final now = DateTime.now();
    final open = DateTime(now.year, now.month, now.day, 0, openMins);
    final close = DateTime(now.year, now.month, now.day, 0, closeMins);

    return now.isAfter(open) && now.isBefore(close);
  }
}
