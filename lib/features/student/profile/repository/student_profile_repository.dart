import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/student/profile/model/student_profile_response.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:sakeena/network/app_url/app_urls.dart';

class StudentProfileRepository {

  final ApiService _apiService = ApiService();

  Future<StundeProfileResponse> getStudentProfile()async{
    final response = await _apiService.getData(AppUrls.getStudentProfile, authToken: await TokenStorage.getAccessToken());
    return StundeProfileResponse.fromJson(response);
  }

  Future<StundeProfileResponse> updateStudentProfile(Map<String, dynamic> data, File? image)async{

    if(image != null){
      final response = await _apiService.patchData(AppUrls.getStudentProfile, data, image: image, imageParamName: "profile_picture", authToken: await TokenStorage.getAccessToken());
      if(kDebugMode){
        debugPrint(response.toString());
      }
      return StundeProfileResponse.fromJson(response);
    }else{
      final response = await _apiService.patchData(AppUrls.getStudentProfile, data, authToken: await TokenStorage.getAccessToken());
      return StundeProfileResponse.fromJson(response);
    }
    
  }
}