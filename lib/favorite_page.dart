// favorite_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key}); // Parameter constructor lama dihapus

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Favorite'),
      ),
      // Menangkap state dari MovieBloc
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoaded) {
            // Memfilter film favorit secara dinamis dari State BLoC
            final List<({int originalIndex, Map<String, dynamic> movie})> favorites = [
              for (int i = 0; i < state.movies.length; i++)
                if (state.movies[i]['isFavorite'] == true)
                  (originalIndex: i, movie: state.movies[i]),
            ];

            return favorites.isEmpty
                ? _buildEmptyState(context)
                : _buildList(context, favorites);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // ─── Empty State ──────────────────────────────────────────────────────────
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.heart_broken_outlined,
              size: 90,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            Text(
              'Data Favorite Tidak Ada',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Belum ada film yang kamu favoritkan.\nTambahkan film dari halaman Movies.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── List Film Favorit (tanpa icon favorite sesuai ketentuan) ──────────────
  Widget _buildList(
      BuildContext context,
      List<({int originalIndex, Map<String, dynamic> movie})> favorites,
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, i) {
          final movie = favorites[i].movie;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    movie['image']!,
                    fit: BoxFit.cover,
                    width: 90,
                    height: 110,
                  ),
                ),
                const SizedBox(width: 10),

                // Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie['content']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 2),
                            Text(
                              movie['rating']!,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}