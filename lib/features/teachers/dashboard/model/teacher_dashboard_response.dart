class TeacherDashboardResponse {
  int? activeCourses;
  int? liveSessionsToday;
  List<UpcomingLiveSessions>? upcomingLiveSessions;
  List<RecentUploads>? recentUploads;

  TeacherDashboardResponse(
      {this.activeCourses,
      this.liveSessionsToday,
      this.upcomingLiveSessions,
      this.recentUploads});

  TeacherDashboardResponse.fromJson(Map<String, dynamic> json) {
    activeCourses = json['active_courses'];
    liveSessionsToday = json['live_sessions_today'];
    if (json['upcoming_live_sessions'] != null) {
      upcomingLiveSessions = <UpcomingLiveSessions>[];
      json['upcoming_live_sessions'].forEach((v) {
        upcomingLiveSessions!.add(new UpcomingLiveSessions.fromJson(v));
      });
    }
    if (json['recent_uploads'] != null) {
      recentUploads = <RecentUploads>[];
      json['recent_uploads'].forEach((v) {
        recentUploads!.add(new RecentUploads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_courses'] = this.activeCourses;
    data['live_sessions_today'] = this.liveSessionsToday;
    if (this.upcomingLiveSessions != null) {
      data['upcoming_live_sessions'] =
          this.upcomingLiveSessions!.map((v) => v.toJson()).toList();
    }
    if (this.recentUploads != null) {
      data['recent_uploads'] =
          this.recentUploads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingLiveSessions {
  int? id;
  String? title;
  int? courseId;
  String? courseTitle;
  String? moduleTitle;
  String? scheduledAt;
  int? durationInMinutes;
  String? liveStatus;
  int? enrolledCount;
  String? zoomMeetingId;
  String? zoomStartUrl;
  String? zoomJoinUrl;
  bool? isReleased;

  UpcomingLiveSessions(
      {this.id,
      this.title,
      this.courseId,
      this.courseTitle,
      this.moduleTitle,
      this.scheduledAt,
      this.durationInMinutes,
      this.liveStatus,
      this.enrolledCount,
      this.zoomMeetingId,
      this.zoomStartUrl,
      this.zoomJoinUrl,
      this.isReleased});

  UpcomingLiveSessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    courseId = json['course_id'];
    courseTitle = json['course_title'];
    moduleTitle = json['module_title'];
    scheduledAt = json['scheduled_at'];
    durationInMinutes = json['duration_in_minutes'];
    liveStatus = json['live_status'];
    enrolledCount = json['enrolled_count'];
    zoomMeetingId = json['zoom_meeting_id'];
    zoomStartUrl = json['zoom_start_url'];
    zoomJoinUrl = json['zoom_join_url'];
    isReleased = json['is_released'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['course_id'] = this.courseId;
    data['course_title'] = this.courseTitle;
    data['module_title'] = this.moduleTitle;
    data['scheduled_at'] = this.scheduledAt;
    data['duration_in_minutes'] = this.durationInMinutes;
    data['live_status'] = this.liveStatus;
    data['enrolled_count'] = this.enrolledCount;
    data['zoom_meeting_id'] = this.zoomMeetingId;
    data['zoom_start_url'] = this.zoomStartUrl;
    data['zoom_join_url'] = this.zoomJoinUrl;
    data['is_released'] = this.isReleased;
    return data;
  }
}

class RecentUploads {
  int? id;
  String? title;
  String? courseTitle;
  String? contentType;

  RecentUploads({this.id, this.title, this.courseTitle, this.contentType});

  RecentUploads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    courseTitle = json['course_title'];
    contentType = json['content_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['course_title'] = this.courseTitle;
    data['content_type'] = this.contentType;
    return data;
  }
}
