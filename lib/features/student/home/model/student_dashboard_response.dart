class StudentDashboardResponse {
  Stats? stats;
  List<MyCourses>? myCourses;
  // List<Null>? myBooks;
  List<MyOrders>? myOrders;
  List<UpcomingSessions>? upcomingSessions;
  NextLiveClass? nextLiveClass;

  StudentDashboardResponse(
      {this.stats,
      this.myCourses,
      // this.myBooks,
      this.myOrders,
      this.upcomingSessions,
      this.nextLiveClass});

  StudentDashboardResponse.fromJson(Map<String, dynamic> json) {
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    if (json['my_courses'] != null) {
      myCourses = <MyCourses>[];
      json['my_courses'].forEach((v) {
        myCourses!.add(new MyCourses.fromJson(v));
      });
    }
    // if (json['my_books'] != null) {
    //   myBooks = <Null>[];
    //   json['my_books'].forEach((v) {
    //     myBooks!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['my_orders'] != null) {
      myOrders = <MyOrders>[];
      json['my_orders'].forEach((v) {
        myOrders!.add(new MyOrders.fromJson(v));
      });
    }
    if (json['upcoming_sessions'] != null) {
      upcomingSessions = <UpcomingSessions>[];
      json['upcoming_sessions'].forEach((v) {
        upcomingSessions!.add(new UpcomingSessions.fromJson(v));
      });
    }
    nextLiveClass = json['next_live_class'] != null
        ? new NextLiveClass.fromJson(json['next_live_class'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    if (this.myCourses != null) {
      data['my_courses'] = this.myCourses!.map((v) => v.toJson()).toList();
    }
    // if (this.myBooks != null) {
    //   data['my_books'] = this.myBooks!.map((v) => v.toJson()).toList();
    // }
    if (this.myOrders != null) {
      data['my_orders'] = this.myOrders!.map((v) => v.toJson()).toList();
    }
    if (this.upcomingSessions != null) {
      data['upcoming_sessions'] =
          this.upcomingSessions!.map((v) => v.toJson()).toList();
    }
    if (this.nextLiveClass != null) {
      data['next_live_class'] = this.nextLiveClass!.toJson();
    }
    return data;
  }
}

class Stats {
  int? totalActiveCourses;
  int? totalBooks;
  int? totalOrders;

  Stats({this.totalActiveCourses, this.totalBooks, this.totalOrders});

  Stats.fromJson(Map<String, dynamic> json) {
    totalActiveCourses = json['total_active_courses'];
    totalBooks = json['total_books'];
    totalOrders = json['total_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_active_courses'] = this.totalActiveCourses;
    data['total_books'] = this.totalBooks;
    data['total_orders'] = this.totalOrders;
    return data;
  }
}

class MyCourses {
  int? id;
  Course? course;
  Student? student;
  String? enrolledAt;
  bool? isCompleted;
  String? completedAt;
  int? user;

  MyCourses(
      {this.id,
      this.course,
      this.student,
      this.enrolledAt,
      this.isCompleted,
      this.completedAt,
      this.user});

  MyCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    course =
        json['course'] != null ? new Course.fromJson(json['course']) : null;
    student =
        json['student'] != null ? new Student.fromJson(json['student']) : null;
    enrolledAt = json['enrolled_at'];
    isCompleted = json['is_completed'];
    completedAt = json['completed_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    data['enrolled_at'] = this.enrolledAt;
    data['is_completed'] = this.isCompleted;
    data['completed_at'] = this.completedAt;
    data['user'] = this.user;
    return data;
  }
}

class Course {
  int? id;
  String? title;
  String? thumbnail;
  String? price;
  String? level;
  String? status;
  Teacher? teacher;

  Course(
      {this.id,
      this.title,
      this.thumbnail,
      this.price,
      this.level,
      this.status,
      this.teacher});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    level = json['level'];
    status = json['status'];
    teacher =
        json['teacher'] != null ? new Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['price'] = this.price;
    data['level'] = this.level;
    data['status'] = this.status;
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    return data;
  }
}

class Teacher {
  int? id;
  String? fullName;
  String? profilePicture;
  String? professionalTitle;

  Teacher(
      {this.id, this.fullName, this.profilePicture, this.professionalTitle});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['name'];
    profilePicture = json['profile_picture'];
    professionalTitle = json['professional_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.fullName;
    data['profile_picture'] = this.profilePicture;
    data['professional_title'] = this.professionalTitle;
    return data;
  }
}

class Student {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? location;
  String? profilePicture;

  Student(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.location,
      this.profilePicture});

  Student.fromJson(Map<String, dynamic> json) {
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




class MyOrders {
  int? id;
  String? orderType;
  String? status;
  String? fulfillmentStatus;
  String? couponCode;
  String? discountAmount;
  String? totalAmount;
  String? shippingCost;
  List<Items>? items;
  String? shippingAddress;
  String? createdAt;

  MyOrders(
      {this.id,
      this.orderType,
      this.status,
      this.fulfillmentStatus,
      this.couponCode,
      this.discountAmount,
      this.totalAmount,
      this.shippingCost,
      this.items,
      this.shippingAddress,
      this.createdAt});

  MyOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderType = json['order_type'];
    status = json['status'];
    fulfillmentStatus = json['fulfillment_status'];
    couponCode = json['coupon_code'];
    discountAmount = json['discount_amount'];
    totalAmount = json['total_amount'];
    shippingCost = json['shipping_cost'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    shippingAddress = json['shipping_address'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_type'] = this.orderType;
    data['status'] = this.status;
    data['fulfillment_status'] = this.fulfillmentStatus;
    data['coupon_code'] = this.couponCode;
    data['discount_amount'] = this.discountAmount;
    data['total_amount'] = this.totalAmount;
    data['shipping_cost'] = this.shippingCost;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['shipping_address'] = this.shippingAddress;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Items {
  int? id;
  String? itemType;
  int? course;
  int? book;
  int? quantity;
  String? unitPrice;
  String? totalPrice;

  Items(
      {this.id,
      this.itemType,
      this.course,
      this.book,
      this.quantity,
      this.unitPrice,
      this.totalPrice});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemType = json['item_type'];
    course = json['course'];
    book = json['book'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_type'] = this.itemType;
    data['course'] = this.course;
    data['book'] = this.book;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

class UpcomingSessions {
  int? id;
  int? consultation;
  ConsultationDetails? consultationDetails;
  String? recurringRule;
  String? scheduledStart;
  String? scheduledEnd;
  bool? isBooked;
  String? zoomMeetingId;
  String? zoomJoinUrl;
  String? zoomStartUrl;
  int? purchaseId;
  String? pendingRescheduleRequestId;

  UpcomingSessions(
      {this.id,
      this.consultation,
      this.consultationDetails,
      this.recurringRule,
      this.scheduledStart,
      this.scheduledEnd,
      this.isBooked,
      this.zoomMeetingId,
      this.zoomJoinUrl,
      this.zoomStartUrl,
      this.purchaseId,
      this.pendingRescheduleRequestId});

  UpcomingSessions.fromJson(Map<String, dynamic> json) {
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
    purchaseId = json['purchase_id'];
    pendingRescheduleRequestId = json['pending_reschedule_request_id'];
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
    data['purchase_id'] = this.purchaseId;
    data['pending_reschedule_request_id'] = this.pendingRescheduleRequestId;
    return data;
  }
}

class ConsultationDetails {
  int? id;
  String? title;
  String? description;
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


class NextLiveClass {
  int? id;
  String? quizDetails;
  String? assignmentDetails;
  bool? isAccessible;
  bool? isCompleted;
  String? liveStatus;
  String? zoomStartUrl;
  String? bunnyEmbedUrl;
  String? title;
  String? contentType;
  String? content;
  String? fileContent;
  bool? isDownloadable;
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
  String? zoomJoinUrl;
  int? module;

  NextLiveClass(
      {this.id,
      this.quizDetails,
      this.assignmentDetails,
      this.isAccessible,
      this.isCompleted,
      this.liveStatus,
      this.zoomStartUrl,
      this.bunnyEmbedUrl,
      this.title,
      this.contentType,
      this.content,
      this.fileContent,
      this.isDownloadable,
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

  NextLiveClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizDetails = json['quiz_details'];
    assignmentDetails = json['assignment_details'];
    isAccessible = json['is_accessible'];
    isCompleted = json['is_completed'];
    liveStatus = json['live_status'];
    zoomStartUrl = json['zoom_start_url'];
    bunnyEmbedUrl = json['bunny_embed_url'];
    title = json['title'];
    contentType = json['content_type'];
    content = json['content'];
    fileContent = json['file_content'];
    isDownloadable = json['is_downloadable'];
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
    data['quiz_details'] = this.quizDetails;
    data['assignment_details'] = this.assignmentDetails;
    data['is_accessible'] = this.isAccessible;
    data['is_completed'] = this.isCompleted;
    data['live_status'] = this.liveStatus;
    data['zoom_start_url'] = this.zoomStartUrl;
    data['bunny_embed_url'] = this.bunnyEmbedUrl;
    data['title'] = this.title;
    data['content_type'] = this.contentType;
    data['content'] = this.content;
    data['file_content'] = this.fileContent;
    data['is_downloadable'] = this.isDownloadable;
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
