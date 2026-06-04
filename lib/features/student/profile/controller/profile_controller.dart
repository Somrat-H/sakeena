import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/student/profile/model/student_profile_response.dart';
import 'package:sakeena/features/student/profile/repository/student_profile_repository.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends ChangeNotifier {

 void init()async {
  if(TokenStorage.getAccessToken() != null){
      await fetchStudentProfile();
  }
  }

  StundeProfileResponse stundetProfileResponse = StundeProfileResponse();
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  File? get pickedImage => _pickedImage;

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80, // Reduces size for faster upload
      );
      if (image != null) {
        _pickedImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  bool isEditing = false;

  final Map<String, bool> passwordVisibility = {
    'current': false,
    'new': false,
    'confirm': false,
  };

  void toggleEditing() {
    isEditing = !isEditing;
    notifyListeners();
  }

  void toggleVisibility(String key) {
    passwordVisibility[key] = !(passwordVisibility[key] ?? false);
    notifyListeners();
  }

  Future<void> fetchStudentProfile() async {
    isLoading = true;
    notifyListeners();
    final response = await StudentProfileRepository().getStudentProfile();
    stundetProfileResponse = response;
    isLoading = false;
    notifyListeners();
  }

  Future<bool> updateStundentProfile() async {
    isLoading = true;
    notifyListeners();
    final response = await StudentProfileRepository().updateStudentProfile({
      "email": stundetProfileResponse.email,
      "first_name": stundetProfileResponse.firstName,
      "last_name": stundetProfileResponse.lastName,
      "phone_number": stundetProfileResponse.phoneNumber,
      "location": stundetProfileResponse.location,
    }, _pickedImage);

  

    if (response.id != null) {
      stundetProfileResponse = response;
      isLoading = false;
      notifyListeners();
      return true;
    } else {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
