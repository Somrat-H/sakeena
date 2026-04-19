import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/teachers/profile/model/teacher_profile_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:sakeena/network/app_url/app_urls.dart';

class TeacherProfileRepository {
   final ApiService _apiService = ApiService();

  Future<TeacherProfileResponse> getTeacherProfile()async{
    final response = await _apiService.getData(AppUrls.getTeacherProfile, authToken: await TokenStorage.getAccessToken());
    return TeacherProfileResponse.fromJson(response);
  }

  Future<TeacherProfileResponse> updateTeacherProfile(Map<String, dynamic> data, File? image)async{

    if(image != null){
      final response = await _apiService.patchData(AppUrls.updateTeacherProfile, data, image: image, imageParamName: "profile_picture", authToken: await TokenStorage.getAccessToken());
      if(kDebugMode){
        debugPrint(response.toString());
      }
      return TeacherProfileResponse.fromJson(response);
    }else{
      final response = await _apiService.patchData(AppUrls.updateTeacherProfile, data, authToken: await TokenStorage.getAccessToken());
      return TeacherProfileResponse.fromJson(response);
    }
    
  }
}