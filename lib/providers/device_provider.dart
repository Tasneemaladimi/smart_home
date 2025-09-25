import 'package:flutter/material.dart';
import 'package:smart_home/api_servicces.dart';

class DeviceProvider with ChangeNotifier {
  List<Map<String, dynamic>> _devices = [];
  final ApiService _apiService = ApiService();

  List<Map<String, dynamic>> get devices => _devices;

  DeviceProvider() {
    loadDevices();
  }

  // تحميل الأجهزة من API
  Future<void> loadDevices() async {
    try {
      List<Map<String, dynamic>> loaded = await _apiService.getDevices();
      _devices = loaded.map((d) {
        final map = Map<String, dynamic>.from(d);
        map['status'] = map['status'] == true || map['status'] == 1;
        return map;
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error loading devices: $e');
    }
  }

  // إضافة جهاز جديد
  Future<void> addDevice(String name, IconData icon) async {
    Map<String, dynamic> device = {
      'name': name,
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      'status': false,
    };

    try {
      // نرسل الجهاز لـ API ونستقبل الجهاز الجديد مع ID
      final Map<String, dynamic> newDevice = await _apiService.addDevice(
        device,
      );

      // تحويل status إلى bool
      newDevice['status'] =
          newDevice['status'] == true || newDevice['status'] == 1;

      // إضافة الجهاز للقائمة مباشرة ليظهر في الواجهة
      _devices.add(newDevice);
      notifyListeners();
    } catch (e) {
      print('Error adding device: $e');
    }
  }

  // حذف جهاز
  Future<void> deleteDevice(int index) async {
    try {
      final id = _devices[index]['id'];
      await _apiService.deleteDevice(id);
      _devices.removeAt(index);
      notifyListeners();
    } catch (e) {
      print('Error deleting device: $e');
    }
  }

  // تعديل حالة الجهاز
  Future<void> toggleStatus(int index, bool value) async {
    try {
      final device = _devices[index];
      device['status'] = value;

      await _apiService.updateDevice(device['id'], {
        'name': device['name'],
        'iconCodePoint': device['iconCodePoint'],
        'status': value,
      });

      notifyListeners();
    } catch (e) {
      print('Error updating device: $e');
    }
  }

  // إحصائيات الأجهزة
  int get totalDevices => _devices.length;
  int get activeDevices => _devices.where((d) => d['status'] == true).length;
  int get inactiveDevices => _devices.where((d) => d['status'] == false).length;
}
