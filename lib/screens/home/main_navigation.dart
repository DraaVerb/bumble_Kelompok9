
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../widgets/custom_bottom_navbar.dart';

import 'home_screen.dart';
import '../discovery/discovery_screen.dart';
import '../likes/likes_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  late final List<Widget> pages = [
    const HomeScreen(),
    const DiscoveryScreen(),
    const LikesScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  void changePage(int index) {
    if (index < 0 || index >= pages.length) return;

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // Menampilkan halaman sesuai menu yang dipilih.
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: selectedIndex,
          children: pages,
        ),
      ),

      // Navigasi utama lima menu.
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: selectedIndex,
        onTap: changePage,
      ),
    );
  }
}
