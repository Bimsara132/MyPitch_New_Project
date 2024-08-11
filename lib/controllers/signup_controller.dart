import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_pitch/services/auth_service.dart';

class SignUpController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Observable variables to manage the state
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Sign-up method
  Future<void> signUp() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading.value = true;
      try {
        final user = await _authService.signUp(
          emailController.text,
          passwordController.text,
          usernameController.text,
        );

        if (user != null) {
          // Navigate to home screen on successful sign-up
          Get.offNamed('/home');
        }
      } catch (e) {
        String errorMessage;

        // Check for Firebase Auth exceptions
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'email-already-in-use':
              errorMessage =
                  'The email address is already in use by another account.';
              break;
            case 'weak-password':
              errorMessage = 'The password provided is too weak.';
              break;
            case 'invalid-email':
              errorMessage = 'The email address is not valid.';
              break;
            default:
              errorMessage = 'An unexpected error occurred. Please try again.';
          }
        } else {
          errorMessage = 'An unexpected error occurred. Please try again.';
        }

        // Show snackbar with error message
        Get.snackbar(
          'Alert',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        // Update observable error message
        this.errorMessage.value = errorMessage;
      } finally {
        isLoading.value = false;
      }
    }
  }
}
