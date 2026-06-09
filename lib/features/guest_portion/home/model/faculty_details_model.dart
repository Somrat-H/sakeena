class FacultyDetailsModel {
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
  List<Consultations>? consultations;

  FacultyDetailsModel(
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
      this.consultations});

  FacultyDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    profilePicture = json['profile_picture'];
    professionalTitle = json['professional_title'];
    location = json['location'];
    about = json['about'];
    education = json['education'];
    achievements = json['achievements'].cast<String>() ?? [];
    consultationRate = json['consultation_rate'];
    offersConsultations = json['offers_consultations'];
   if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
    if (json['consultations'] != null) {
      consultations = <Consultations>[];
      json['consultations'].forEach((v) {
        consultations!.add(new Consultations.fromJson(v));
      });
    }
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
    if (this.consultations != null) {
      data['consultations'] =
          this.consultations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;

  User({this.id, this.email, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Consultations {
  int? id;
  Teacher? teacher;
  List<Timeslots>? timeslots;
  List<Bundles>? bundles;
  List<RecurringRules>? recurringRules;
  String? title;
  Null? description;
  String? standardPrice;

  Consultations(
      {this.id,
      this.teacher,
      this.timeslots,
      this.bundles,
      this.recurringRules,
      this.title,
      this.description,
      this.standardPrice});

  Consultations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
    if (json['timeslots'] != null) {
      timeslots = <Timeslots>[];
      json['timeslots'].forEach((v) {
        timeslots!.add(new Timeslots.fromJson(v));
      });
    }
    if (json['bundles'] != null) {
      bundles = <Bundles>[];
      json['bundles'].forEach((v) {
        bundles!.add(new Bundles.fromJson(v));
      });
    }
    if (json['recurring_rules'] != null) {
      recurringRules = <RecurringRules>[];
      json['recurring_rules'].forEach((v) {
        recurringRules!.add(new RecurringRules.fromJson(v));
      });
    }
    title = json['title'];
    description = json['description'];
    standardPrice = json['standard_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.timeslots != null) {
      data['timeslots'] = this.timeslots!.map((v) => v.toJson()).toList();
    }
    if (this.bundles != null) {
      data['bundles'] = this.bundles!.map((v) => v.toJson()).toList();
    }
    if (this.recurringRules != null) {
      data['recurring_rules'] =
          this.recurringRules!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['standard_price'] = this.standardPrice;
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



class Timeslots {
  int? id;
  int? consultation;
  ConsultationDetails? consultationDetails;
  int? recurringRule;
  String? scheduledStart;
  String? scheduledEnd;
  bool? isBooked;
  Null? zoomMeetingId;
  Null? zoomJoinUrl;
  Null? zoomStartUrl;

  Timeslots(
      {this.id,
      this.consultation,
      this.consultationDetails,
      this.recurringRule,
      this.scheduledStart,
      this.scheduledEnd,
      this.isBooked,
      this.zoomMeetingId,
      this.zoomJoinUrl,
      this.zoomStartUrl});

  Timeslots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consultation = json['consultation'];
    consultationDetails = json['consultation_details'] != null
        ? new ConsultationDetails.fromJson(json['consultation_details'])
        : null;
    recurringRule = json['recurring_rule'];
    scheduledStart = json['scheduled_start'];
    scheduledEnd = json['scheduled_end'];
    isBooked = json['is_booked'];
    zoomMeetingId = json['zoom_meeting_id'];
    zoomJoinUrl = json['zoom_join_url'];
    zoomStartUrl = json['zoom_start_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['consultation'] = this.consultation;
    if (this.consultationDetails != null) {
      data['consultation_details'] = this.consultationDetails!.toJson();
    }
    data['recurring_rule'] = this.recurringRule;
    data['scheduled_start'] = this.scheduledStart;
    data['scheduled_end'] = this.scheduledEnd;
    data['is_booked'] = this.isBooked;
    data['zoom_meeting_id'] = this.zoomMeetingId;
    data['zoom_join_url'] = this.zoomJoinUrl;
    data['zoom_start_url'] = this.zoomStartUrl;
    return data;
  }
}

class ConsultationDetails {
  int? id;
  String? title;
  Null? description;
  Teacher? teacher;

  ConsultationDetails({this.id, this.title, this.description, this.teacher});

  ConsultationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    return data;
  }
}



class Bundles {
  int? id;
  int? numSessions;
  String? discountPercentage;
  int? consultation;

  Bundles(
      {this.id, this.numSessions, this.discountPercentage, this.consultation});

  Bundles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numSessions = json['num_sessions'];
    discountPercentage = json['discount_percentage'];
    consultation = json['consultation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['num_sessions'] = this.numSessions;
    data['discount_percentage'] = this.discountPercentage;
    data['consultation'] = this.consultation;
    return data;
  }
}

class RecurringRules {
  int? id;
  int? consultation;
  int? weekday;
  String? weekdayDisplay;
  String? startTime;
  String? endTime;
  int? sessionDurationMinutes;
  String? validFrom;
  String? validUntil;

  RecurringRules(
      {this.id,
      this.consultation,
      this.weekday,
      this.weekdayDisplay,
      this.startTime,
      this.endTime,
      this.sessionDurationMinutes,
      this.validFrom,
      this.validUntil});

  RecurringRules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    consultation = json['consultation'];
    weekday = json['weekday'];
    weekdayDisplay = json['weekday_display'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    sessionDurationMinutes = json['session_duration_minutes'];
    validFrom = json['valid_from'];
    validUntil = json['valid_until'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['consultation'] = this.consultation;
    data['weekday'] = this.weekday;
    data['weekday_display'] = this.weekdayDisplay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['session_duration_minutes'] = this.sessionDurationMinutes;
    data['valid_from'] = this.validFrom;
    data['valid_until'] = this.validUntil;
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
  bool? isActive;
  String? totalHours;
  int? durationInWeeks;
  int? totalWeeks;
  String? hoursPerSession;
  int? totalLessons;
  String? status;

  Courses(
      {this.id,
      this.title,
      this.slug,
      this.thumbnail,
      this.price,
      this.level,
      this.isActive,
      this.totalHours,
      this.durationInWeeks,
      this.totalWeeks,
      this.hoursPerSession,
      this.totalLessons,
      this.status});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    level = json['level'];
    isActive = json['is_active'];
    totalHours = json['total_hours'];
    durationInWeeks = json['duration_in_weeks'];
    totalWeeks = json['total_weeks'];
    hoursPerSession = json['hours_per_session'];
    totalLessons = json['total_lessons'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['thumbnail'] = this.thumbnail;
    data['price'] = this.price;
    data['level'] = this.level;
    data['is_active'] = this.isActive;
    data['total_hours'] = this.totalHours;
    data['duration_in_weeks'] = this.durationInWeeks;
    data['total_weeks'] = this.totalWeeks;
    data['hours_per_session'] = this.hoursPerSession;
    data['total_lessons'] = this.totalLessons;
    data['status'] = this.status;
    return data;
  }
}