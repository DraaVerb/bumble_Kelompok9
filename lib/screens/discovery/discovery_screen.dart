
import 'package:flutter/material.dart';
import '../../services/likes_service.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> profiles = [
    {
      'name': 'Alyssa',
      'age': 21,
      'location': 'Jakarta, Indonesia',
      'bio': 'Coffee lover ☕ | Travelling | Music enthusiast',
      'interests': ['Music', 'Travel', 'Coffee'],
      'emoji': '🌸',
      'color': Color(0xFFFFD6C9),
    },
    {
      'name': 'Michelle',
      'age': 22,
      'location': 'Bandung, Indonesia',
      'bio': 'Enjoying little things in life. Let’s explore together!',
      'interests': ['Photography', 'Nature', 'Movies'],
      'emoji': '🌻',
      'color': Color(0xFFFFE7A3),
    },
    {
      'name': 'Nadia',
      'age': 20,
      'location': 'Yogyakarta, Indonesia',
      'bio': 'Food hunter, book reader, and adventure seeker.',
      'interests': ['Food', 'Books', 'Adventure'],
      'emoji': '🌷',
      'color': Color(0xFFE9D5FF),
    },
    {
      'name': 'Sofia',
      'age': 23,
      'location': 'Surabaya, Indonesia',
      'bio': 'Life is better with good music and good people.',
      'interests': ['Music', 'Art', 'Cooking'],
      'emoji': '🌼',
      'color': Color(0xFFD5E9FF),
    },
  ];

  
Future<void> nextProfile(String action) async {
  if (currentIndex >= profiles.length) return;

  final selectedProfile =
      Map<String, dynamic>.from(profiles[currentIndex]);

  final profileName = selectedProfile['name'];

  // Simpan profil jika tombol Like ditekan.
  if (action == 'like') {
    await LikesService.addLike(selectedProfile);
  }

  if (!mounted) return;

  setState(() {
    currentIndex++;
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

  @override
  Widget build(BuildContext context) {
    final hasProfiles = currentIndex < profiles.length;

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

                    const SizedBox(height: 18),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // PROFILE CARD
                            Container(
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
                                  // PROFILE VISUAL
                                  ClipRRect(
                                    borderRadius:
                                        const BorderRadius.vertical(
                                      top: Radius.circular(25),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 270,
                                      color: profiles[currentIndex]['color'],
                                      child: Stack(
                                        children: [
                                          const Positioned(
                                            top: 15,
                                            right: 15,
                                            child: Icon(
                                              Icons.favorite,
                                              color: Colors.white54,
                                              size: 30,
                                            ),
                                          ),

                                          Center(
                                            child: Text(
                                              profiles[currentIndex]['emoji'],
                                              style: const TextStyle(
                                                fontSize: 105,
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                            bottom: 15,
                                            left: 18,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 7,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
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

                                  // PROFILE INFORMATION
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
                                                '${profiles[currentIndex]['name']}, ${profiles[currentIndex]['age']}',
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
                                              profiles[currentIndex]
                                                  ['location'],
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 17),

                                        Text(
                                          profiles[currentIndex]['bio'],
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
                                          children: [
                                            ...(
                                              profiles[currentIndex]
                                                  ['interests'] as List<String>
                                            ).map(
                                              (interest) => Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 13,
                                                  vertical: 8,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFFF2CC),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  interest,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 22),

                            // LIKE AND PASS BUTTONS
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
