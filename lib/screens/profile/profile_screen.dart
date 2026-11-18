
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_service.dart';
import '../login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final bioController = TextEditingController();
  final locationController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  Map<String, dynamic>? currentUser;

  bool isLoading = true;
  bool isSaving = false;

  String? profileImage;

  final List<String> allInterests = [
    'Music',
    'Travel',
    'Coffee',
    'Photography',
    'Movies',
    'Food',
    'Books',
    'Adventure',
    'Art',
    'Cooking',
    'Fitness',
    'Fashion',
    'Gaming',
    'Nature',
    'Sports',
  ];

  List<String> selectedInterests = [];

  static const Color yellow = Color(0xFFFFC629);
  static const Color background = Color(0xFFFFFDF7);

  String get storageKey {
    final email = currentUser?['email']?.toString() ?? 'default';
    return 'bumble_profile_$email';
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    bioController.dispose();
    locationController.dispose();
    super.dispose();
  }

  Future<void> loadProfile() async {
    final user = await AuthService.getCurrentUser();

    final prefs = await SharedPreferences.getInstance();

    final savedData = prefs.getString(
      'bumble_profile_${user?['email'] ?? 'default'}',
    );

    Map<String, dynamic> data = {};

    if (savedData != null) {
      data = Map<String, dynamic>.from(
        jsonDecode(savedData),
      );
    }

    if (!mounted) return;

    setState(() {
      currentUser = user;

      nameController.text =
          data['name'] ?? user?['name'] ?? '';

      ageController.text =
          data['age']?.toString() ?? '';

      bioController.text = data['bio'] ?? '';

      locationController.text =
          data['location'] ?? '';

      selectedInterests =
          List<String>.from(data['interests'] ?? []);

      profileImage = data['image'];
      isLoading = false;
    });
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 800,
      );

      if (image == null) return;

      final bytes = await image.readAsBytes();

      if (!mounted) return;

      setState(() {
        profileImage = base64Encode(bytes);
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memilih foto: $e')),
      );
    }
  }

  Future<void> saveProfile() async {
    if (nameController.text.trim().isEmpty) {
      showMessage('Nama tidak boleh kosong.');
      return;
    }

    final age = int.tryParse(ageController.text.trim());

    if (age == null || age < 18 || age > 100) {
      showMessage('Umur harus antara 18 sampai 100 tahun.');
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      final profileData = {
        'name': nameController.text.trim(),
        'age': age,
        'bio': bioController.text.trim(),
        'location': locationController.text.trim(),
        'interests': selectedInterests,
        'image': profileImage,
      };

      await prefs.setString(
        storageKey,
        jsonEncode(profileData),
      );

      if (!mounted) return;

      setState(() {
        currentUser = {
          ...?currentUser,
          'name': nameController.text.trim(),
        };
        isSaving = false;
      });

      showMessage('Profil berhasil disimpan!');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      showMessage('Gagal menyimpan profil: $e');
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black87,
      ),
    );
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

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 9),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5E5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5E5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: yellow,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
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

    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // PROFILE PHOTO

            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 65,
                        backgroundColor:
                            const Color(0xFFFFE7A3),
                        backgroundImage: profileImage != null
                            ? MemoryImage(
                                base64Decode(profileImage!),
                              )
                            : null,
                        child: profileImage == null
                            ? const Icon(
                                Icons.person,
                                size: 75,
                                color: Colors.white,
                              )
                            : null,
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: pickImage,
                          borderRadius:
                              BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: yellow,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Change Profile Photo',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // BASIC INFORMATION

            const Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            buildTextField(
              label: 'Full Name',
              controller: nameController,
              hint: 'Enter your name',
            ),

            const SizedBox(height: 18),

            buildTextField(
              label: 'Age',
              controller: ageController,
              hint: 'Enter your age',
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 18),

            buildTextField(
              label: 'Location',
              controller: locationController,
              hint: 'Example: Jakarta, Indonesia',
            ),

            const SizedBox(height: 18),

            buildTextField(
              label: 'About Me',
              controller: bioController,
              hint: 'Tell something about yourself...',
              maxLines: 4,
            ),

            const SizedBox(height: 30),

            // INTERESTS

            const Text(
              'My Interests',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Choose interests that describe you.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: allInterests.map((interest) {
                final selected =
                    selectedInterests.contains(interest);

                return FilterChip(
                  label: Text(interest),
                  selected: selected,
                  selectedColor: yellow,
                  backgroundColor: Colors.white,
                  checkmarkColor: Colors.black,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedInterests.add(interest);
                      } else {
                        selectedInterests.remove(interest);
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 35),

            // SAVE BUTTON

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isSaving ? null : saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: yellow,
                  foregroundColor: Colors.black,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: isSaving
                    ? const CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : const Text(
                        'Save Profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
