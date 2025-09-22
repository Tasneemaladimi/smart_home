import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/device_provider.dart';

class DeviceStatusScreen extends StatelessWidget {
  const DeviceStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devices = context.watch<DeviceProvider>().devices;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // خلفية حسب الثيم
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return Card(
            color: theme.cardColor, // كارد حسب الثيم
            margin: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              height: 100,
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                title: Text(
                  device['name'],
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                ),
                secondary: Icon(
                  IconData(
                    device['iconCodePoint'],
                    fontFamily: 'MaterialIcons',
                  ),
                  color: device['status']
                      ? theme
                            .primaryColor // أزرق حسب الثيم
                      : theme.textTheme.bodyMedium?.color?.withOpacity(
                          0.5,
                        ), // رمادي حسب الثيم
                  size: 30,
                ),
                value: device['status'] as bool,
                onChanged: (val) {
                  context.read<DeviceProvider>().toggleStatus(index, val);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
