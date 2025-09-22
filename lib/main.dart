// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart' show ThemeProvider;
import 'providers/device_provider.dart'; // ✅ أضفنا البروفايدر الجديد
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DeviceProvider()), // ✅ هنا
      ],
      child: SmartHomeApp(),
    ),
  );
}

class SmartHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home',
      theme: ThemeData(
        primaryColor: Color(0xFF639CC5), // أزرق مخصص
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black), // نصوص الوضع النهاري
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF639CC5), // اللون النهاري
          foregroundColor: Colors.white, // لون النصوص والأيقونات
          elevation: 1,
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Color(0xFF639CC5), // أزرق للداكن
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey[900],
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // نصوص الوضع الليلي
        ),
      ),

      themeMode: themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnBoardingScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
