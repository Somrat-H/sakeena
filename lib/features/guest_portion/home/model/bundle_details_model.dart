class BundleDetailsModel {
  int? id;
  String? name;
  String? description;
  String? price;
  double? originalPrice;
  List<CoursesDetail>? coursesDetail;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  BundleDetailsModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.originalPrice,
      this.coursesDetail,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  BundleDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    originalPrice = json['original_price'];
    if (json['courses_detail'] != null) {
      coursesDetail = <CoursesDetail>[];
      json['courses_detail'].forEach((v) {
        coursesDetail!.add(new CoursesDetail.fromJson(v));
      });
    }
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['original_price'] = this.originalPrice;
    if (this.coursesDetail != null) {
      data['courses_detail'] =
          this.coursesDetail!.map((v) => v.toJson()).toList();
    }
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CoursesDetail {
  int? id;
  String? title;
  String? slug;
  String? thumbnail;
  String? price;
  String? level;
  String? status;
  Category? category;

  CoursesDetail(
      {this.id,
      this.title,
      this.slug,
      this.thumbnail,
      this.price,
      this.level,
      this.status,
      this.category});

  CoursesDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    level = json['level'];
    status = json['status'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['thumbnail'] = this.thumbnail;
    data['price'] = this.price;
    data['level'] = this.level;
    data['status'] = this.status;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  Null? description;

  Category({this.id, this.name, this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
