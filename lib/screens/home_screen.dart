import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/screens/device_management_screen.dart';
import 'package:smart_home/screens/devive_status_screen.dart';
import 'package:smart_home/screens/setting_screen.dart';
import 'package:smart_home/screens/status_screen.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DeviceManagementScreen(),
    DeviceStatusScreen(),
    StatsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // 🌙 استخدام الثيم
    final backgroundColor = theme.scaffoldBackgroundColor;
    final appBarColor = theme.scaffoldBackgroundColor;
    final titleColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final iconColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text("Smart Home", style: TextStyle(color: titleColor)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: iconColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
        iconTheme: IconThemeData(color: iconColor),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.devices), label: 'Devices'),
          BottomNavigationBarItem(icon: Icon(Icons.power), label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        ],
      ),
    );
  }
}
