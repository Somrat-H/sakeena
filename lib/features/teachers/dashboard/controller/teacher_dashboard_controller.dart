import 'package:flutter/material.dart';
import 'package:sakeena/features/teachers/dashboard/model/teacher_dashboard_response.dart';
import 'package:sakeena/features/teachers/dashboard/repository/teacher_dashboard_repository.dart';

class TeacherDashboardController extends ChangeNotifier{
  TeacherDashboardController(){
    init();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TeacherDashboardResponse teacherDashboardResponse = TeacherDashboardResponse();

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> init() async {
    await fetchTeacherDashboard();
  }

  Future<void> fetchTeacherDashboard()async{
    setLoading(true);
    try {
      final response = await TeacherDashboardRepository().getTeacherDashboard();
      teacherDashboardResponse = response;
    } catch (e) {
      // Handle error if needed
    } finally {
      setLoading(false);
    }
  }
}