import 'package:flutter/widgets.dart';
import 'package:sakeena/features/teachers/content/model/content_details_response.dart';
import 'package:sakeena/features/teachers/content/model/content_response.dart';
import 'package:sakeena/features/teachers/content/repository/content_repository.dart';

class ContentController extends ChangeNotifier{
  ContentResponse contentResponse = ContentResponse();
  ContentDetailsResponse contentDetailsResponse = ContentDetailsResponse();
  bool isLoading = false;

  Future<void> getContent()async{
    isLoading = true;
    notifyListeners();
    final response = await ContentRepository().fetchContent();
    contentResponse = response;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getContentDetails(String slug)async{
    isLoading = true;
    notifyListeners();
    final response = await ContentRepository().fetchContentDetails(slug);
    contentDetailsResponse = response;
    isLoading = false;
    notifyListeners();
  }
}