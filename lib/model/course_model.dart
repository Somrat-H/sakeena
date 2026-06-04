// // ============ DATA MODELS ============
import 'package:sakeena/model/course_details_model.dart';
import 'package:sakeena/model/course_module_model.dart';
import 'package:sakeena/model/course_review_model.dart';
import 'package:sakeena/model/instructior_data_model.dart';
import 'package:sakeena/model/quiz_question_model.dart';

// // ============ ENUMS ============
enum CourseStatus { upcoming, live, recorded }

enum EnrollmentStatus { notEnrolled, enrolled, completed }

class CourseData {
  final String title;
  final String imageAsset;
  final String price;
  final CourseStatus courseStatus;
  final EnrollmentStatus enrollmentStatus;
  final String description;
  final List<String> outcomes;
  final List<CourseModule> modules;
  final CourseDetails courseDetails;
  final InstructorData instructor;
  final List<String> requirements;
  final List<Review> reviews;

  const CourseData({
    required this.title,
    required this.imageAsset,
    required this.price,
    required this.courseStatus,
    required this.enrollmentStatus,
    required this.description,
    required this.outcomes,
    required this.modules,
    required this.courseDetails,
    required this.instructor,
    required this.requirements,
    this.reviews = const [],
  });




}
