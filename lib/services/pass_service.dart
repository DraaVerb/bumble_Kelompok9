import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassService {
  static const String _storageKey = 'passed_profiles';

  static final ValueNotifier<List<Map<String, dynamic>>> passedProfiles =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  static bool _isLoaded = false;

  // ================= LOAD RIWAYAT PASS =================
  static Future<void> loadPasses() async {
    if (_isLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(_storageKey);

    if (savedData != null) {
      final List<dynamic> decoded = jsonDecode(savedData);

      passedProfiles.value = decoded.map((item) {
        return Map<String, dynamic>.from(item);
      }).toList();
    }

    _isLoaded = true;
  }

  // ================= MENAMBAHKAN PASS =================
  static Future<void> addPass(
    Map<String, dynamic> profile,
  ) async {
    await loadPasses();

    final savedProfile = Map<String, dynamic>.from(profile);

    // Color tidak dapat langsung disimpan ke JSON.
    if (savedProfile['color'] is Color) {
      savedProfile['color'] =
          (savedProfile['color'] as Color).toARGB32();
    }

    // Hindari riwayat ganda untuk profil yang sama.
    passedProfiles.value = [
      ...passedProfiles.value.where(
        (item) => item['name'] != savedProfile['name'],
      ),
      savedProfile,
    ];

    await _savePasses();
  }

  // ================= UNDO PASS TERAKHIR =================
  static Future<Map<String, dynamic>?> undoLastPass() async {
    await loadPasses();

    if (passedProfiles.value.isEmpty) {
      return null;
    }

    final lastProfile = passedProfiles.value.last;

    passedProfiles.value = [
      ...passedProfiles.value.take(
        passedProfiles.value.length - 1,
      ),
    ];

    await _savePasses();

    return Map<String, dynamic>.from(lastProfile);
  }

  // ================= MENGHAPUS RIWAYAT =================
  static Future<void> clearHistory() async {
    passedProfiles.value = [];

    await _savePasses();
  }

  // ================= SIMPAN KE SHARED PREFERENCES =================
  static Future<void> _savePasses() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _storageKey,
      jsonEncode(passedProfiles.value),
    );
  }
}