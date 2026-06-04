class SubscriptionPlanModel {
  String? name;
  String? description;
  String? price;
  int? durationDays;
  bool? isActive;
  String? updatedAt;

  SubscriptionPlanModel(
      {this.name,
      this.description,
      this.price,
      this.durationDays,
      this.isActive,
      this.updatedAt});

  SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    durationDays = json['duration_days'];
    isActive = json['is_active'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['duration_days'] = this.durationDays;
    data['is_active'] = this.isActive;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
