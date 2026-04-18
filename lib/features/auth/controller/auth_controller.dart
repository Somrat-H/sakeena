import 'package:flutter/material.dart';
import 'package:sakeena/core/storage/token_manager.dart';
import 'package:sakeena/features/auth/model/user_response.dart';
import 'package:sakeena/features/auth/repository/auth_repository.dart';
import 'package:sakeena/widgets/custom_snackbar.dart';

class AuthControlle extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _resetEmail;
  String? get resetEmail => _resetEmail;

  String email = "";
  String password = "";
  

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  UserResponse userResponse = UserResponse();

  String name = "";

  Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final response = await AuthRepository().login({
      "email": email,
      "password": password,
    });

    if (response["access"] != null && response["refresh"] != null) {
      TokenStorage.saveTokens(response["access"], response["refresh"]);
      notifyListeners();
      await getUser();
      if (context.mounted) {
        CustomSnackbar.show(context, message: "Login Successfully");
      }
      _isLoading = false;
      notifyListeners();

      return true;
    } else if (response["detail"] != null) {
      if (context.mounted) {
        CustomSnackbar.show(
          context,
          message: response["detail"],
          backgroundColor: Colors.red,
        );
      }

      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      return false;
    }
  }

  Future<bool> getUser() async {
    final response = await AuthRepository().getUser();

    if (response.results!.isNotEmpty) {
      userResponse = response;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signup(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final response = await AuthRepository().signUp({
      "email": email,
      "password": password,
      "first_name": name,
      "last_name": name,
      "re_password": password,
    });

    if (response["id"] != null) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        CustomSnackbar.show(context, message: "Account Created Successfully");
      }
      return true;
    } else if (response["password"] != null) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        CustomSnackbar.show(context, message: response["password"][0], backgroundColor: Colors.red);
      }
      return false;
    } else if (response["email"] != null) {
      _isLoading = false;
      notifyListeners();
      if (context.mounted) {
        CustomSnackbar.show(context, message: response["email"][0], backgroundColor: Colors.red);
      }
      return false;
    } else {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> sendResetCode({
    required String email,
    required VoidCallback onSuccess,
  }) async {
    setLoading(true);
    clearError();

    try {
      // TODO: Replace with real auth service
      await Future.delayed(const Duration(seconds: 1));
      _resetEmail = email;
      notifyListeners();
      onSuccess();
    } catch (e) {
      setError('Failed to send code: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> verifyOtp({
    required String otp,
    required VoidCallback onSuccess,
  }) async {
    setLoading(true);
    clearError();

    try {
      // TODO: Replace with real verification
      await Future.delayed(const Duration(seconds: 1));
      if (otp.length == 5) {
        onSuccess();
      } else {
        setError('Invalid OTP');
      }
    } catch (e) {
      setError('Verification failed');
    } finally {
      setLoading(false);
    }
  }

  Future<void> resetPassword({
    required String newPassword,
    required VoidCallback onSuccess,
  }) async {
    setLoading(true);
    clearError();

    try {
      // TODO: Replace with real password reset
      await Future.delayed(const Duration(seconds: 1));
      onSuccess();
    } catch (e) {
      setError('Password reset failed');
    } finally {
      setLoading(false);
    }
  }
}
