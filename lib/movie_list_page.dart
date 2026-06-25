// movie_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_bloc.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key}); // Parameter constructor lama dihapus

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Movie Catalog'),
      ),
      // Menggunakan BlocBuilder untuk mendengarkan aliran State (Stream) dari BLoC
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MovieLoaded) {
            final movies = state.movies;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
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

                        // Tombol Favorite memicu Event ke BLoC
                        IconButton(
                          onPressed: () {
                            // Memicu Event merubah status favorite ke BLoC
                            context.read<MovieBloc>().add(ToggleFavoriteEvent(index));
                          },
                          icon: Icon(
                            movie['isFavorite'] == true ? Icons.favorite : Icons.favorite_border,
                            color: movie['isFavorite'] == true ? Colors.red : Colors.grey,
                          ),
                          tooltip: movie['isFavorite'] == true ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return const Center(child: Text('Gagal Memuat Data'));
        },
      ),
    );
  }
}