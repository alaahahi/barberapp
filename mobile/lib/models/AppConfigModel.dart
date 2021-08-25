class AppConfigModel {
  AppConfigModel({
    this.id,
    this.navBar,
    this.slider,
    this.coins,
    this.category,
    this.gift,
    this.offer,
    this.withdrawals,
    this.company,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int slider;
  int navBar;
  int coins;
  int category;
  int gift;
  int offer;
  int withdrawals;
  int company;
  String createdAt;
  dynamic updatedAt;

  factory AppConfigModel.fromJson(Map<String, dynamic> json) => AppConfigModel(
        id: json["id"],
        navBar: json["nav_bar"],
        slider: json["slider"],
        coins: json["coins"],
        category: json["category"],
        gift: json["gift"],
        offer: json["offer"],
        withdrawals: json["withdrawals"],
        company: json["company"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nav_bar": navBar,
        "slider": slider,
        "coins": coins,
        "category": category,
        "gift": gift,
        "offer": offer,
        "withdrawals": withdrawals,
        "company": company,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
