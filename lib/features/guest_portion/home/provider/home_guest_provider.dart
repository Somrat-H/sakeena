import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sakeena/features/guest_portion/home/model/blog_details_model.dart';
import 'package:sakeena/features/guest_portion/home/model/blog_model.dart';
import 'package:sakeena/features/guest_portion/home/model/book_details_model.dart';
import 'package:sakeena/features/guest_portion/home/model/books_model.dart';
import 'package:sakeena/features/guest_portion/home/model/bundle_details_model.dart';
import 'package:sakeena/features/guest_portion/home/model/bundle_model.dart';
import 'package:sakeena/features/guest_portion/home/model/course_review_model.dart';
import 'package:sakeena/features/guest_portion/home/model/doors_model.dart';
import 'package:sakeena/features/guest_portion/home/model/faculty_details_model.dart';
import 'package:sakeena/features/guest_portion/home/model/faculty_model.dart';
import 'package:sakeena/features/guest_portion/home/model/subscription_plan_model.dart';
import 'package:sakeena/features/student/course/model/student_course_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';

class HomeGuestProvider extends ChangeNotifier {
  HomeGuestProvider() {
    init();
  }

  void init() async {
    await getDoors();
    await getCourse();
    await getPlan();
    await getBundle();
    await getBooks();
    await getBlog();
    await getFaculty();
  }

  List<DoorsModel> doorsModel = [];
  bool isDoorsLoading = false;
  bool isDetailsLaoding = false;

  StudentCourseResponse course = StudentCourseResponse();

  SubscriptionPlanModel subscriptionPlanModel = SubscriptionPlanModel();

  BundleModel bundleModel = BundleModel();

  BooksModel booksModel = BooksModel();

  BlogModel blogModel = BlogModel();

  FacultyModel facultyModel = FacultyModel();
  
  FacultyModel consultationMemberList = FacultyModel();

  FacultyDetailsModel consultationMemberDeatils = FacultyDetailsModel();
    FacultyDetailsModel facultyDetailsModel = FacultyDetailsModel();
  BundleDetailsModel bundleDetailsModel = BundleDetailsModel();
  BookDetailsModel bookDetailsModel = BookDetailsModel();
  BlogDetailsModel blogDetailsModel = BlogDetailsModel(); 

  CourseReviewModel courseReviewModel = CourseReviewModel();

  Future<void> getDoors() async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getList("/doors");
      if (response.isNotEmpty) {
        doorsModel = response.map((e) => DoorsModel.fromJson(e)).toList();
        notifyListeners();
      } else {
        doorsModel = []; // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      doorsModel = [];
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCourse() async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/courses");
      if (response.isNotEmpty) {
        course = StudentCourseResponse.fromJson(response);
        notifyListeners();
      } else {
        course =
            StudentCourseResponse(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      course = StudentCourseResponse();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }
   Future<void> getCourseByFilter(String name,String value) async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/courses/?$name=$value");
      if (response.isNotEmpty) {
        course = StudentCourseResponse.fromJson(response);
        notifyListeners();
      } else {
        course =
            StudentCourseResponse(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      course = StudentCourseResponse();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getPlan() async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/membership/plan/");
      if (response.isNotEmpty) {
        subscriptionPlanModel = SubscriptionPlanModel.fromJson(response);
        notifyListeners();
      } else {
        subscriptionPlanModel =
            SubscriptionPlanModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      subscriptionPlanModel = SubscriptionPlanModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getBundle() async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/bundles/");
      if (response.isNotEmpty) {
        bundleModel = BundleModel.fromJson(response);
        notifyListeners();
      } else {
        bundleModel =
            BundleModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      bundleModel = BundleModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getBooks() async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/books/");
      if (response.isNotEmpty) {
        booksModel = BooksModel.fromJson(response);
        notifyListeners();
      } else {
        booksModel =
            BooksModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      booksModel = BooksModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getBlog() async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/blogs/");
      if (response.isNotEmpty) {
        blogModel = BlogModel.fromJson(response);
        notifyListeners();
      } else {
        blogModel =
            BlogModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      blogModel = BlogModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }
Future<void> getBlogByFilter(String name,String value) async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/blogs/?$name=$value");
      if (response.isNotEmpty) {
        blogModel = BlogModel.fromJson(response);
        notifyListeners();
      } else {
        blogModel =
            BlogModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      blogModel = BlogModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getFaculty() async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/teacher-profiles/");
      if (response.isNotEmpty) {
        facultyModel = FacultyModel.fromJson(response);
        notifyListeners();
      } else {
        facultyModel =
            FacultyModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      facultyModel = FacultyModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }
  

  
  Future<void> getConsultationList(String name, String value) async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/teacher-profiles/?offers_consultations=true&$name=$value");
      if (response.isNotEmpty) {
        consultationMemberList = FacultyModel.fromJson(response);
        notifyListeners();
      } else {
        consultationMemberList =
            FacultyModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      consultationMemberList = FacultyModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }
  
  
  Future<void> getFacultyFilter(String name,String value) async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/teacher-profiles/?$name=$value");
      if (response.isNotEmpty) {
        facultyModel = FacultyModel.fromJson(response);
        notifyListeners();
      } else {
        facultyModel =
            FacultyModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      facultyModel = FacultyModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getBundleDetails(int id) async {
    isDetailsLaoding = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/bundles/$id/");
      if (response.isNotEmpty) {
        bundleDetailsModel = BundleDetailsModel.fromJson(response);
        notifyListeners();
      } else {
        bundleDetailsModel =
            BundleDetailsModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      bundleDetailsModel = BundleDetailsModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDetailsLaoding = false;
      notifyListeners();
    }
  }

   Future<void> getBookDetails(String slug) async {
    isDetailsLaoding = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/books/$slug/");
      if (response.isNotEmpty) {
        bookDetailsModel = BookDetailsModel.fromJson(response);
        notifyListeners();
      } else {
        bookDetailsModel =
            BookDetailsModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      bookDetailsModel = BookDetailsModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDetailsLaoding = false;
      notifyListeners();
    }
  }
   Future<void> getBlogDetails(String slug) async {
    isDetailsLaoding = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/blogs/$slug/");
      if (response.isNotEmpty) {
        blogDetailsModel = BlogDetailsModel.fromJson(response);
        notifyListeners();
      } else {
        blogDetailsModel =
            BlogDetailsModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      blogDetailsModel = BlogDetailsModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDetailsLaoding = false;
      notifyListeners();
    }
  }

  //course review
  Future<void> getCourseReview(int id) async {
    isDoorsLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/courses/$id/reviews/");
      if (response.isNotEmpty) {
        courseReviewModel = CourseReviewModel.fromJson(response);
        notifyListeners();
      } else {
        courseReviewModel =
            CourseReviewModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      courseReviewModel = CourseReviewModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDoorsLoading = false;
      notifyListeners();
    }
  }

  Future<void> getConsultationDetails(int id) async {
    isDetailsLaoding = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/teacher-profiles/$id/");
      if (response.isNotEmpty) {
        consultationMemberDeatils = FacultyDetailsModel.fromJson(response);
        notifyListeners();
      } else {
        consultationMemberDeatils =
            FacultyDetailsModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      consultationMemberDeatils = FacultyDetailsModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDetailsLaoding = false;
      notifyListeners();
    }
  }
    Future<void> getFacultyDetails(int id) async {
    isDetailsLaoding = true;
    notifyListeners();

    try {
      final response = await ApiService().getData("/teacher-profiles/$id/");
      if (response.isNotEmpty) {
        facultyDetailsModel = FacultyDetailsModel.fromJson(response);
        notifyListeners();
      } else {
        facultyDetailsModel =
            FacultyDetailsModel(); // Explicitly clear data if API returns an empty list
      }
    } catch (e) {
      debugPrint("Error fetching doors: $e");
      facultyDetailsModel = FacultyDetailsModel();
    } finally {
      // Safely toggle loaders off regardless of network errors
      isDetailsLaoding = false;
      notifyListeners();
    }
  }
  //scroll controller portion
  //for course
  final ScrollController courseScrollController = ScrollController();

  final ScrollController blogScrollController = ScrollController();

  final ScrollController bookScrollController = ScrollController();

  // Scroll carousel views sequentially to the left or right manually via buttons
  void scroll(bool forward, ScrollController controller) {
    double targetOffset = forward
        ? controller.offset +
              340 // Shifts roughly two cards forward
        : controller.offset - 340;

    controller.animateTo(
      targetOffset.clamp(0.0, controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    courseScrollController.dispose();
  }
}
