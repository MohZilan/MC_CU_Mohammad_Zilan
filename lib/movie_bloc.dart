// movie_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

// ─── EVENTS ──────────────────────────────────────────────────────────────────
abstract class MovieEvent {}

// Event untuk memuat daftar film pertama kali
class LoadMoviesEvent extends MovieEvent {}

// Event ketika user menekan tombol favorite
class ToggleFavoriteEvent extends MovieEvent {
  final int index;
  ToggleFavoriteEvent(this.index);
}

// ─── STATES ──────────────────────────────────────────────────────────────────
abstract class MovieState {}

// Keadaan awal aplikasi sebelum memuat data
class MovieInitial extends MovieState {}

// Keadaan ketika data film siap ditampilkan atau setelah diperbarui
class MovieLoaded extends MovieState {
  final List<Map<String, dynamic>> movies;
  MovieLoaded(this.movies);
}

// ─── BLOC BUSINESS LOGIC ─────────────────────────────────────────────────────
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  // Data master film dipindahkan ke dalam BLoC agar aman dari manipulasi langsung UI
  final List<Map<String, dynamic>> _masterMovies = [
    {
      'title': 'The Shawshank Redemption',
      'content': 'Over the course of several years, two convicts form a friendship, finding consolation and eventual redemption through acts of common decency.',
      'rating': '9.3',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
    {
      'title': 'The Godfather',
      'content': 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
      'rating': '9.2',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
    {
      'title': 'The Dark Knight',
      'content': 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      'rating': '9.0',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
    {
      'title': 'Pulp Fiction',
      'content': 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
      'rating': '8.9',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
    {
      'title': 'Inception',
      'content': 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
      'rating': '8.8',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
  ];

  MovieBloc() : super(MovieInitial()) {
    // Handler saat Event LoadMovies dipanggil
    on<LoadMoviesEvent>((event, emit) {
      emit(MovieLoaded(List.from(_masterMovies)));
    });

    // Handler saat Event ToggleFavorite dipanggil
    on<ToggleFavoriteEvent>((event, emit) {
      // Ubah status boolean favorit berdasarkan indeks yang dikirim UI
      _masterMovies[event.index]['isFavorite'] = !_masterMovies[event.index]['isFavorite'];

      // Lempar State baru yang membawa list data terupdate agar UI merender ulang
      emit(MovieLoaded(List.from(_masterMovies)));
    });
  }
}