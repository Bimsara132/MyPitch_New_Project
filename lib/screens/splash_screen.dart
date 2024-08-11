import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserAuthentication();
  }

  Future<void> _checkUserAuthentication() async {
    await Future.delayed(const Duration(seconds: 2)); // Show splash screen for 5 seconds

    final authService = Get.find<AuthService>();
    final User? user = authService.currentUser;

    if (user != null) {
      // Navigate to home if user is authenticated
      Get.offNamed('/home');
     // print(user.email);
    } else {
      // Navigate to login if user is not authenticated
    Get.offNamed('/login');
        // print(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:    Image.asset('assets/logo.png', height: 40),
      ),
    );
  }
}
