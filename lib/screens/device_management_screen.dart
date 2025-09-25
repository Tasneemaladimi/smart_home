import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/device_provider.dart';

class DeviceManagementScreen extends StatelessWidget {
  const DeviceManagementScreen({Key? key}) : super(key: key);

  void _addDeviceDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    IconData? selectedIcon;

    final theme = Theme.of(context); // ✅ استخدم الثيم هنا

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: theme.scaffoldBackgroundColor, // حسب الثيم
              title: Text(
                "Add New Device",
                style: TextStyle(color: theme.textTheme.bodyMedium?.color),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                    decoration: InputDecoration(
                      labelText: "Device Name",
                      labelStyle: TextStyle(
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    children: [
                      for (var icon in [
                        Icons.lightbulb_outline,
                        Icons.ac_unit,
                        Icons.door_front_door,
                        Icons.device_hub,
                      ])
                        GestureDetector(
                          onTap: () {
                            setStateDialog(() => selectedIcon = icon);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: selectedIcon == icon
                                  ? theme.primaryColor
                                  : theme.cardColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              icon,
                              color: selectedIcon == icon
                                  ? Colors.white
                                  : theme.textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: theme.primaryColor),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                  ),
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        selectedIcon != null) {
                      Provider.of<DeviceProvider>(
                        context,
                        listen: false,
                      ).addDevice(nameController.text, selectedIcon!);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final devices = context.watch<DeviceProvider>().devices;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // حسب الثيم
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          print(
            'Device name: ${device['name']}, iconCodePoint: ${device['iconCodePoint']}',
          );
          return Card(
            color: theme.cardColor, // حسب الثيم
            margin: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              height: 100,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                leading: Icon(
                  IconData(
                    device['iconCodePoint'] is int
                        ? device['iconCodePoint']
                        : Icons.device_unknown.codePoint,

                    fontFamily: device['iconFontFamily'] ?? 'MaterialIcons',
                  ),
                  color: theme.primaryColor,
                  size: 30,
                ),
                title: Text(
                  device['name'],
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.grey),
                  onPressed: () {
                    context.read<DeviceProvider>().deleteDevice(index);
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addDeviceDialog(context),
        backgroundColor: theme.primaryColor, // حسب الثيم
        child: Icon(Icons.add, color: theme.textTheme.bodyMedium?.color),
      ),
    );
  }
}
