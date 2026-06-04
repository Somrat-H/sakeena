class FacultyModel {
  int? count;
  int? totalPages;
  String? next;
  Null? previous;
  List<Results>? results;

  FacultyModel(
      {this.count, this.totalPages, this.next, this.previous, this.results});

  FacultyModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  String? profilePicture;
  String? professionalTitle;
  String? about;
  String? education;
  String? location;
  int? courses;

  Results(
      {this.id,
      this.user,
      this.profilePicture,
      this.professionalTitle,
      this.about,
      this.education,
      this.location,
      this.courses});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    profilePicture = json['profile_picture'];
    professionalTitle = json['professional_title'];
    about = json['about'];
    education = json['education'];
    location = json['location'];
    courses = json['courses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['profile_picture'] = this.profilePicture;
    data['professional_title'] = this.professionalTitle;
    data['about'] = this.about;
    data['education'] = this.education;
    data['location'] = this.location;
    data['courses'] = this.courses;
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
