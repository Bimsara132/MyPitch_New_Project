import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart'; // Import the animate_do package
import 'package:my_pitch/theme.dart';
import '../controllers/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryDark,
        foregroundColor: AppTheme.primaryLight,
        title: Image.asset(
          'assets/logo.png',
          height: 30,
          fit: BoxFit.contain,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                delay: const Duration(milliseconds: 100), //  delay
                child:
                    Image.asset('assets/login_main_image.jpg'), //  image asset
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: const Duration(milliseconds: 150), // Add delay
                child: Text('REGISTER TO MYPITCH.',
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              const SizedBox(height: 10),
              FadeInDown(
                delay: const Duration(milliseconds: 200), //  delay
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'Login here',
                          style: TextStyle(color: AppTheme.accentPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: const Duration(milliseconds: 250), //  delay
                child: Form(
                  key: signUpController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: signUpController.usernameController,
                        cursorColor: AppTheme.accentPrimary,
                        decoration: InputDecoration(
                          labelText: 'Username',
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
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      FadeInDown(
                        delay: const Duration(milliseconds: 300), //  delay
                        child: TextFormField(
                          controller: signUpController.emailController,
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
                            if (!RegExp(
                                    r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      FadeInDown(
                        delay: const Duration(milliseconds: 350), //  delay
                        child: TextFormField(
                          controller: signUpController.passwordController,
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
                          ),
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInDown(
                        delay: const Duration(milliseconds: 400), //  delay
                        child: Obx(() {
                          if (signUpController.isLoading.value) {
                            return Center(
                                child: CircularProgressIndicator(
                                    color: AppTheme.accentPrimary));
                          }
                          return ElevatedButton(
                            onPressed: signUpController.signUp,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: AppTheme.accentPrimary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Register',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                          );
                        }),
                      ),
                      const SizedBox(height: 10),
                      FadeInDown(
                        delay: const Duration(milliseconds: 450), //  delay
                        child: Obx(() {
                          if (signUpController.errorMessage.value.isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                signUpController.errorMessage.value,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
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
