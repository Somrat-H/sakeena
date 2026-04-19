class StundeProfileResponse {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? location;
  String? profilePicture;

  StundeProfileResponse(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.location,
      this.profilePicture});

  StundeProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    location = json['location'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['location'] = this.location;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}
