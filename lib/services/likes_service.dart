
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikesService {
  static const String _storageKey = 'liked_profiles';

  static final ValueNotifier<List<Map<String, dynamic>>> likedProfiles =
      ValueNotifier([]);

  static bool _isLoaded = false;

  static Future<void> loadLikes() async {
    if (_isLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(_storageKey);

    if (savedData != null) {
      final decoded = jsonDecode(savedData) as List;

      likedProfiles.value = decoded
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    }

    _isLoaded = true;
  }

  static Future<void> addLike(Map<String, dynamic> profile) async {
    await loadLikes();

    final newProfile = Map<String, dynamic>.from(profile);

    // Color harus diubah menjadi angka agar bisa disimpan sebagai JSON.
    if (newProfile['color'] is Color) {
      newProfile['color'] =
          (newProfile['color'] as Color).toARGB32();
    }

    final updatedLikes = List<Map<String, dynamic>>.from(
      likedProfiles.value,
    );

    // Hindari profil yang sama tersimpan dua kali.
    updatedLikes.removeWhere(
      (item) => item['name'] == newProfile['name'],
    );

    updatedLikes.add(newProfile);

    likedProfiles.value = updatedLikes;

    await _saveLikes();
  }

  static Future<void> removeLike(String name) async {
    await loadLikes();

    final updatedLikes = List<Map<String, dynamic>>.from(
      likedProfiles.value,
    );

    updatedLikes.removeWhere(
      (profile) => profile['name'] == name,
    );

    likedProfiles.value = updatedLikes;

    await _saveLikes();
  }

  static Future<void> _saveLikes() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _storageKey,
      jsonEncode(likedProfiles.value),
    );
  }
}
