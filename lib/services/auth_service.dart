
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Membuat hash password dengan salt unik
  static String _hashPassword(String password, String salt) {
    final bytes = utf8.encode('$salt:$password');
    return sha256.convert(bytes).toString();
  }

  // Mengambil daftar akun
  static Future<List<Map<String, dynamic>>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('users');

    if (data == null) return [];

    final List decoded = jsonDecode(data);

    return decoded
        .map((user) => Map<String, dynamic>.from(user))
        .toList();
  }

  // Menyimpan daftar akun
  static Future<void> _saveUsers(
    List<Map<String, dynamic>> users,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('users', jsonEncode(users));
  }

  // REGISTER
  static Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final users = await _getUsers();

    final normalizedEmail = email.trim().toLowerCase();

    // Cek email sudah terdaftar
    final exists = users.any(
      (user) => user['email'] == normalizedEmail,
    );

    if (exists) {
      return 'Email sudah terdaftar!';
    }

    // Membuat salt acak
    final random = Random.secure();
    final salt = List.generate(
      16,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();

    // Membuat akun baru
    final newUser = {
      'name': name.trim(),
      'email': normalizedEmail,
      'salt': salt,
      'password': _hashPassword(password, salt),
    };

    users.add(newUser);

    await _saveUsers(users);

    return null;
  }

  // LOGIN
  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    final users = await _getUsers();

    final normalizedEmail = email.trim().toLowerCase();

    // Cari akun
    final index = users.indexWhere(
      (user) => user['email'] == normalizedEmail,
    );

    if (index == -1) {
      return 'Email tidak ditemukan!';
    }

    final user = users[index];

    // Validasi password
    final inputHash = _hashPassword(
      password,
      user['salt'],
    );

    if (inputHash != user['password']) {
      return 'Password salah!';
    }

    // Simpan sesi login
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('is_logged_in', true);
    await prefs.setString('current_email', normalizedEmail);

    return null;
  }

  // MENGAMBIL STATUS LOGIN
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('is_logged_in') ?? false;
  }

  // MENGAMBIL PROFIL PENGGUNA AKTIF
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

    final email = prefs.getString('current_email');

    if (email == null) return null;

    final users = await _getUsers();

    for (final user in users) {
      if (user['email'] == email) {
        return user;
      }
    }

    return null;
  }

  // LOGOUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('is_logged_in', false);
    await prefs.remove('current_email');
  }
}
