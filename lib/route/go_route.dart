import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Auth
import 'package:sakeena/features/auth/auth_screens/forgot_password_page.dart';
import 'package:sakeena/features/auth/auth_screens/login_screen.dart';
import 'package:sakeena/features/auth/auth_screens/otp_page.dart';
import 'package:sakeena/features/auth/auth_screens/reset_password_page.dart';
import 'package:sakeena/features/auth/auth_screens/sign_up_screen.dart';
import 'package:sakeena/features/auth/auth_screens/splash_screen.dart';
import 'package:sakeena/features/auth/auth_screens/success_page.dart';

// Guest
import 'package:sakeena/features/guest/about/about_screen.dart';
import 'package:sakeena/features/guest/blog/blog_details_screen.dart';
import 'package:sakeena/features/guest/blog/blog_screen.dart';
import 'package:sakeena/features/guest/books/book_details_screen.dart';
import 'package:sakeena/features/guest/books/books_screen.dart';
import 'package:sakeena/features/guest/books/pdf_viewer_screen.dart';
import 'package:sakeena/features/guest/books/video_player_screen';
import 'package:sakeena/features/guest/consultation_screen.dart';
import 'package:sakeena/features/guest/contact/contact_screen.dart';
import 'package:sakeena/features/guest/course/course_details_screen.dart';
import 'package:sakeena/features/guest/course/course_screen.dart';
import 'package:sakeena/features/guest/course/live_course_registration_screen.dart';
import 'package:sakeena/features/guest/home_screen.dart';
import 'package:sakeena/features/guest/support/support_screen.dart';
import 'package:sakeena/features/guest/teachers/teacher_details_screen.dart';
import 'package:sakeena/features/guest/teachers/teachers_screen.dart';
import 'package:sakeena/features/guest/video/video_description_screen.dart';
import 'package:sakeena/features/guest/video/video_library_screen.dart';

// Student
import 'package:sakeena/features/student/course/my_course_screen.dart';
import 'package:sakeena/features/student/home/home_screen.dart';
import 'package:sakeena/features/student/live_class/student_live_class_screen.dart';
import 'package:sakeena/features/student/profile/privecy_policy_screen.dart';
import 'package:sakeena/features/student/profile/profile_and_settings_screen.dart';
import 'package:sakeena/features/student/profile/profile_screen.dart';
import 'package:sakeena/features/student/profile/terms_and_condition.dart';
import 'package:sakeena/features/student/teachers/teachers_screen.dart';

// Subscription
import 'package:sakeena/features/subscription/checkout/checkout_details_page.dart';
import 'package:sakeena/features/subscription/checkout/checkout_payment_page.dart';
import 'package:sakeena/features/subscription/checkout/checkout_success_page.dart';
import 'package:sakeena/features/subscription/subscription_screen.dart';
import 'package:sakeena/features/teachers/submission/presentation/screens/submission_management_page.dart';
import 'package:sakeena/route/guest_shell_route.dart';
import 'package:sakeena/route/shell_route_for_student.dart';
import 'package:sakeena/route/teachers_routes.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const forgot = '/forgot';
  static const otp = '/otp';
  static const reset = '/reset';
  static const success = '/success';

  static const guestHome = '/guest_home';
  static const howItWorks = '/how_it_works';
  static const subscription = '/subscription';
  static const coursesScreen = '/courses_screen'; // WITH navbar
  static const coursesStandalone = '/courses_standalone'; // WITHOUT navbar
  static const courseDetails = '/courses_details_screen';
  static const teachersScreen = '/teachers_screen';
  static const teacherDetails = '/teachers_details_screen';
  static const booksPage = '/books_screen';
  static const booksPdf = '/book_pdf';
  static const booksVideo = '/book_video';

  static const checkoutDetails = '/checkout/details';
  static const checkoutPayment = '/checkout/payment';
  static const checkoutSuccess = '/checkout/success';

  static const aboutScreen = '/about';
  static const blogScreen = '/blog_screen';
  static const blogDetailsScreen = '/blog/:id';
  static const videoLibraryScreen = '/video_library_screen';
  static const videoDescriptionScreen = '/video_description_screen';
  static const supportScreen = '/support_screen';
  static const contactScreen = '/contact_screen';

  // Student
  static const studentHomeScreen = '/student_home_screen';
  static const myCourseScreen = '/my_course_screen';
  static const teachersScreenForStudent = '/teachers_screen_for_student';
  static const studentProfilePage = '/student_profile_screen';
  static const studentLiveClass = '/student_live_class';
  static const privacyPolicyPage = '/privacy_policy_page';
  static const termsAndConditionsPage = '/terms_and_conditions_page';
  static const profileSettingsPage = '/profile_settings_page';
  static const LiveCourseRegistrationScreen =
      '/live_course_registration_screen';
}

GoRouter createRouter() {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.splash,
    routes: [
      ///Splash & Auth
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgot,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) => const OtpPage(),
      ),
      GoRoute(
        path: AppRoutes.reset,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.success,
        builder: (context, state) => const SuccessPage(),
      ),
      GoRoute(
        path: AppRoutes.courseDetails,
        builder: (context, state) => CourseDetailScreen(),
      ),
      // GoRoute(
      //   path: AppRoutes.courseDetails,
      //   builder: (context, state) => const CourseDetailsPage(),
      // ),
      GoRoute(
        path: '${AppRoutes.teacherDetails}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '1';
          return CounselorDetailPage(counselorId: id);
        },
      ),

      GoRoute(
        path: '/book_details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '1';
          return BookDetailsPage(bookId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.checkoutSuccess,
        builder: (context, state) => const CheckoutSuccessPage(),
      ),
      GoRoute(
        path: AppRoutes.checkoutDetails,
        builder: (context, state) => const CheckoutDetailsPage(),
      ),
      GoRoute(
        path: AppRoutes.checkoutPayment,
        builder: (context, state) => const CheckoutPaymentPage(),
      ),
      GoRoute(
        path: AppRoutes.videoDescriptionScreen,
        builder: (context, state) => const VideoDescriptionScreen(),
      ),
      GoRoute(
        path: AppRoutes.booksPage,
        builder: (context, state) => BooksPage(),
      ),
      GoRoute(
        path: AppRoutes.LiveCourseRegistrationScreen,
        builder: (context, state) => const LiveCourseRegistrationPage(),
      ),
      GoRoute(
        path: AppRoutes.blogScreen,
        builder: (context, state) => const BlogScreen(),
      ),
      GoRoute(
        path: AppRoutes.blogDetailsScreen,
        builder: (context, state) => const BlogDetailsPage(),
      ),
      GoRoute(
        path: AppRoutes.coursesStandalone,
        builder: (context, state) => const CoursesPage(),
      ),
      GoRoute(
        path: AppRoutes.subscription,
        builder: (context, state) => const SubscriptionPage(),
      ),
      GoRoute(
  path: AppRoutes.booksPdf,
  name: 'pdfViewer',
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>? ?? {};
    return PDFViewerPage(
      title: extra['title'] ?? 'Book',
      pdfPath: extra['pdfPath'] ?? 'assets/documents/default.pdf',
    );
  },
),
GoRoute(
  path: AppRoutes.booksVideo,
  name: 'videoPlayer',
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>? ?? {};
    return VideoPlayerPage(
      title: extra['title'] ?? 'Book',
      videoPath: extra['videoPath'] ?? 'assets/videos/default.mp4',
    );
  },
),


      /// GUEST SHELL (GLOBAL BOTTOM NAV + DRAWER)
      ShellRoute(
        builder: (context, state, child) {
          return GuestShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.guestHome,
            builder: (context, state) => const GuestHomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.howItWorks,
            builder: (context, state) => const ConsultationScreen(),
          ),

          GoRoute(
            path: AppRoutes.coursesScreen,
            builder: (context, state) => const CoursesPage(),
          ),

          GoRoute(
            path: AppRoutes.teachersScreen,
            builder: (context, state) => const TeachersScreen(),
          ),

          GoRoute(
            path: AppRoutes.aboutScreen,
            builder: (context, state) => const AboutScreen(),
          ),

          GoRoute(
            path: AppRoutes.videoLibraryScreen,
            builder: (context, state) => const VideoLibraryScreen(),
          ),

          GoRoute(
            path: AppRoutes.supportScreen,
            builder: (context, state) => const SupportScreen(),
          ),
          GoRoute(
            path: AppRoutes.contactScreen,
            builder: (context, state) => ContactScreen(),
          ),
        ],
      ),

      /// STUDENT SHELL (GLOBAL BOTTOM NAV + DRAWER)
      ShellRoute(
        builder: (context, state, child) {
          return StudentShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.studentHomeScreen,
            builder: (context, state) => StudentHomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.myCourseScreen,
            builder: (context, state) => MyCourseScreen(),
          ),
          GoRoute(
            path: AppRoutes.videoLibraryScreen,
            builder: (context, state) => const VideoLibraryScreen(),
          ),
          GoRoute(
            path: AppRoutes.teachersScreenForStudent,
            builder: (context, state) => TeachersScreenForStudent(),
          ),
          GoRoute(
            path: AppRoutes.studentLiveClass,
            builder: (context, state) => StudentLiveClassPage(),
          ),
          GoRoute(
            path: AppRoutes.studentProfilePage,
            builder: (context, state) => ProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.privacyPolicyPage,
            builder: (context, state) => PrivacyPolicyPage(),
          ),
          GoRoute(
            path: AppRoutes.termsAndConditionsPage,
            builder: (context, state) => TermsAndConditionsPage(),
          ),
          GoRoute(
            path: AppRoutes.profileSettingsPage,
            builder: (context, state) => ProfileSettingsPage(),
          ),
        ],
      ),
      // Teachers route defined in #teachers_routes.dart
      ...TeachersRoutes.getRoutes(),
    ],
  );
}
