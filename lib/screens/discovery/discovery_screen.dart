import 'package:flutter/material.dart';
import '../../services/likes_service.dart';
import '../../services/pass_service.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  int currentIndex = 0;
  double dragX = 0;

  String selectedGender = 'Semua';
  String selectedLocation = 'Semua lokasi';
  RangeValues selectedAgeRange = const RangeValues(18, 30);

  bool lastActionWasPass = false;
  bool isProcessing = false;

  final List<Map<String, dynamic>> profiles = [
    // ================= PEREMPUAN =================
    {
      'name': 'Alyssa', 'age': 21,
      'location': 'Jakarta, Indonesia',
      'bio': 'Coffee lover ☕ | Travelling | Music enthusiast',
      'interests': ['Music', 'Travel', 'Coffee'],
      'image': 'asset/images/alyssa.jpg',
      'color': Color(0xFFFFD6C9), 'gender': 'Cewek',
    },
    {
      'name': 'Michelle', 'age': 22,
      'location': 'Bandung, Indonesia',
      'bio': 'Enjoying little things in life. Let’s explore together!',
      'interests': ['Photography', 'Nature', 'Movies'],
      'image': 'asset/images/michelle.jpg',
      'color': Color(0xFFFFE7A3), 'gender': 'Cewek',
    },
    {
      'name': 'Nadia', 'age': 20,
      'location': 'Yogyakarta, Indonesia',
      'bio': 'Food hunter, book reader, and adventure seeker.',
      'interests': ['Food', 'Books', 'Adventure'],
      'image': 'asset/images/nadia.jpg',
      'color': Color(0xFFE9D5FF), 'gender': 'Cewek',
    },
    {
      'name': 'Sofia', 'age': 23,
      'location': 'Surabaya, Indonesia',
      'bio': 'Life is better with good music and good people.',
      'interests': ['Music', 'Art', 'Cooking'],
      'image': 'asset/images/sofia.jpg',
      'color': Color(0xFFD5E9FF), 'gender': 'Cewek',
    },
    {
      'name': 'Clara', 'age': 22,
      'location': 'Jakarta, Indonesia',
      'bio': 'Love exploring new places and trying new food.',
      'interests': ['Travel', 'Food', 'Photography'],
      'image': 'asset/images/clara.jpg',
      'color': Color(0xFFFFD6E7), 'gender': 'Cewek',
    },
    {
      'name': 'Jessica', 'age': 21,
      'location': 'Bandung, Indonesia',
      'bio': 'Music lover and weekend coffee hunter.',
      'interests': ['Music', 'Coffee', 'Movies'],
      'image': 'asset/images/jessica.jpg',
      'color': Color(0xFFE8D5FF), 'gender': 'Cewek',
    },
    {
      'name': 'Amanda', 'age': 23,
      'location': 'Surabaya, Indonesia',
      'bio': 'Enjoying life through art and adventure.',
      'interests': ['Art', 'Adventure', 'Cooking'],
      'image': 'asset/images/amanda.jpg',
      'color': Color(0xFFFFE0C2), 'gender': 'Cewek',
    },
    {
      'name': 'Olivia', 'age': 22,
      'location': 'Yogyakarta, Indonesia',
      'bio': 'Book reader who loves nature and sunsets.',
      'interests': ['Books', 'Nature', 'Travel'],
      'image': 'asset/images/olivia.jpg',
      'color': Color(0xFFFFEBA8), 'gender': 'Cewek',
    },
    {
      'name': 'Bella', 'age': 20,
      'location': 'Semarang, Indonesia',
      'bio': 'A little sunshine with big dreams.',
      'interests': ['Fashion', 'Music', 'Coffee'],
      'image': 'asset/images/bella.jpg',
      'color': Color(0xFFFFD9C9), 'gender': 'Cewek',
    },
    {
      'name': 'Natasha', 'age': 24,
      'location': 'Bali, Indonesia',
      'bio': 'Beach lover and sunset enthusiast.',
      'interests': ['Beach', 'Swimming', 'Travel'],
      'image': 'asset/images/natasha.jpg',
      'color': Color(0xFFD5F0E5), 'gender': 'Cewek',
    },

    // ================= LAKI-LAKI =================
    {
      'name': 'Daniel', 'age': 23,
      'location': 'Jakarta, Indonesia',
      'bio': 'Sports lover and coffee enthusiast.',
      'interests': ['Sports', 'Coffee', 'Music'],
      'image': 'asset/images/daniel.jpg',
      'color': Color(0xFFD5E9FF), 'gender': 'Cowok',
    },
    {
      'name': 'Kevin', 'age': 22,
      'location': 'Bandung, Indonesia',
      'bio': 'Gamer who enjoys travelling and photography.',
      'interests': ['Gaming', 'Travel', 'Photography'],
      'image': 'asset/images/kevin.jpg',
      'color': Color(0xFFE5D9FF), 'gender': 'Cowok',
    },
    {
      'name': 'Rafael', 'age': 24,
      'location': 'Surabaya, Indonesia',
      'bio': 'Food explorer and music enthusiast.',
      'interests': ['Food', 'Music', 'Cooking'],
      'image': 'asset/images/rafael.jpg',
      'color': Color(0xFFFFE0C2), 'gender': 'Cowok',
    },
    {
      'name': 'Adrian', 'age': 21,
      'location': 'Yogyakarta, Indonesia',
      'bio': 'Love books, nature, and new experiences.',
      'interests': ['Books', 'Nature', 'Movies'],
      'image': 'asset/images/adrian.jpg',
      'color': Color(0xFFD5F0E5), 'gender': 'Cowok',
    },
    {
      'name': 'Ethan', 'age': 23,
      'location': 'Bali, Indonesia',
      'bio': 'Adventure seeker and beach lover.',
      'interests': ['Beach', 'Adventure', 'Swimming'],
      'image': 'asset/images/ethan.jpg',
      'color': Color(0xFFFFE7A3), 'gender': 'Cowok',
    },
    {
      'name': 'Nathan', 'age': 22,
      'location': 'Semarang, Indonesia',
      'bio': 'Enjoying sports and good conversations.',
      'interests': ['Football', 'Movies', 'Travel'],
      'image': 'asset/images/nathan.jpg',
      'color': Color(0xFFE9D5FF), 'gender': 'Cowok',
    },
    {
      'name': 'William', 'age': 25,
      'location': 'Jakarta, Indonesia',
      'bio': 'Business minded and always learning.',
      'interests': ['Business', 'Fitness', 'Coffee'],
      'image': 'asset/images/william.jpg',
      'color': Color(0xFFFFD6C9), 'gender': 'Cowok',
    },
    {
      'name': 'Gabriel', 'age': 21,
      'location': 'Malang, Indonesia',
      'bio': 'Creative soul who loves music and art.',
      'interests': ['Art', 'Music', 'Photography'],
      'image': 'asset/images/gabriel.jpg',
      'color': Color(0xFFD5E9FF), 'gender': 'Cowok',
    },
    {
      'name': 'Vincent', 'age': 24,
      'location': 'Tangerang, Indonesia',
      'bio': 'Gym enthusiast and weekend traveller.',
      'interests': ['Fitness', 'Travel', 'Food'],
      'image': 'asset/images/vincent.jpg',
      'color': Color(0xFFFFE0C2), 'gender': 'Cowok',
    },
    {
      'name': 'Jonathan', 'age': 23,
      'location': 'Bogor, Indonesia',
      'bio': 'Nature lover and casual photographer.',
      'interests': ['Nature', 'Photography', 'Hiking'],
      'image': 'asset/images/jonathan.jpg',
      'color': Color(0xFFD5F0E5), 'gender': 'Cowok',
    },
  ];

  // ================= LOKASI =================
  List<String> get availableLocations {
    final cities = profiles.map((profile) {
      return (profile['location'] as String).split(',').first.trim();
    }).toSet().toList();

    cities.sort();
    return ['Semua lokasi', ...cities];
  }

  // ================= FILTER PROFIL =================
  List<Map<String, dynamic>> get filteredProfiles {
    return profiles.where((profile) {
      final genderMatch = selectedGender == 'Semua' ||
          profile['gender'] == selectedGender;

      final age = profile['age'] as int;
      final ageMatch = age >= selectedAgeRange.start &&
          age <= selectedAgeRange.end;

      final city =
          (profile['location'] as String).split(',').first.trim();

      final locationMatch = selectedLocation == 'Semua lokasi' ||
          city == selectedLocation;

      return genderMatch && ageMatch && locationMatch;
    }).toList();
  }

  // ================= LIKE DAN PASS =================
  Future<void> nextProfile(String action) async {
    if (isProcessing || currentIndex >= filteredProfiles.length) return;

    setState(() {
      isProcessing = true;
    });

    final profile =
        Map<String, dynamic>.from(filteredProfiles[currentIndex]);

    final profileName = profile['name'];

    try {
      if (action == 'like') {
        await LikesService.addLike(profile);
      } else if (action == 'pass') {
        await PassService.addPass(profile);
      }

      if (!mounted) return;

      setState(() {
        currentIndex++;
        dragX = 0;
        lastActionWasPass = action == 'pass';
        isProcessing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            action == 'like'
                ? 'Kamu menyukai $profileName!'
                : 'Kamu melewati $profileName.',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isProcessing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  // ================= UNDO PASS TERAKHIR =================
  Future<void> undoPass() async {
    if (isProcessing || !lastActionWasPass || currentIndex <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Belum ada Pass terakhir yang bisa dikembalikan.'),
        ),
      );
      return;
    }

    final previousProfile = await PassService.undoLastPass();

    if (!mounted) return;

    if (previousProfile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Riwayat Pass kosong.')),
      );
      return;
    }

    setState(() {
      currentIndex--;
      dragX = 0;
      lastActionWasPass = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${previousProfile['name']} dikembalikan!'),
      ),
    );
  }

  // ================= RESET FILTER =================
  void resetFilters() {
    setState(() {
      selectedGender = 'Semua';
      selectedLocation = 'Semua lokasi';
      selectedAgeRange = const RangeValues(18, 30);
      currentIndex = 0;
      dragX = 0;
      lastActionWasPass = false;
    });
  }
    // ================= TAMPILAN UTAMA =================
  @override
  Widget build(BuildContext context) {
    final visibleProfiles = filteredProfiles;
    final hasProfiles = currentIndex < visibleProfiles.length;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFDF7),
        elevation: 0,
        title: const Text(
          'Discover',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: showPassHistory,
            icon: const Icon(
              Icons.history_rounded,
              color: Colors.black,
            ),
            tooltip: 'Riwayat Pass',
          ),
          IconButton(
            onPressed: resetFilters,
            icon: const Icon(
              Icons.refresh_rounded,
              color: Colors.black,
            ),
            tooltip: 'Reset filter',
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find your connection 💛',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 10),

              // FILTER GENDER
              Row(
                children: [
                  _genderButton('Semua'),
                  const SizedBox(width: 8),
                  _genderButton('Cewek'),
                  const SizedBox(width: 8),
                  _genderButton('Cowok'),
                ],
              ),

              const SizedBox(height: 8),

              // FILTER USIA
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rentang usia',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${selectedAgeRange.start.round()} - '
                    '${selectedAgeRange.end.round()} tahun',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),

              RangeSlider(
                values: selectedAgeRange,
                min: 18,
                max: 30,
                divisions: 12,
                activeColor: const Color(0xFFFFC629),
                labels: RangeLabels(
                  '${selectedAgeRange.start.round()}',
                  '${selectedAgeRange.end.round()}',
                ),
                onChanged: (values) {
                  setState(() {
                    selectedAgeRange = values;
                    currentIndex = 0;
                    dragX = 0;
                    lastActionWasPass = false;
                  });
                },
              ),

              // FILTER LOKASI
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 20),
                  const SizedBox(width: 6),
                  const Text(
                    'Lokasi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: selectedLocation,
                      isExpanded: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: availableLocations.map((location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(
                            location,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          selectedLocation = value;
                          currentIndex = 0;
                          dragX = 0;
                          lastActionWasPass = false;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                '${visibleProfiles.length} profil ditemukan',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 8),

              // KARTU DAN TOMBOL
              Expanded(
                child: hasProfiles
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                if (isProcessing) return;
                                setState(() {
                                  dragX += details.delta.dx;
                                });
                              },
                              onHorizontalDragEnd: (details) {
                                if (isProcessing) return;

                                if (dragX > 100) {
                                  nextProfile('like');
                                } else if (dragX < -100) {
                                  nextProfile('pass');
                                } else {
                                  setState(() {
                                    dragX = 0;
                                  });
                                }
                              },
                              child: Transform.translate(
                                offset: Offset(dragX, 0),
                                child: Transform.rotate(
                                  angle: dragX / 900,
                                  child: _profileCard(
                                    visibleProfiles[currentIndex],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // TOMBOL UNDO, PASS, LIKE
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _actionButton(
                                  icon: Icons.undo_rounded,
                                  color: Colors.white,
                                  iconColor: lastActionWasPass
                                      ? Colors.orange
                                      : Colors.grey,
                                  onPressed: undoPass,
                                  size: 52,
                                ),

                                const SizedBox(width: 16),

                                _actionButton(
                                  icon: Icons.close_rounded,
                                  color: Colors.white,
                                  iconColor: Colors.redAccent,
                                  onPressed: () => nextProfile('pass'),
                                ),

                                const SizedBox(width: 16),

                                _actionButton(
                                  icon: Icons.favorite_rounded,
                                  color: const Color(0xFFFFC629),
                                  iconColor: Colors.white,
                                  onPressed: () => nextProfile('like'),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    : _emptyState(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= KARTU PROFIL =================
  Widget _profileCard(Map<String, dynamic> profile) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 270,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    profile['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: profile['color'],
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),

                  const Positioned(
                    top: 15,
                    right: 15,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white70,
                      size: 30,
                    ),
                  ),

                  Positioned(
                    bottom: 15,
                    left: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 9,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'New profile',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${profile['name']}, ${profile['age']}',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 23,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 19,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      profile['location'],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 17),

                Text(
                  profile['bio'],
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'INTERESTS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (profile['interests'] as List<String>)
                      .map((interest) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF2CC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        interest,
                        style: const TextStyle(fontSize: 13),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
    // ================= RIWAYAT PASS =================
  Future<void> showPassHistory() async {
    await PassService.loadPasses();

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.history_rounded),
              SizedBox(width: 8),
              Text('Riwayat Pass'),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 350,
            child: ValueListenableBuilder<
                List<Map<String, dynamic>>>(
              valueListenable: PassService.passedProfiles,
              builder: (context, passedProfiles, child) {
                if (passedProfiles.isEmpty) {
                  return const Center(
                    child: Text(
                      'Belum ada profil yang dilewati.',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: passedProfiles.length,
                  itemBuilder: (context, index) {
                    final profile = passedProfiles[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: AssetImage(profile['image']),
                        onBackgroundImageError: (_, _) {},
                        child: const Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                      title: Text(
                        '${profile['name']}, ${profile['age']}',
                      ),
                      subtitle: Text(profile['location']),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // ================= EMPTY STATE =================
  Widget _emptyState() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border_rounded,
              size: 75,
              color: Color(0xFFFFC629),
            ),

            const SizedBox(height: 20),

            const Text(
              'You are all caught up!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Tidak ada profil lain untuk ditampilkan.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: resetFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC629),
                foregroundColor: Colors.black,
              ),
              child: const Text('Show Again'),
            ),

            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: showPassHistory,
              icon: const Icon(Icons.history),
              label: const Text('Lihat Riwayat Pass'),
            ),
          ],
        ),
      ),
    );
  }

  // ================= PILIHAN GENDER =================
  Widget _genderButton(String gender) {
    final isSelected = selectedGender == gender;

    return Expanded(
      child: ChoiceChip(
        label: SizedBox(
          width: double.infinity,
          child: Text(
            gender,
            textAlign: TextAlign.center,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedGender = gender;
            currentIndex = 0;
            dragX = 0;
            lastActionWasPass = false;
          });
        },
        selectedColor: const Color(0xFFFFC629),
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight:
              isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        side: BorderSide(
          color: isSelected
              ? const Color(0xFFFFC629)
              : Colors.grey.shade300,
        ),
      ),
    );
  }

  // ================= TOMBOL LIKE, PASS, UNDO =================
  Widget _actionButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onPressed,
    double size = 65,
  }) {
    return Material(
      color: color,
      elevation: 4,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: isProcessing ? null : onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: size == 65 ? 32 : 25,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}