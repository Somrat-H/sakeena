class BooksModel {
  int? count;
  int? totalPages;
  Null? next;
  Null? previous;
  List<Results>? results;

  BooksModel(
      {this.count, this.totalPages, this.next, this.previous, this.results});

  BooksModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  Category? category;
  String? title;
  String? slug;
  String? author;
  String? description;
  String? coverImage;
  String? isbn;
  String? language;
  String? publisher;
  String? publishedDate;
  int? pageCount;
  String? sampleFile;
  String? videoUrl;
  bool? hasPhysical;
  String? physicalPrice;
  int? stockCount;
  bool? hasDigital;
  String? digitalPrice;
  List<String>? tags;
  String? createdAt;
  String? updatedAt;
  List<Null>? galleryImages;

  Results(
      {this.id,
      this.category,
      this.title,
      this.slug,
      this.author,
      this.description,
      this.coverImage,
      this.isbn,
      this.language,
      this.publisher,
      this.publishedDate,
      this.pageCount,
      this.sampleFile,
      this.videoUrl,
      this.hasPhysical,
      this.physicalPrice,
      this.stockCount,
      this.hasDigital,
      this.digitalPrice,
      this.tags,
      this.createdAt,
      this.updatedAt,
      this.galleryImages});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    title = json['title'];
    slug = json['slug'];
    author = json['author'];
    description = json['description'];
    coverImage = json['cover_image'];
    isbn = json['isbn'];
    language = json['language'];
    publisher = json['publisher'];
    publishedDate = json['published_date'];
    pageCount = json['page_count'];
    sampleFile = json['sample_file'];
    videoUrl = json['video_url'];
    hasPhysical = json['has_physical'];
    physicalPrice = json['physical_price'];
    stockCount = json['stock_count'];
    hasDigital = json['has_digital'];
    digitalPrice = json['digital_price'];
    tags = json['tags'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['gallery_images'] != null) {
      galleryImages = <Null>[];
      // json['gallery_images'].forEach((v) {
      //   galleryImages!.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['author'] = this.author;
    data['description'] = this.description;
    data['cover_image'] = this.coverImage;
    data['isbn'] = this.isbn;
    data['language'] = this.language;
    data['publisher'] = this.publisher;
    data['published_date'] = this.publishedDate;
    data['page_count'] = this.pageCount;
    data['sample_file'] = this.sampleFile;
    data['video_url'] = this.videoUrl;
    data['has_physical'] = this.hasPhysical;
    data['physical_price'] = this.physicalPrice;
    data['stock_count'] = this.stockCount;
    data['has_digital'] = this.hasDigital;
    data['digital_price'] = this.digitalPrice;
    data['tags'] = this.tags;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.galleryImages != null) {
    //   data['gallery_images'] =
    //       this.galleryImages!.map((v) => v.toJson()).toList();
    // }
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
