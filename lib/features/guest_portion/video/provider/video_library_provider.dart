import 'package:flutter/material.dart';
import 'package:sakeena/features/guest_portion/video/model/video_library_model.dart';
import 'package:sakeena/network/api_service/api_service.dart';
import 'package:sakeena/network/app_url/app_urls.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // <-- Add this import

class VideoLibraryProvider extends ChangeNotifier {
  VideLibraryModel videLibraryModel = VideLibraryModel();
  bool isLoading = false;

  


  Future<void> getVideos() async {
    isLoading = true;
    notifyListeners();
    final response = await ApiService().getData("/videos/");
    if (response.isNotEmpty) {
      videLibraryModel = VideLibraryModel.fromJson(response);
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

    Future<void> getVideosSearch(String name, String value) async {
    isLoading = true;
    notifyListeners();
    final response = await ApiService().getData("/videos/?$name=$value");
    if (response.isNotEmpty) {
      videLibraryModel = VideLibraryModel.fromJson(response);
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

}