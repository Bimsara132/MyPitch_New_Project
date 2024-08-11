import 'package:flutter/material.dart';

import '../theme.dart';

class BackgroundImageWithGradient extends StatelessWidget {
  final Widget child;

  const BackgroundImageWithGradient({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/login_main_image.jpg', // Update with your background image asset path
            fit: BoxFit.cover,
          ),
        ),
        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
   AppTheme.primaryDark,
                  Colors.black.withOpacity(0.6), // Dark gradient at the bottom
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
        ),
        // Content on top of the background and gradient
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
