class VideLibraryModel {
  int? count;
  int? totalPages;
  String? next;
  int? previous;
  List<Videos>? vidoes;

  VideLibraryModel(
      {this.count, this.totalPages, this.next, this.previous, this.vidoes});

  VideLibraryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'] ?? 0;
    if (json['results'] != null) {
      vidoes = <Videos>[];
      json['results'].forEach((v) {
        vidoes!.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.vidoes != null) {
      data['results'] = this.vidoes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  int? id;
  AuthorDetail? authorDetail;
  Category? category;
  String? title;
  String? slug;
  String? videoUrl;
  Null? coverImage;
  String? excerpt;
  String? content;
  List<String>? tags;
  int? viewCount;
  String? publishedAt;
  String? createdAt;

  Videos(
      {this.id,
      this.authorDetail,
      this.category,
      this.title,
      this.slug,
      this.videoUrl,
      this.coverImage,
      this.excerpt,
      this.content,
      this.tags,
      this.viewCount,
      this.publishedAt,
      this.createdAt});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorDetail = json['author_detail'] != null
        ? new AuthorDetail.fromJson(json['author_detail'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    title = json['title'];
    slug = json['slug'];
    videoUrl = json['video_url'];
    coverImage = json['cover_image'];
    excerpt = json['excerpt'];
    content = json['content'];
    tags = json['tags'].cast<String>();
    viewCount = json['view_count'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.authorDetail != null) {
      data['author_detail'] = this.authorDetail!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['video_url'] = this.videoUrl;
    data['cover_image'] = this.coverImage;
    data['excerpt'] = this.excerpt;
    data['content'] = this.content;
    data['tags'] = this.tags;
    data['view_count'] = this.viewCount;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class AuthorDetail {
  int? id;
  String? fullName;
  String? profilePicture;
  String? professionalTitle;

  AuthorDetail(
      {this.id, this.fullName, this.profilePicture, this.professionalTitle});

  AuthorDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    profilePicture = json['profile_picture'];
    professionalTitle = json['professional_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['profile_picture'] = this.profilePicture;
    data['professional_title'] = this.professionalTitle;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? slug;

  Category({this.id, this.name, this.slug});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
