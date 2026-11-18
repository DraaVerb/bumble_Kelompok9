
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_service.dart';
import '../login/login_screen.dart';
import '../discovery/discovery_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? currentUser;
  bool isLoading = true;
  String? profileImage;

  static const Color yellow = Color(0xFFFFC629);
  static const Color background = Color(0xFFFFFDF7);

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final user = await AuthService.getCurrentUser();

    final prefs = await SharedPreferences.getInstance();

    final email = user?['email'] ?? 'default';

    final savedData = prefs.getString('bumble_profile_$email');

    Map<String, dynamic> profileData = {};

    if (savedData != null) {
      profileData = Map<String, dynamic>.from(
        jsonDecode(savedData),
      );
    }

    if (!mounted) return;

    setState(() {
      currentUser = {
        ...?user,
        ...profileData,
      };

      profileImage = profileData['image'];
      isLoading = false;
    });
  }

  Future<void> logout() async {
    await AuthService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  Future<void> openDiscovery() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DiscoveryScreen(),
      ),
    );

    // Refresh data setelah kembali dari Discovery.
    await loadUser();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: background,
        body: Center(
          child: CircularProgressIndicator(
            color: yellow,
          ),
        ),
      );
    }

    final name = currentUser?['name'] ?? 'User';

    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: const Text(
          'bumble',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: loadUser,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Colors.black,
            ),
            tooltip: 'Refresh Profile',
          ),
          IconButton(
            onPressed: logout,
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
            ),
            tooltip: 'Logout',
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // GREETING

              Row(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: const Color(0xFFFFE7A3),
                    backgroundImage: profileImage != null
                        ? MemoryImage(
                            base64Decode(profileImage!),
                          )
                        : null,
                    child: profileImage == null
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 32,
                          )
                        : null,
                  ),

                  const SizedBox(width: 13),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, $name 👋',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Ready to make a new connection?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // BANNER

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 35,
                      color: Colors.black,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Make the first move.',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Meet people and create meaningful connections.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // DISCOVERY TITLE

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discover People',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  TextButton(
                    onPressed: openDiscovery,
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // PROFILE CARD

              Container(
                width: double.infinity,
                height: 260,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE7A3),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_alt_rounded,
                      size: 90,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Find your connection',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Discover new people around you',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // EXPLORE BUTTON

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: openDiscovery,
                  icon: const Icon(Icons.explore),
                  label: const Text(
                    'Explore Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellow,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
