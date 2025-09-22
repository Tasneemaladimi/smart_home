// screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnBoardingScreen()),
      );
    });
    final theme = Theme.of(context); // استخدم الثيم

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // يتغير حسب الوضع الليلي
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home_filled, size: 80, color: theme.primaryColor),
            SizedBox(height: 20),
            Text(
              "Smart Home",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
