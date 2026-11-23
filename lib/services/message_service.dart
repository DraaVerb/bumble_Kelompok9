import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageService {
  static const String _storageKey = 'chat_messages';

  static final ValueNotifier<Map<String, List<Map<String, dynamic>>>>
  conversations = ValueNotifier({});

  static bool _isLoaded = false;

  static Future<void> loadMessages() async {
    if (_isLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(_storageKey);

    if (savedData != null) {
      final decoded = jsonDecode(savedData) as Map<String, dynamic>;
      conversations.value = decoded.map(
        (contact, messages) => MapEntry(
          contact,
          (messages as List)
              .map((message) => Map<String, dynamic>.from(message))
              .toList(),
        ),
      );
    }

    _isLoaded = true;
  }

  static Future<List<Map<String, dynamic>>> getMessages(String contact) async {
    await loadMessages();
    return List<Map<String, dynamic>>.from(conversations.value[contact] ?? []);
  }

  static Future<void> sendMessage(
    String contact,
    String text, {
    bool fromMe = true,
  }) async {
    final cleanText = text.trim();
    if (cleanText.isEmpty) return;

    await loadMessages();

    final updated = Map<String, List<Map<String, dynamic>>>.from(
      conversations.value,
    );
    final messages = List<Map<String, dynamic>>.from(updated[contact] ?? []);

    messages.add({
      'text': cleanText,
      'fromMe': fromMe,
      'time': DateTime.now().toIso8601String(),
    });

    updated[contact] = messages;
    conversations.value = updated;
    await _saveMessages();
  }

  static Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(conversations.value));
  }
}
