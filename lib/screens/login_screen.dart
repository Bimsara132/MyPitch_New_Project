import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart'; // Import the animate_do package
import 'package:my_pitch/theme.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    // A variable to manage password visibility
    final RxBool isPasswordVisible = false.obs;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/logo.png', height: 30),
              const SizedBox(height: 15),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInDown(
                        delay: Duration(milliseconds: 100), //  delay
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Image.asset('assets/login_main_image.jpg'), // image asset
                            const SizedBox(height: 20),
                            Text(
                              'LOG IN TO MYPITCH.',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => Get.toNamed('/signup'),
                              child: RichText(
                                text: TextSpan(
                                  text: 'New to MyPitch? ',
                                  style: TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: 'Register here',
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    TextSpan(
                                      text: ' and become a Pitcher!',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      FadeInDown(
                        delay: Duration(milliseconds: 200), // delay
                        child: Form(
                          key: loginController.formKey1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: loginController.emailController,
                                cursorColor: AppTheme.accentPrimary,
                                decoration: InputDecoration(
                                  labelText: 'E-mail address',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Theme.of(context).secondaryHeaderColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.accentPrimary, 
                                    ),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Obx(() => TextFormField(
                                controller: loginController.passwordController,
                                cursorColor: AppTheme.accentPrimary,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Theme.of(context).secondaryHeaderColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.accentPrimary,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      isPasswordVisible.value = !isPasswordVisible.value;
                                    },
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                obscureText: !isPasswordVisible.value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                              )),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () => Get.toNamed('/forgot_password'),
                                child: const Text(
                                  'Forgot your password?',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(() {
                                if (loginController.isLoading.value) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: AppTheme.accentPrimary,
                                    ),
                                  );
                                }
                                return SizedBox(
                                  child: ElevatedButton(
                                    onPressed: loginController.signIn,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor: Theme.of(context).hintColor,
                                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: const Text(
                                      'Log in',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(height: 10),
                              Obx(() {
                                if (loginController.errorMessage.value.isNotEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      loginController.errorMessage.value,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              }),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
