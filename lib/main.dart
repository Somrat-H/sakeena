import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/features/auth/controller/auth_controller.dart';
import 'package:sakeena/features/student/course/provider/student_course_provider.dart';
import 'package:sakeena/features/student/home/provider/student_dashboard_provider.dart';
import 'package:sakeena/features/student/profile/controller/profile_controller.dart';
import 'package:sakeena/features/teachers/content/controller/content_controller.dart';
import 'package:sakeena/features/teachers/course_detail/controller/teacher_course_details_controller.dart';
import 'package:sakeena/features/teachers/courses/controller/teacher_course_controller.dart';
import 'package:sakeena/features/teachers/dashboard/controller/teacher_dashboard_controller.dart';
import 'package:sakeena/features/teachers/profile/controller/teacher_profile_controller.dart';
import 'package:sakeena/features/teachers/submission/presentation/providers/submission_provider.dart';
import 'package:sakeena/route/go_route.dart'; // assuming this exports createRouter()
import 'package:sakeena/view_model/auth_view_model.dart';
import 'package:sakeena/view_model/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  final router = createRouter();

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  static const Color primaryColor = Color(0xFF2C7A7B);
  static const Color backgroundColor = Color(0xFFFFFEF8);
  static const Color notificationDotColor = Color(0xFFE53E3E);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => AuthControlle()),
            ChangeNotifierProvider(
              create: (_) => ProfileController()..fetchStudentProfile(),
            ),
            ChangeNotifierProvider(
              create: (_) => TeacherProfileController()..fetchTeacherProfile(),
            ),
            // ChangeNotifierProvider(
            //   create: (_) => TeacherCourseController()..getCourseCategory()..getTeacherCourse(),
            // ),
            ChangeNotifierProvider(
              create: (_) => StudentCourseProvider()..getCourseCategory()..getStudentCourse(),
            ),
            ChangeNotifierProvider(create: (_) => SubmissionProvider()),
            ChangeNotifierProvider(create: (_) => TeacherDashboardController()),
            ChangeNotifierProvider(create: (_)=> ContentController()..getContent()),
              ChangeNotifierProvider(create: (_) => StudentDashboardProvider()),
               ChangeNotifierProvider(create: (_) => TeacherCourseDetailsController()),
            
          ],
          child: MaterialApp.router(
            title: 'Sakeena Institute',
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: primaryColor,
                brightness: Brightness.light,
                primary: primaryColor,
                surface: backgroundColor,
              ),
              scaffoldBackgroundColor:
                  Colors.transparent, // important for gradient
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 14.sp)),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: primaryColor,
                brightness: Brightness.dark,
              ),
            ),
            themeMode: ThemeMode.light,

            // ✅ Wrap all screens globally with gradient
            builder: (context, child) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: AppTheme.backgroundGradient,
                ),
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
