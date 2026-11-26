
import 'package:flutter/material.dart';
import '../../services/likes_service.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = LikesService.loadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF7),
      appBar: AppBar(
        title: const Text(
          'Likes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFFDF7),
        elevation: 0,
      ),
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFC629),
              ),
            );
          }

          return ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: LikesService.likedProfiles,
            builder: (context, profiles, child) {
              if (profiles.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          size: 75,
                          color: Color(0xFFFFC629),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No Likes Yet',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Profil yang kamu sukai akan muncul di sini.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final profile = profiles[index];

                  final colorValue =
                      (profile['color'] as num?)?.toInt() ??
                          0xFFFFD6C9;

                  final interests =
                      (profile['interests'] as List?) ?? [];

                  final imagePath =
                      profile['image']?.toString() ?? '';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // FOTO PROFIL
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              width: 85,
                              height: 100,
                              child: imagePath.isNotEmpty
                                  ? Image.asset(
                                      imagePath,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Color(colorValue),
                                          child: Center(
                                            child: Text(
                                              profile['emoji'] ?? '💛',
                                              style: const TextStyle(
                                                fontSize: 42,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      color: Color(colorValue),
                                      child: Center(
                                        child: Text(
                                          profile['emoji'] ?? '💛',
                                          style: const TextStyle(
                                            fontSize: 42,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          // INFORMASI PROFIL
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${profile['name']}, ${profile['age']}',
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  profile['location'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                Text(
                                  profile['bio'] ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),

                                const SizedBox(height: 8),

                                Wrap(
                                  spacing: 5,
                                  children: interests
                                      .take(3)
                                      .map(
                                        (interest) => Chip(
                                          label: Text(
                                            interest.toString(),
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          backgroundColor:
                                              const Color(0xFFFFF2CC),
                                          visualDensity:
                                              VisualDensity.compact,
                                          padding: EdgeInsets.zero,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),

                          // HAPUS LIKE
                          IconButton(
                            tooltip: 'Remove Like',
                            onPressed: () async {
                              await LikesService.removeLike(
                                profile['name'].toString(),
                              );
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
