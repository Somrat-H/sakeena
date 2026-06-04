class DoorsModel {
  int? id;
  String? title;
  String? content;
  String? icon;
  String? redirectLink;
  String? createdAt;
  String? updatedAt;

  DoorsModel(
      {this.id,
      this.title,
      this.content,
      this.icon,
      this.redirectLink,
      this.createdAt,
      this.updatedAt});

  DoorsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    icon = json['icon'];
    redirectLink = json['redirect_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['icon'] = this.icon;
    data['redirect_link'] = this.redirectLink;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
