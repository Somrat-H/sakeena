import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/teachers/course_detail/model/course_details_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:sakeena/network/app_url/app_urls.dart';

class TeacherCourseDetailsRepository {
  final ApiService _apiService = ApiService();
    Future<CouseDeatilsResponse> getCourseDetails(int id)async{
    final response = await _apiService.getData(AppUrls.getCourseDetails(id), authToken: await TokenStorage.getAccessToken());
    return CouseDeatilsResponse.fromJson(response);
  }

   Future<Map<String, dynamic>> emorollment(Map<String, dynamic> data)async{
    final response = await _apiService.postData("/orders/direct/",
    data,
     authToken: await TokenStorage.getAccessToken());
    return response;
  }
}