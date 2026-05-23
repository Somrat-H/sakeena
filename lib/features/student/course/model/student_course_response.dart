class StudentCourseResponse {
  int? count;
  int? totalPages;
  dynamic? next;
  String? previous;
  List<Results>? results;

  StudentCourseResponse(
      {this.count, this.totalPages, this.next, this.previous, this.results});

  StudentCourseResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPages = json['total_pages'];
    next = json['next'] ?? 0;
    previous = json['previous'] ?? "0";
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
  String? title;
  String? slug;
  String? thumbnail;
  String? price;
  String? level;
  String? status;
  bool? isActive;
  Category? category;
  Teacher? teacher;
  int? totalLessons;
  int? durationInWeeks;
  String? totalHours;
  String? hoursPerSession;
  bool? isEnrolled;
  bool? hasAccess;

  Results(
      {this.id,
      this.title,
      this.slug,
      this.thumbnail,
      this.price,
      this.level,
      this.status,
      this.isActive,
      this.category,
      this.teacher,
      this.totalLessons,
      this.durationInWeeks,
      this.totalHours,
      this.hoursPerSession,
      this.isEnrolled,
      this.hasAccess});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    level = json['level'];
    status = json['status'];
    isActive = json['is_active'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
    totalLessons = json['total_lessons'];
    durationInWeeks = json['duration_in_weeks'];
    totalHours = json['total_hours'];
    hoursPerSession = json['hours_per_session'];
    isEnrolled = json['is_enrolled'];
    hasAccess = json['has_access'];
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
    data['is_active'] = this.isActive;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    data['total_lessons'] = this.totalLessons;
    data['duration_in_weeks'] = this.durationInWeeks;
    data['total_hours'] = this.totalHours;
    data['hours_per_session'] = this.hoursPerSession;
    data['is_enrolled'] = this.isEnrolled;
    data['has_access'] = this.hasAccess;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  String? description;

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

class Teacher {
  int? id;
  User? user;
  String? profilePicture;
  String? professionalTitle;
  String? location;
  String? about;
  String? consultationRate;
  bool? offersConsultations;

  Teacher(
      {this.id,
      this.user,
      this.profilePicture,
      this.professionalTitle,
      this.location,
      this.about,
      this.consultationRate,
      this.offersConsultations});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    profilePicture = json['profile_picture'];
    professionalTitle = json['professional_title'];
    location = json['location'];
    about = json['about'];
    consultationRate = json['consultation_rate'];
    offersConsultations = json['offers_consultations'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['profile_picture'] = this.profilePicture;
    data['professional_title'] = this.professionalTitle;
    data['location'] = this.location;
    data['about'] = this.about;
    data['consultation_rate'] = this.consultationRate;
    data['offers_consultations'] = this.offersConsultations;
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? role;
  String? firstName;
  String? lastName;
  String? joinedAt;

  User(
      {this.id,
      this.email,
      this.role,
      this.firstName,
      this.lastName,
      this.joinedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    joinedAt = json['joined_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['role'] = this.role;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['joined_at'] = this.joinedAt;
    return data;
  }
}
