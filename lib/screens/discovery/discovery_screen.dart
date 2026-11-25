import 'package:flutter/material.dart';
import '../../services/likes_service.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  int currentIndex = 0;
  double dragX = 0;
  String selectedGender = 'Semua';

  List<Map<String, dynamic>> get filteredProfiles {
    if (selectedGender == 'Cewek') {
      return profiles.sublist(0, 10);
    } else if (selectedGender == 'Cowok') {
      return profiles.sublist(10, 20);
    }
    return profiles;
  }

  final List<Map<String, dynamic>> profiles = [
    // ================= PEREMPUAN =================
    {
      'name': 'Alyssa',
      'age': 21,
      'location': 'Jakarta, Indonesia',
      'bio': 'Coffee lover ☕ | Travelling | Music enthusiast',
      'interests': ['Music', 'Travel', 'Coffee'],
      'image': 'asset/images/alyssa.jpg',
      'color': Color(0xFFFFD6C9),
    },
    {
      'name': 'Michelle',
      'age': 22,
      'location': 'Bandung, Indonesia',
      'bio': 'Enjoying little things in life. Let’s explore together!',
      'interests': ['Photography', 'Nature', 'Movies'],
      'image': 'asset/images/michelle.jpg',
      'color': Color(0xFFFFE7A3),
    },
    {
      'name': 'Nadia',
      'age': 20,
      'location': 'Yogyakarta, Indonesia',
      'bio': 'Food hunter, book reader, and adventure seeker.',
      'interests': ['Food', 'Books', 'Adventure'],
      'image': 'asset/images/nadia.jpg',
      'color': Color(0xFFE9D5FF),
    },
    {
      'name': 'Sofia',
      'age': 23,
      'location': 'Surabaya, Indonesia',
      'bio': 'Life is better with good music and good people.',
      'interests': ['Music', 'Art', 'Cooking'],
      'image': 'asset/images/sofia.jpg',
      'color': Color(0xFFD5E9FF),
    },
    {
      'name': 'Clara',
      'age': 22,
      'location': 'Jakarta, Indonesia',
      'bio': 'Love exploring new places and trying new food.',
      'interests': ['Travel', 'Food', 'Photography'],
      'image': 'asset/images/clara.jpg',
      'color': Color(0xFFFFD6E7),
    },
    {
      'name': 'Jessica',
      'age': 21,
      'location': 'Bandung, Indonesia',
      'bio': 'Music lover and weekend coffee hunter.',
      'interests': ['Music', 'Coffee', 'Movies'],
      'image': 'asset/images/jessica.jpg',
      'color': Color(0xFFE8D5FF),
    },
    {
      'name': 'Amanda',
      'age': 23,
      'location': 'Surabaya, Indonesia',
      'bio': 'Enjoying life through art and adventure.',
      'interests': ['Art', 'Adventure', 'Cooking'],
      'image': 'asset/images/amanda.jpg',
      'color': Color(0xFFFFE0C2),
    },
    {
      'name': 'Olivia',
      'age': 22,
      'location': 'Yogyakarta, Indonesia',
      'bio': 'Book reader who loves nature and sunsets.',
      'interests': ['Books', 'Nature', 'Travel'],
      'image': 'asset/images/olivia.jpg',
      'color': Color(0xFFFFEBA8),
    },
    {
      'name': 'Bella',
      'age': 20,
      'location': 'Semarang, Indonesia',
      'bio': 'A little sunshine with big dreams.',
      'interests': ['Fashion', 'Music', 'Coffee'],
      'image': 'asset/images/bella.jpg',
      'color': Color(0xFFFFD9C9),
    },
    {
      'name': 'Natasha',
      'age': 24,
      'location': 'Bali, Indonesia',
      'bio': 'Beach lover and sunset enthusiast.',
      'interests': ['Beach', 'Swimming', 'Travel'],
      'image': 'asset/images/natasha.jpg',
      'color': Color(0xFFD5F0E5),
    },

    // ================= LAKI-LAKI =================
    {
      'name': 'Daniel',
      'age': 23,
      'location': 'Jakarta, Indonesia',
      'bio': 'Sports lover and coffee enthusiast.',
      'interests': ['Sports', 'Coffee', 'Music'],
      'image': 'asset/images/daniel.jpg',
      'color': Color(0xFFD5E9FF),
    },
    {
      'name': 'Kevin',
      'age': 22,
      'location': 'Bandung, Indonesia',
      'bio': 'Gamer who enjoys travelling and photography.',
      'interests': ['Gaming', 'Travel', 'Photography'],
      'image': 'asset/images/kevin.jpg',
      'color': Color(0xFFE5D9FF),
    },
    {
      'name': 'Rafael',
      'age': 24,
      'location': 'Surabaya, Indonesia',
      'bio': 'Food explorer and music enthusiast.',
      'interests': ['Food', 'Music', 'Cooking'],
      'image': 'asset/images/rafael.jpg',
      'color': Color(0xFFFFE0C2),
    },
    {
      'name': 'Adrian',
      'age': 21,
      'location': 'Yogyakarta, Indonesia',
      'bio': 'Love books, nature, and new experiences.',
      'interests': ['Books', 'Nature', 'Movies'],
      'image': 'asset/images/adrian.jpg',
      'color': Color(0xFFD5F0E5),
    },
    {
      'name': 'Ethan',
      'age': 23,
      'location': 'Bali, Indonesia',
      'bio': 'Adventure seeker and beach lover.',
      'interests': ['Beach', 'Adventure', 'Swimming'],
      'image': 'asset/images/ethan.jpg',
      'color': Color(0xFFFFE7A3),
    },
    {
      'name': 'Nathan',
      'age': 22,
      'location': 'Semarang, Indonesia',
      'bio': 'Enjoying sports and good conversations.',
      'interests': ['Football', 'Movies', 'Travel'],
      'image': 'asset/images/nathan.jpg',
      'color': Color(0xFFE9D5FF),
    },
    {
      'name': 'William',
      'age': 25,
      'location': 'Jakarta, Indonesia',
      'bio': 'Business minded and always learning.',
      'interests': ['Business', 'Fitness', 'Coffee'],
      'image': 'asset/images/william.jpg',
      'color': Color(0xFFFFD6C9),
    },
    {
      'name': 'Gabriel',
      'age': 21,
      'location': 'Malang, Indonesia',
      'bio': 'Creative soul who loves music and art.',
      'interests': ['Art', 'Music', 'Photography'],
      'image': 'asset/images/gabriel.jpg',
      'color': Color(0xFFD5E9FF),
    },
    {
      'name': 'Vincent',
      'age': 24,
      'location': 'Tangerang, Indonesia',
      'bio': 'Gym enthusiast and weekend traveller.',
      'interests': ['Fitness', 'Travel', 'Food'],
      'image': 'asset/images/vincent.jpg',
      'color': Color(0xFFFFE0C2),
    },
    {
      'name': 'Jonathan',
      'age': 23,
      'location': 'Bogor, Indonesia',
      'bio': 'Nature lover and casual photographer.',
      'interests': ['Nature', 'Photography', 'Hiking'],
      'image': 'asset/images/jonathan.jpg',
      'color': Color(0xFFD5F0E5),
    },
  ];

  // ================= LIKE DAN PASS =================
  Future<void> nextProfile(String action) async {
    if (currentIndex >= filteredProfiles.length) return;

    final selectedProfile =
        Map<String, dynamic>.from(filteredProfiles[currentIndex]);

    final profileName = selectedProfile['name'];

    if (action == 'like') {
      await LikesService.addLike(selectedProfile);
    }

    if (!mounted) return;

    setState(() {
      currentIndex++;
      dragX = 0;
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
  }
    // ================= TAMPILAN UTAMA =================
  @override
  Widget build(BuildContext context) {
    final hasProfiles = currentIndex < filteredProfiles.length;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFDF7),
        elevation: 0,
        automaticallyImplyLeading: true,
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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter akan dikembangkan selanjutnya.'),
                ),
              );
            },
            icon: const Icon(
              Icons.tune_rounded,
              color: Colors.black,
            ),
            tooltip: 'Filter',
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: hasProfiles
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Find your connection 💛',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ================= PILIHAN GENDER =================
                    Row(
                      children: [
                        _genderButton('Semua'),
                        const SizedBox(width: 8),
                        _genderButton('Cewek'),
                        const SizedBox(width: 8),
                        _genderButton('Cowok'),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // ================= PROFILE CARD =================
                            GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                setState(() {
                                  dragX += details.delta.dx;
                                });
                              },
                              onHorizontalDragEnd: (details) {
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
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.08,
                                          ),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // ================= FOTO PROFIL =================
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(25),
                                          ),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 270,
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Image.asset(
                                                  filteredProfiles[currentIndex]
                                                      ['image'],
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) {
                                                    return Container(
                                                      color: filteredProfiles[
                                                          currentIndex]['color'],
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

                                                // LABEL NEW PROFILE
                                                Positioned(
                                                  bottom: 15,
                                                  left: 18,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12,
                                                      vertical: 7,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
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
                                                            fontWeight:
                                                                FontWeight.w600,
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

                                        // ================= INFORMASI PROFIL =================
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${filteredProfiles[currentIndex]['name']}, ${filteredProfiles[currentIndex]['age']}',
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                    filteredProfiles[
                                                        currentIndex]['location'],
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 17),

                                              Text(
                                                filteredProfiles[currentIndex]
                                                    ['bio'],
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
                                                children: (
                                                  filteredProfiles[currentIndex]
                                                          ['interests']
                                                      as List<String>
                                                )
                                                    .map(
                                                      (interest) => Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 13,
                                                          vertical: 8,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                            0xFFFFF2CC,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Text(
                                                          interest,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 22),

                            // ================= TOMBOL LIKE DAN PASS =================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _actionButton(
                                  icon: Icons.close_rounded,
                                  color: Colors.white,
                                  iconColor: Colors.redAccent,
                                  onPressed: () => nextProfile('pass'),
                                ),

                                const SizedBox(width: 30),

                                _actionButton(
                                  icon: Icons.favorite_rounded,
                                  color: const Color(0xFFFFC629),
                                  iconColor: Colors.white,
                                  onPressed: () => nextProfile('like'),
                                ),
                              ],
                            ),

                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                              // ================= HABIS PROFIL =================
              : Center(
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
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentIndex = 0;
                            dragX = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC629),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Show Again'),
                      ),
                    ],
                  ),
                ),
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
          });
        },
        selectedColor: const Color(0xFFFFC629),
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: isSelected
              ? FontWeight.bold
              : FontWeight.normal,
        ),
        side: BorderSide(
          color: isSelected
              ? const Color(0xFFFFC629)
              : Colors.grey.shade300,
        ),
      ),
    );
  }

  // ================= TOMBOL LIKE DAN PASS =================
  Widget _actionButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: color,
      elevation: 4,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 65,
          height: 65,
          child: Icon(
            icon,
            size: 32,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}