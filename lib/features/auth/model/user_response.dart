class UserResponse {
  int? count;
  int? totalPages;
  int? next;
  int? previous;
  List<Results>? results;

  UserResponse(
      {this.count, this.totalPages, this.next, this.previous, this.results});

  UserResponse.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? role;
  String? firstName;
  String? lastName;
  String? joinedAt;

  Results(
      {this.id,
      this.email,
      this.role,
      this.firstName,
      this.lastName,
      this.joinedAt});

  Results.fromJson(Map<String, dynamic> json) {
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
