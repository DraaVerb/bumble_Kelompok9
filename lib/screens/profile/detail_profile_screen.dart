
import 'package:flutter/material.dart';

class DetailProfileScreen extends StatelessWidget {
  final Map<String, dynamic> profile;
  final VoidCallback onLike;
  final VoidCallback onPass;

  const DetailProfileScreen({
    super.key,
    required this.profile,
    required this.onLike,
    required this.onPass,
  });

  static const Color yellow = Color(0xFFFFC629);

  @override
  Widget build(BuildContext context) {
    final interests = profile['interests'] as List? ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFDF7),
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text(
          'Detail Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FOTO PROFIL
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 380,
                child: Image.asset(
                  profile['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: profile['color'] as Color? ??
                          Colors.grey.shade300,
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 120,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAMA DAN UMUR
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${profile['name']}, ${profile['age']}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 25,
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // LOKASI
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          profile['location'] ?? 'Lokasi tidak tersedia',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // BIO
                  const Text(
                    'Tentang Saya',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    profile['bio'] ?? 'Belum ada deskripsi.',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // MINAT
                  const Text(
                    'Minat dan Hobi',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 9,
                    runSpacing: 9,
                    children: interests.map((interest) {
                      return Chip(
                        label: Text(interest.toString()),
                        backgroundColor: const Color(0xFFFFF2CC),
                        side: BorderSide.none,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 35),

                  // TOMBOL LIKE DAN PASS
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onPass,
                          icon: const Icon(Icons.close_rounded),
                          label: const Text('Pass'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            side: const BorderSide(
                              color: Colors.redAccent,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onLike,
                          icon: const Icon(Icons.favorite),
                          label: const Text('Like'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellow,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
