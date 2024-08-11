import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pitch/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();

  // Observable variables to manage the state
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Sign-in method
  Future<void> signIn() async {
    if (formKey1.currentState?.validate() ?? false) {
      isLoading.value = true;
      errorMessage.value = ''; // Clear any previous error message

      final error = await _authService.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      isLoading.value = false;

      if (error == null) {
        // Navigate to home screen on successful login
        Get.offNamed('/home');
      } else {
        // Show error message if login failed
        errorMessage.value = error;
        _showErrorSnackbar(error);
      }
    }
  }

  // Helper method to show error Snackbar
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Alert',
      message,
      backgroundColor:Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(5),
   
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }
}
