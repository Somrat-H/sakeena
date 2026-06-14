import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Auth
import 'package:sakeena/features/auth/auth_screens/forgot_password_page.dart';
import 'package:sakeena/features/auth/auth_screens/login_screen.dart';
import 'package:sakeena/features/auth/auth_screens/otp_page.dart';
import 'package:sakeena/features/auth/auth_screens/reset_password_page.dart';
import 'package:sakeena/features/auth/auth_screens/sign_up_screen.dart';
import 'package:sakeena/features/auth/auth_screens/splash_screen.dart';
import 'package:sakeena/features/auth/auth_screens/success_page.dart';
import 'package:sakeena/features/guest_portion/blogs/blogs_guest_screen.dart';
import 'package:sakeena/features/guest_portion/book/books_guest_screen.dart';
import 'package:sakeena/features/guest_portion/cart/presentation/cart_screen.dart';
import 'package:sakeena/features/guest_portion/consultation/consultation_guest_screen.dart';
import 'package:sakeena/features/guest_portion/course/course_guest_screen.dart';
import 'package:sakeena/features/guest_portion/faculty/faculty_details_screen.dart';
import 'package:sakeena/features/guest_portion/faculty/faculty_guest_screen.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';
import 'package:sakeena/features/guest_portion/home/view/books/books_details_page.dart';
import 'package:sakeena/features/guest_portion/home/view/books/widget/online_pdf_view_page.dart';
import 'package:sakeena/features/guest_portion/home/view/books/widget/online_video_player_page.dart';
import 'package:sakeena/features/guest_portion/home/view/guest_home_page.dart';
import 'package:sakeena/features/guest_portion/video/model/video_library_model.dart';
import 'package:sakeena/features/guest_portion/video/presentation/video_description_screen.dart';
import 'package:sakeena/features/guest_portion/video/presentation/video_library_screen.dart';

// Student
import 'package:sakeena/features/student/course/my_course_screen.dart';
import 'package:sakeena/features/student/home/home_screen.dart';
import 'package:sakeena/features/student/live_class/student_live_class_screen.dart';
import 'package:sakeena/features/student/profile/view/privecy_policy_screen.dart';
import 'package:sakeena/features/student/profile/view/profile_and_settings_screen.dart';
import 'package:sakeena/features/student/profile/view/profile_screen.dart';
import 'package:sakeena/features/student/profile/view/terms_and_condition.dart';
import 'package:sakeena/features/student/teachers/teachers_screen.dart';

// Subscription
import 'package:sakeena/features/subscription/checkout/checkout_details_page.dart';
import 'package:sakeena/features/subscription/checkout/checkout_payment_page.dart';
import 'package:sakeena/features/subscription/checkout/checkout_success_page.dart';
import 'package:sakeena/features/teachers/course_detail/view/teacher_course_detail_screen.dart';

import 'package:sakeena/route/guest_shell.dart';
import 'package:sakeena/route/shell_route_for_student.dart';
import 'package:sakeena/route/teachers_routes.dart';

import '../features/guest_portion/consultation/consultation_details_guest_screen.dart'
    hide HomeGuestProvider;
import '../features/guest_portion/home/view/blog/blog_details_page.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const forgot = '/forgot';
  static const otp = '/otp';
  static const reset = '/reset';
  static const success = '/success';

  // static const guestHome = '/guest_home';
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
  static const blogDetails = '/blog';
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
  static String teacherCourseDetails = '/teacher_course_details';

  //guest portion

  static const homeGuest = "/guest-home";
  static const courseGuest = "/guest-course";
  static const bookGuest = "/guest-books";
  static const blogsGuest = "/guest-blogs";
  static const facultyGuest = "/guest-faculty";
  static String bookDetails = "/book-details";
  static String onlinePdfView = "/online-pdf-view";
  static String onlineVideoView = "/online-video-view";
  static String consultationGuest = "/guest-consultation";
  static String consultationDetails = "/guest-consultation-details";

   static const String courseDetail = '/teachers/course-detail';
  

  //login user/student
  static String book = "/book";
  
  static String facultyDetails = "/faculty-details";

  static String cart = "/cart";
}

GoRouter createRouter() {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation:   AppRoutes.splash,
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
        path: AppRoutes.courseDetail,
        builder: (context, state) {
          final id = state.extra as int;
          return TeacherCourseDetails(courseId: id);
        },
      ),

      //guest view
      ShellRoute(
        builder: (context, state, child) {
          return GuestShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.homeGuest,
            builder: (context, state) => GuestHomePage(),
          ),
          GoRoute(
            path: AppRoutes.courseGuest,
            builder: (context, state) => CourseGuestScreen(),
          ),

          GoRoute(
            path: AppRoutes.consultationGuest,
            builder: (context, state) => ConsultationGuestScreen(),
          ),
          GoRoute(
            path: AppRoutes.bookGuest,
            builder: (context, state) => BooksGuestScreen(),
          ),
          GoRoute(
            path: AppRoutes.blogsGuest,
            builder: (context, state) => BlogsGuestScreen(),
          ),
        ],
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
       GoRoute(
        path: AppRoutes.videoLibraryScreen,
        builder: (context, state) => VideoLibraryScreen(),
      ),
       GoRoute(
        path: AppRoutes.videoDescriptionScreen,
        builder: (context, state) {
          final data = state.extra as Videos;
          return VideoDetailsScreen(videoData: data,);
        },
      ),
      GoRoute(
        path: AppRoutes.facultyDetails,
        builder: (context, state) =>  FacultyDetailsScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.facultyGuest,
        builder: (context, state) => FacultyGuestScreen(),
      ),
      
       GoRoute(
        path: AppRoutes.cart,
        builder: (context, state) => CartViewScreen(),
      ),

      GoRoute(
        path: AppRoutes.bookDetails,
        builder: (context, state) {
          final slug = state.extra.toString();
          return BookDetailsScreen(slug: slug);
        },
      ),
      GoRoute(
        path: AppRoutes.consultationDetails,
        builder: (context, state) {
          final slug = state.extra.toString();
          return ConsultantDetailsScreen();
        },
      ),
      GoRoute(
        path: '/pdf-viewer',
        name: AppRoutes.onlinePdfView,
        builder: (context, state) {
          // Read parameters safely from the location state query parameters
          final url = state.uri.queryParameters['url'] ?? '';
          final title = state.uri.queryParameters['title'] ?? 'Document Sample';
          return OnlinePdfViewerPage(pdfUrl: url, title: title);
        },
      ),
      GoRoute(
        path: '/video-player',
        name: AppRoutes.onlineVideoView,
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? '';
          final title = state.uri.queryParameters['title'] ?? 'Video Preview';
          return OnlineVideoPlayerPage(videoUrl: url, title: title);
        },
      ),
      GoRoute(
        path: AppRoutes.blogDetails,
        name: 'blogDetails',
        builder: (context, state) {
          final slug = state.extra.toString();

          // Call the network API data load process directly before initializing rendering steps
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<HomeGuestProvider>().getBlogDetails(slug);
          });

          return BlogDetailsScreen(slug: slug);
        },
      ),
    ],
  );
}
