class CourseReviewModel {
  int? count;
  int? totalPages;
  int? next;
  int? previous;
  List<Results>? results;

  CourseReviewModel(
      {this.count, this.totalPages, this.next, this.previous, this.results});

  CourseReviewModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['total_pages'];
    next = json['next'] ?? 0;
    previous = json['previous'] ?? 0;
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
  int? user;
  String? userName;
  String? reviewType;
  int? rating;
  String? comment;
  int? course;
  Null? book;
  Null? consultation;
  String? createdAt;
  String? updatedAt;

  Results(
      {this.id,
      this.user,
      this.userName,
      this.reviewType,
      this.rating,
      this.comment,
      this.course,
      this.book,
      this.consultation,
      this.createdAt,
      this.updatedAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    userName = json['user_name'];
    reviewType = json['review_type'];
    rating = json['rating'];
    comment = json['comment'];
    course = json['course'];
    book = json['book'];
    consultation = json['consultation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['user_name'] = this.userName;
    data['review_type'] = this.reviewType;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['course'] = this.course;
    data['book'] = this.book;
    data['consultation'] = this.consultation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
