import 'package:flutter/material.dart';
import 'package:smart_home/dp_helper.dart';

class DeviceProvider with ChangeNotifier {
  List<Map<String, dynamic>> _devices = [];

  List<Map<String, dynamic>> get devices => _devices;

  DeviceProvider() {
    loadDevices();
  }

  Future<void> loadDevices() async {
    List<Map<String, dynamic>> loaded = await DBHelper.getDevices();
    // تحويل status من int → bool
    _devices = loaded.map((d) {
      final map = Map<String, dynamic>.from(d);
      map['status'] = map['status'] == 1; // الآن status bool
      return map;
    }).toList();
    notifyListeners();
  }

  Future<void> addDevice(String name, IconData icon) async {
    Map<String, dynamic> device = {
      'name': name,
      'iconCodePoint': icon.codePoint,
      'status': false, // bool مباشرة
    };
    int id = await DBHelper.insertDevice({
      ...device,
      'status': 0, // تحويل bool → int عند الإدخال في DB
    });

    if (id != null && id > 0) {
      Map<String, dynamic> newDevice = Map<String, dynamic>.from(device);
      newDevice['id'] = id;
      _devices.add(newDevice);
      notifyListeners();
    }
  }

  Future<void> deleteDevice(int index) async {
    await DBHelper.deleteDevice(_devices[index]['id']);
    _devices.removeAt(index);
    notifyListeners();
  }

  Future<void> toggleStatus(int index, bool value) async {
    _devices[index]['status'] = value; // bool مباشرة
    await DBHelper.updateDevice(_devices[index]['id'], {
      'name': _devices[index]['name'],
      'iconCodePoint': _devices[index]['iconCodePoint'],
      'status': value ? 1 : 0, // تحويل bool → int عند التحديث في DB
    });
    notifyListeners();
  }

  int get totalDevices => _devices.length;
  int get activeDevices => _devices.where((d) => d['status'] == true).length;
  int get inactiveDevices => _devices.where((d) => d['status'] == false).length;
}
