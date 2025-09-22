// screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  void _goToLogin() {
    if (!mounted) return; // تأكد الشاشة ما زالت موجودة
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          buildPage(Icons.lightbulb, "Control all your devices"),
          buildPage(Icons.color_lens, "Customize the app appearance"),
          buildPage(Icons.lock, "Secure login to protect your account"),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _goToLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF639CC5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text(
            "Get Started",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget buildPage(IconData icon, String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 150, color: const Color(0xFF639CC5)),
          const SizedBox(height: 50),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF639CC5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
