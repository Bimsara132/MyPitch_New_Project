import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_pitch/controllers/signup_controller.dart';
import 'package:my_pitch/screens/forgot_password_screen.dart';
import 'controllers/login_controller.dart';
import 'services/auth_service.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/game_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize AuthService and controllers
  Get.put(AuthService());
  Get.put(LoginController());


  // Check user authentication status
  final authService = Get.find<AuthService>();
  final user = authService.currentUser;

  // Navigate based on authentication status
  runApp(MyApp(initialRoute: user != null ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyPitch App',
      theme: AppTheme.theme,
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/forgot_password', page: () => ForgotPasswordScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/game', page: () => GameScreen()),
      ],
    );
  }
}
