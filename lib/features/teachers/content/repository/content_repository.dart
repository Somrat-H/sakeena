import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/auth/repository/auth_repository.dart';
import 'package:sakeena/features/teachers/content/model/content_details_response.dart';
import 'package:sakeena/features/teachers/content/model/content_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentRepository {
  final ApiService apiService = ApiService();
  Future<ContentResponse> fetchContent()async{
    
    final response = await apiService.getDataJwt("/blogs/my-blogs/", authToken: await TokenStorage.getAccessToken() ?? "");
    return ContentResponse.fromJson(response); 
  }

  Future<ContentDetailsResponse> fetchContentDetails(String slug)async{
    final response = await apiService.getDataJwt("/blogs/$slug/", authToken: await TokenStorage.getAccessToken() ?? "");
    return ContentDetailsResponse.fromJson(response);
  }
}