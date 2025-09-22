import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/device_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context);
    final theme = Theme.of(context);

    // ألوان حسب الثيم
    final cardColor = theme.cardColor;
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final activeColor = theme.brightness == Brightness.dark
        ? Colors.lightGreenAccent
        : Colors.green;
    final inactiveColor = theme.brightness == Brightness.dark
        ? Colors.redAccent
        : Colors.red;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // خلفية حسب الثيم
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: cardColor,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                leading: Icon(Icons.devices, color: theme.primaryColor),
                title: Text(
                  "Total Devices",
                  style: TextStyle(color: textColor),
                ),
                trailing: Text(
                  "${deviceProvider.totalDevices}",
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: cardColor,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                leading: Icon(Icons.power, color: activeColor),
                title: Text(
                  "Active Devices",
                  style: TextStyle(color: textColor),
                ),
                trailing: Text(
                  "${deviceProvider.activeDevices}",
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: cardColor,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                leading: Icon(Icons.power_off, color: inactiveColor),
                title: Text(
                  "Inactive Devices",
                  style: TextStyle(color: textColor),
                ),
                trailing: Text(
                  "${deviceProvider.inactiveDevices}",
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
