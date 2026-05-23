import 'package:flutter/material.dart';
import 'package:sakeena/features/student/home/model/student_dashboard_response.dart';
import 'package:sakeena/features/student/home/repository/student_dashboard_repository.dart';

class StudentDashboardProvider extends ChangeNotifier{
   StudentDashboardProvider(){
    init();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StudentDashboardResponse studentDashboardResponse = StudentDashboardResponse();

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
      final response = await StudentDashboardRepository().getStudentDashboard();
      studentDashboardResponse = response;
      notifyListeners();
    } catch (e) {
      // Handle error if needed
    } finally {
      setLoading(false);
    }
  }
}