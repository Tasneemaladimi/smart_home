import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // الخلفية حسب الثيم
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: textColor), // نص العنوان حسب الثيم
        ),
        backgroundColor: theme.scaffoldBackgroundColor, // نفس لون الخلفية
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: theme.primaryColor,
        ), // لون أيقونات الاب بار
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // تبديل الثيم
          Card(
            color: cardColor,
            child: ListTile(
              leading: Icon(Icons.brightness_6, color: theme.primaryColor),
              title: Text("Dark Mode", style: TextStyle(color: textColor)),
              trailing: Switch(
                value: themeProvider.isDarkTheme,
                onChanged: (val) => themeProvider.toggleTheme(),
                activeColor: theme.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // زر تسجيل الخروج
          Card(
            color: cardColor,
            child: ListTile(
              leading: Icon(Icons.logout, color: theme.primaryColor),
              title: Text("Logout", style: TextStyle(color: textColor)),
              onTap: () => _logout(context),
            ),
          ),
          const SizedBox(height: 12),
          // أي إعدادات إضافية
          Card(
            color: cardColor,
            child: ListTile(
              leading: Icon(Icons.info, color: theme.primaryColor),
              title: Text("About", style: TextStyle(color: textColor)),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Smart Home",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2025 Smart Home App",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
