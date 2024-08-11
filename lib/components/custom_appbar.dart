import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryDark,
      height: preferredSize.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Image.asset(
                'assets/logo.png', 
                fit: BoxFit.contain,
                height: 30,
              ),
            ),
            IconButton(
              icon: Icon(Icons.logout, color: AppTheme.primaryLight),
              onPressed: () async {
                await Get.find<AuthService>().signOut();
                Get.offNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
