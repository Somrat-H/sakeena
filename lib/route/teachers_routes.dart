import 'package:go_router/go_router.dart';
import 'package:sakeena/features/student/profile/view/profile_and_settings_screen.dart';
import 'package:sakeena/features/teachers/consultation_page/consultation_page.dart';
import 'package:sakeena/features/teachers/content/upload_content/content_details_screen.dart';
import 'package:sakeena/features/teachers/earnings/earnings_screen.dart';
import 'package:sakeena/features/teachers/landing_page/landing_page.dart';
import 'package:sakeena/features/teachers/profile/views/profile_preview_screen.dart';
import 'package:sakeena/features/teachers/submission/presentation/screens/grade_submission_screen.dart';
import 'package:sakeena/features/teachers/submission/presentation/screens/quiz_review_page.dart';
import 'package:sakeena/features/teachers/submission/presentation/screens/submission_details_screen.dart';
import 'package:sakeena/features/teachers/submission/presentation/screens/submission_management_page.dart';
import 'package:sakeena/features/teachers/content/upload_content/content_home.dart';
import 'package:sakeena/features/teachers/content/upload_content/upload_new_content.dart';
import '../features/teachers/course_detail/view/teacher_course_detail_screen.dart';
import '../features/teachers/courses/view/my_courses_screen.dart';
import '../features/teachers/create_course/create_course_screen.dart';
import '../features/teachers/dashboard/view/dashboard_screen.dart';
import '../features/teachers/profile/views/profile_screen.dart';

class TeachersRoutes {
  static const String dashboard = '/teachers/dashboard';
  static const String profile = '/teachers/profile';
  static const String profilePreview = '/teachers/profile_preview';
  static const String myCourses = '/teachers/my-courses';
  static const String message = "/message";
  static const String createCourse = '/teachers/create-course';
  static const String courseDetail = '/teachers/course-detail';
  static const String menu = "/menu";
  static const String consultation = "/consultation";
  static const consultationManagement = "/consultation-management";

  static const String uploadContent = "/upload-content";
  static const String uploadNewContent = "/upload-new-content";
  static const String earnings = "/earnings";
  static const String settings = "/settings";
  static const String submissions = "/submissions";

  static String contentDetails = "/content-details";

  static List<RouteBase> getRoutes() {
    return [
      ShellRoute(
        builder: (context, state, child) => LandingPageTeacher(child: child),
        routes: [
          GoRoute(
            path: dashboard,
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: myCourses,
            builder: (context, state) => const MyCoursesScreen(),
          ),
          GoRoute(
            path: consultation,
            builder: (context, state) => const ConsultationManagementScreen(),
          ),
          GoRoute(
            path: uploadContent,
            builder: (context, state) => const ContentHomePage(),
          ),

          GoRoute(
            path: earnings,
            builder: (context, state) => const EarningsScreen(),
          ),
          GoRoute(
            path: settings,
            builder: (context, state) => const ProfileSettingsPage(),
          ),
          GoRoute(
            path: profile,
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '${TeachersRoutes.profilePreview}/:id',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '1';
              return CounselorPreviewPage(counselorId: id);
            },
          ),
        ],
      ),
      GoRoute(
        path: uploadNewContent,
        builder: (context, state) => const UploadContentScreen(),
      ),
      GoRoute(
        path: contentDetails,
        builder: (context, state) {
          final slug = state.extra as String;
          return BlogDetailsScreen(slug: slug);
        },
      ),
      GoRoute(
        path: dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: courseDetail,
        builder: (context, state) {
          final id = state.extra as int;
          return TeacherCourseDetails(courseId: id);
        },
      ),
      GoRoute(
        path: myCourses,
        builder: (context, state) => const MyCoursesScreen(),
      ),
      GoRoute(
        path: createCourse,
        builder: (context, state) => const CreateCourseScreen(),
      ),

      // GoRoute(
      //   path: courseDetail,
      //   builder: (context, state) => const CourseDetailScreen(),
      // ),
      // Add more teacher-specific routes here
      GoRoute(
        path: TeachersRoutes.submissions,
        builder: (context, state) => const SubmissionManagementPage(),
      ),
      GoRoute(
        path: '/submission/detail/:id',
        builder: (context, state) =>
            SubmissionDetailPage(submissionId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/submission/grade/:id',
        builder: (context, state) =>
            GradeSubmissionPage(submissionId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/submission/quiz-review/:id',
        builder: (context, state) =>
            QuizReviewPage(quizId: state.pathParameters['id']!),
      ),
    ];
  }

  TeachersRoutes._();
}
