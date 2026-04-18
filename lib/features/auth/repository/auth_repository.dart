import 'package:flutter/foundation.dart';
import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/auth/model/user_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:sakeena/network/app_url/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    final response = await _apiService.postData(AppUrls.login, data);

    if (kDebugMode) {
      debugPrint(response.toString());
    }
    if (response["refresh"] != null) {
      return response;
    } else if (response["detail"] != null) {
      return response;
    } else {
      return {};
    }
  }

  Future<UserResponse> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await _apiService.getData(
      AppUrls.getUser,
      authToken: await TokenStorage.getAccessToken(),
    );

    if (response["results"][0] != null) {
      UserResponse userResponse = UserResponse.fromJson(response);
      preferences.setString("role", userResponse.results!.first.role!);
      return userResponse;
    } else {
      return UserResponse();
    }
  }

  Future<Map<String, dynamic>> signUp(Map<String, dynamic> data) async {
    final response = await _apiService.postData(AppUrls.singUp, data);
    if (kDebugMode) {
      debugPrint(response.toString());
    }
   return response;
  }
}
