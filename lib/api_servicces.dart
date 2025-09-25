import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://68d42a90214be68f8c689aa5.mockapi.io/device';
  // ✅ جلب الأجهزة
  Future<List<Map<String, dynamic>>> getDevices() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load devices');
    }
  }

  // ✅ إضافة جهاز جديد
  Future<Map<String, dynamic>> addDevice(Map<String, dynamic> device) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(device),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add device');
    }
  }

  // ✅ تحديث جهاز
  Future<void> updateDevice(int id, Map<String, dynamic> device) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(device),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update device');
    }
  }

  // ✅ حذف جهاز
  Future<void> deleteDevice(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete device');
    }
  }
}
