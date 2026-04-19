class TeacherProfileResponse {
  int? id;
  User? user;
  String? profilePicture;
  String? professionalTitle;
  String? location;
  String? about;
  String? education;
  List<String>? achievements;
  String? consultationRate;
  bool? offersConsultations;
  List<Courses>? courses;
  // List<Null>? consultations;

  TeacherProfileResponse(
      {this.id,
      this.user,
      this.profilePicture,
      this.professionalTitle,
      this.location,
      this.about,
      this.education,
      this.achievements,
      this.consultationRate,
      this.offersConsultations,
      this.courses,
      // this.consultations
      
      });

  TeacherProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    profilePicture = json['profile_picture'];
    professionalTitle = json['professional_title'];
    location = json['location'];
    about = json['about'];
    education = json['education'];
    achievements = json['achievements'];
    consultationRate = json['consultation_rate'];
    offersConsultations = json['offers_consultations'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
    // if (json['consultations'] != null) {
    //   consultations = <Null>[];
    //   json['consultations'].forEach((v) {
    //     consultations!.add(new Null.fromJson(v));
    //   });
    // }
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
    data['education'] = this.education;
    data['achievements'] = this.achievements;
    data['consultation_rate'] = this.consultationRate;
    data['offers_consultations'] = this.offersConsultations;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    // if (this.consultations != null) {
    //   data['consultations'] =
    //       this.consultations!.map((v) => v.toJson()).toList();
    // }
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

class Courses {
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

  Courses(
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

  Courses.fromJson(Map<String, dynamic> json) {
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
