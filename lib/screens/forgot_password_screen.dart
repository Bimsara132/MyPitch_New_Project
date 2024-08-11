import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; // Import the animate_do package
import '../theme.dart'; // Assuming you have a theme file like shown before

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                delay: Duration(milliseconds: 100), // delay
                child: Image.asset(
                  'assets/login_main_image.jpg', // Adjust the path to image
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: Duration(milliseconds: 150), // Add delay
                child: Text('FORGOT YOUR PASSWORD ON MYPITCH?',
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              const SizedBox(height: 10),
              FadeInDown(
                delay: Duration(milliseconds: 200), //  delay
                child: Text(
                  "Don't worry. Enter your email address and we'll email you a link to reset your password.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: Duration(milliseconds: 250), //  delay
                child: TextFormField(
                  controller: emailController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: Duration(milliseconds: 300), // Add delay
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Theme.of(context).hintColor,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Send password reset link',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
