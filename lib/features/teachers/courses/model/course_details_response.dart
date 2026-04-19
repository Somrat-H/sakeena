class CouseDeatilsResponse {
  int? id;
  Category? category;
  Teacher? teacher;
  List<Modules>? modules;
  int? totalLessons;
  String? description;
  bool? isEnrolled;
  bool? hasAccess;
  String? title;
  String? slug;
  String? subtitle;
  String? price;
  int? durationInWeeks;
  String? hoursPerSession;
  String? totalHours;
  String? level;
  String? status;
  String? startDate;
  bool? isActive;
  Null? thumbnail;
  String? previewVideo;
  List<RelatedCourses>? relatedCourses;

  CouseDeatilsResponse(
      {this.id,
      this.category,
      this.teacher,
      this.modules,
      this.totalLessons,
      this.description,
      this.isEnrolled,
      this.hasAccess,
      this.title,
      this.slug,
      this.subtitle,
      this.price,
      this.durationInWeeks,
      this.hoursPerSession,
      this.totalHours,
      this.level,
      this.status,
      this.startDate,
      this.isActive,
      this.thumbnail,
      this.previewVideo,
      this.relatedCourses});

  CouseDeatilsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(new Modules.fromJson(v));
      });
    }
    totalLessons = json['total_lessons'];
    description = json['description'];
    isEnrolled = json['is_enrolled'];
    hasAccess = json['has_access'];
    title = json['title'];
    slug = json['slug'];
    subtitle = json['subtitle'];
    price = json['price'];
    durationInWeeks = json['duration_in_weeks'];
    hoursPerSession = json['hours_per_session'];
    totalHours = json['total_hours'];
    level = json['level'];
    status = json['status'];
    startDate = json['start_date'];
    isActive = json['is_active'];
    thumbnail = json['thumbnail'];
    previewVideo = json['preview_video'];
    if (json['related_courses'] != null) {
      relatedCourses = <RelatedCourses>[];
      json['related_courses'].forEach((v) {
        relatedCourses!.add(new RelatedCourses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.modules != null) {
      data['modules'] = this.modules!.map((v) => v.toJson()).toList();
    }
    data['total_lessons'] = this.totalLessons;
    data['description'] = this.description;
    data['is_enrolled'] = this.isEnrolled;
    data['has_access'] = this.hasAccess;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['subtitle'] = this.subtitle;
    data['price'] = this.price;
    data['duration_in_weeks'] = this.durationInWeeks;
    data['hours_per_session'] = this.hoursPerSession;
    data['total_hours'] = this.totalHours;
    data['level'] = this.level;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['is_active'] = this.isActive;
    data['thumbnail'] = this.thumbnail;
    data['preview_video'] = this.previewVideo;
    if (this.relatedCourses != null) {
      data['related_courses'] =
          this.relatedCourses!.map((v) => v.toJson()).toList();
    }
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

class Modules {
  int? id;
  List<Lessons>? lessons;
  int? totalLessons;
  int? totalDuration;
  String? title;
  int? order;
  int? course;

  Modules(
      {this.id,
      this.lessons,
      this.totalLessons,
      this.totalDuration,
      this.title,
      this.order,
      this.course});

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(new Lessons.fromJson(v));
      });
    }
    totalLessons = json['total_lessons'];
    totalDuration = json['total_duration'];
    title = json['title'];
    order = json['order'];
    course = json['course'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.lessons != null) {
      data['lessons'] = this.lessons!.map((v) => v.toJson()).toList();
    }
    data['total_lessons'] = this.totalLessons;
    data['total_duration'] = this.totalDuration;
    data['title'] = this.title;
    data['order'] = this.order;
    data['course'] = this.course;
    return data;
  }
}

class Lessons {
  int? id;
  QuizDetails? quizDetails;
  AssignmentDetails? assignmentDetails;
  bool? isAccessible;
  String? liveStatus;
  String? zoomStartUrl;
  String? bunnyEmbedUrl;
  String? title;
  String? contentType;
  String? content;
  Null? fileContent;
  String? videoContent;
  int? durationInMinutes;
  bool? isPreview;
  bool? isReleased;
  int? order;
  String? bunnyVideoId;
  String? bunnyVideoStatus;
  String? scheduledAt;
  String? zoomMeetingId;
  String? zoomHostEmail;
  Null? zoomJoinUrl;
  int? module;

  Lessons(
      {this.id,
      this.quizDetails,
      this.assignmentDetails,
      this.isAccessible,
      this.liveStatus,
      this.zoomStartUrl,
      this.bunnyEmbedUrl,
      this.title,
      this.contentType,
      this.content,
      this.fileContent,
      this.videoContent,
      this.durationInMinutes,
      this.isPreview,
      this.isReleased,
      this.order,
      this.bunnyVideoId,
      this.bunnyVideoStatus,
      this.scheduledAt,
      this.zoomMeetingId,
      this.zoomHostEmail,
      this.zoomJoinUrl,
      this.module});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizDetails = json['quiz_details'] != null
        ? new QuizDetails.fromJson(json['quiz_details'])
        : null;
    assignmentDetails = json['assignment_details'] != null
        ? new AssignmentDetails.fromJson(json['assignment_details'])
        : null;
    isAccessible = json['is_accessible'];
    liveStatus = json['live_status'];
    zoomStartUrl = json['zoom_start_url'];
    bunnyEmbedUrl = json['bunny_embed_url'];
    title = json['title'];
    contentType = json['content_type'];
    content = json['content'];
    fileContent = json['file_content'];
    videoContent = json['video_content'];
    durationInMinutes = json['duration_in_minutes'];
    isPreview = json['is_preview'];
    isReleased = json['is_released'];
    order = json['order'];
    bunnyVideoId = json['bunny_video_id'];
    bunnyVideoStatus = json['bunny_video_status'];
    scheduledAt = json['scheduled_at'];
    zoomMeetingId = json['zoom_meeting_id'];
    zoomHostEmail = json['zoom_host_email'];
    zoomJoinUrl = json['zoom_join_url'];
    module = json['module'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.quizDetails != null) {
      data['quiz_details'] = this.quizDetails!.toJson();
    }
    if (this.assignmentDetails != null) {
      data['assignment_details'] = this.assignmentDetails!.toJson();
    }
    data['is_accessible'] = this.isAccessible;
    data['live_status'] = this.liveStatus;
    data['zoom_start_url'] = this.zoomStartUrl;
    data['bunny_embed_url'] = this.bunnyEmbedUrl;
    data['title'] = this.title;
    data['content_type'] = this.contentType;
    data['content'] = this.content;
    data['file_content'] = this.fileContent;
    data['video_content'] = this.videoContent;
    data['duration_in_minutes'] = this.durationInMinutes;
    data['is_preview'] = this.isPreview;
    data['is_released'] = this.isReleased;
    data['order'] = this.order;
    data['bunny_video_id'] = this.bunnyVideoId;
    data['bunny_video_status'] = this.bunnyVideoStatus;
    data['scheduled_at'] = this.scheduledAt;
    data['zoom_meeting_id'] = this.zoomMeetingId;
    data['zoom_host_email'] = this.zoomHostEmail;
    data['zoom_join_url'] = this.zoomJoinUrl;
    data['module'] = this.module;
    return data;
  }
}

class QuizDetails {
  int? id;
  List<Questions>? questions;
  int? timeLimit;
  int? passingScore;
  String? description;
  int? lesson;

  QuizDetails(
      {this.id,
      this.questions,
      this.timeLimit,
      this.passingScore,
      this.description,
      this.lesson});

  QuizDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    timeLimit = json['time_limit'];
    passingScore = json['passing_score'];
    description = json['description'];
    lesson = json['lesson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['time_limit'] = this.timeLimit;
    data['passing_score'] = this.passingScore;
    data['description'] = this.description;
    data['lesson'] = this.lesson;
    return data;
  }
}

class Questions {
  int? id;
  List<Options>? options;
  String? text;
  int? points;
  int? quiz;

  Questions({this.id, this.options, this.text, this.points, this.quiz});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    text = json['text'];
    points = json['points'];
    quiz = json['quiz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['text'] = this.text;
    data['points'] = this.points;
    data['quiz'] = this.quiz;
    return data;
  }
}

class Options {
  int? id;
  String? text;
  bool? isCorrect;
  int? question;

  Options({this.id, this.text, this.isCorrect, this.question});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    isCorrect = json['is_correct'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['is_correct'] = this.isCorrect;
    data['question'] = this.question;
    return data;
  }
}

class AssignmentDetails {
  int? id;
  String? description;
  String? instructions;
  String? dueDate;
  int? maxPoints;
  String? allowedFileTypes;
  int? maxFileSize;
  int? lesson;

  AssignmentDetails(
      {this.id,
      this.description,
      this.instructions,
      this.dueDate,
      this.maxPoints,
      this.allowedFileTypes,
      this.maxFileSize,
      this.lesson});

  AssignmentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    instructions = json['instructions'];
    dueDate = json['due_date'];
    maxPoints = json['max_points'];
    allowedFileTypes = json['allowed_file_types'];
    maxFileSize = json['max_file_size'];
    lesson = json['lesson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['instructions'] = this.instructions;
    data['due_date'] = this.dueDate;
    data['max_points'] = this.maxPoints;
    data['allowed_file_types'] = this.allowedFileTypes;
    data['max_file_size'] = this.maxFileSize;
    data['lesson'] = this.lesson;
    return data;
  }
}

class RelatedCourses {
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

  RelatedCourses(
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

  RelatedCourses.fromJson(Map<String, dynamic> json) {
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
