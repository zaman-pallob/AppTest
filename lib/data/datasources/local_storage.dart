import 'dart:convert';

import 'package:hive/hive.dart';

class LocalStorage {
  Box box;
  LocalStorage(this.box);

  Future<void> saveData(String key, Map<String, dynamic>? value) async {
    await box.put(key, jsonEncode(value));
  }

  Future<Map<String, dynamic>?> getData(String key) async {
    var data = box.get(key, defaultValue: null);
    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }
}
