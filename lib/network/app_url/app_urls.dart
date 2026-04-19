class AppUrls {
  static String baseUrl = "http://10.10.13.8:8000";

  //auth

  static String login = "/auth/jwt/create/";

  static String getUser = "/auth/users/";

  static String singUp = "/auth/users/";



  //student
  static String getStudentProfile ="/student-profiles/me/";



  //teacher
  static String getTeacherProfile ="/teacher-profiles/me" ;

  static String updateTeacherProfile = "/teacher-profiles/";

  static String getTeacherCourse = "/courses";

  static String getCourseCategory = "/course-categories";

  static String getCourseDetails(int id) => "/courses/$id";

}