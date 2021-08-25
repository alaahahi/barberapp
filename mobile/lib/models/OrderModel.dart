import 'package:coupons/models/helper.dart';

class OrderModel {
  OrderModel({
    this.id,
    this.userId,
    this.companyId,
    this.isAccepted,
    this.orderTotal,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.serviceRating,
    this.serviceComment,
    this.title_company,
    this.product,
  });

  final int id;
  final int userId;
  final int companyId;
  final int isAccepted;
  final int orderTotal;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;
  int serviceRating;
  dynamic serviceComment;
  final String title_company;
  final List<Product> product;

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      id: json["id"],
      userId: json["userId"],
      companyId: json["companyId"],
      isAccepted: json["is_accepted"],
      orderTotal: json["order_total"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      status: json["status"],
      serviceRating: json["service_rating"],
      serviceComment: json["service_comment"],
      title_company: json["title_company"],
      product:
          List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "companyId": companyId,
        "is_accepted": isAccepted,
        "order_total": orderTotal,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "service_rating": serviceRating,
        "service_comment": serviceComment,
        "title_company": title_company,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.photo,
    this.price,
    this.discountPrice,
    this.discountStartData,
    this.discountEndData,
    this.visible,
    this.featured,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.titleTranslation,
    this.pivot,
  });

  final int id;
  final String photo;
  final int price;
  final int discountPrice;
  final DateTime discountStartData;
  final DateTime discountEndData;
  final int visible;
  final int featured;
  final int companyId;
  final String createdAt;
  final String updatedAt;
  final String title;
  final String titleTranslation;
  final Pivot pivot;

  factory Product.fromJson(dynamic json) {
    return Product(
      id: json["id"],
      photo: fixPhotoUrl(url: json['photo']),
      price: json["price"],
      discountPrice: json["discount_price"],
      discountStartData: DateTime.parse(json["discount_start_data"]),
      discountEndData: DateTime.parse(json["discount_end_data"]),
      visible: json["visible"],
      featured: json["featured"],
      companyId: json["companyId"],
//      createdAt: DateTime.parse(json["created_at"]),
//      updatedAt: DateTime.parse(json["updated_at"]),

      createdAt: (json["created_at"]),
      updatedAt: (json["updated_at"]),

      title: json["title"],
      titleTranslation: json["title_translation"],
      pivot: Pivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "price": price,
        "discount_price": discountPrice,
        "discount_start_data": discountStartData.toIso8601String(),
        "discount_end_data": discountEndData.toIso8601String(),
        "visible": visible,
        "featured": featured,
        "companyId": companyId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "title": title,
        "title_translation": titleTranslation,
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  Pivot({
    this.orderId,
    this.productId,
    this.quantity,
  });

  final int orderId;
  final int productId;
  final int quantity;

  factory Pivot.fromJson(dynamic json) => Pivot(
        orderId: json["orderId"],
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "productId": productId,
        "quantity": quantity,
      };
}
