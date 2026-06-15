import 'package:flutter/material.dart';
import 'movie_list_page.dart';
import 'favorite_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Daftar film global — shared antara kedua halaman
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'The Shawshank Redemption',
      'content':
      'Over the course of several years, two convicts form a friendship, finding consolation and eventual redemption through acts of common decency.',
      'rating': '9.3',
      'image':
      'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
    {
      'title': 'The Godfather',
      'content':
      'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
      'rating': '9.2',
      'image':
      'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
    {
      'title': 'The Dark Knight',
      'content':
      'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      'rating': '9.0',
      'image':
      'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
    {
      'title': 'Pulp Fiction',
      'content':
      'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
      'rating': '8.9',
      'image':
      'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
    {
      'title': 'Inception',
      'content':
      'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
      'rating': '8.8',
      'image':
      'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'isFavorite': false,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      movies[index]['isFavorite'] = !movies[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MovieListPage(
        movies: movies,
        onToggleFavorite: _toggleFavorite,
      ),
      FavoritePage(
        movies: movies,
        onToggleFavorite: _toggleFavorite,
      ),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            selectedIcon: Icon(Icons.movie),
            label: 'Movies',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}