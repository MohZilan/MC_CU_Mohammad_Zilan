import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final Set<String> favoriteMovies = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(
        title: 'Movie Catalog',
        favoriteMovies: favoriteMovies,
        onFavoriteChanged: (movieTitle, isFavorite) {
          setState(() {
            if (isFavorite) {
              favoriteMovies.add(movieTitle);
            } else {
              favoriteMovies.remove(movieTitle);
            }
          });
        },
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.favoriteMovies,
    required this.onFavoriteChanged,
  });

  final String title;
  final Set<String> favoriteMovies;
  final Function(String, bool) onFavoriteChanged;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> movies = [
    {
      'title': 'The Shawshank Redemption',
      'content': 'Over the course of several years, two convicts form a friendship, finding consolation and eventual redemption through acts of common decency.',
      'rating': '9.3',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'description': 'Direksi oleh Frank Darabont, film ini menceritakan kisah dua tahanan yang menjalin persahabatan dalam di penjara Shawshank. Mereka saling memberi harapan dan kekuatan untuk terus hidup. Melalui tindakan kebaikan, mereka menemukan penebusan dan kebebasan dari penindasan.',
    },
    {
      'title': 'The Godfather',
      'content': 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
      'rating': '9.2',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'description': 'Sebuah epos klasik yang mengikuti keluarga Corleone, seorang ayah tua menyerahkan kontrol kekaisaran gelap organisasi kriminalnya kepada putranya yang enggan. Film ini menampilkan pertarungan kekuasaan dan kesetiaan keluarga.',
    },
    {
      'title': 'The Dark Knight',
      'content': 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      'rating': '9.0',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'description': 'Dengan teror Joker di Gotham City, Batman harus menghadapi tantangan psikologis dan fisik terberat dalam karirnya. Film ini menggali kedalaman karakter Batman dan moralitas dari heroisme sejati.',
    },
    {
      'title': 'Pulp Fiction',
      'content': 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
      'rating': '8.9',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'description': 'Empat cerita yang saling terhubung melibatkan dua pembunuh bayaran, petinju, gembong dan istrinya, serta sepasang perampok restoran. Kehidupan mereka bersinggungan dalam narasi yang kompleks dan penuh gaya.',
    },
    {
      'title': 'Inception',
      'content': 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
      'rating': '8.8',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
      'description': 'Seorang pencuri yang ahli dalam mencuri rahasia perusahaan melalui teknologi berbagi mimpi diberi tugas sebaliknya untuk menanamkan ide ke dalam pikiran seorang CEO. Film ini mengeksplorasi lapisan-lapisan realitas dan kesadaran.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movieTitle = movies[index]['title']!;
            final isFavorite = widget.favoriteMovies.contains(movieTitle);

            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                        movie: movies[index],
                        isFavorite: isFavorite,
                        onFavoriteChanged: (newStatus) {
                          widget.onFavoriteChanged(movieTitle, newStatus);
                        },
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Image.network(
                      movies[index]['image']!,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 100,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movies[index]['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            movies[index]['content']!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 20),
                              Text(movies[index]['rating']!),
                            ],
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        widget.onFavoriteChanged(movieTitle, !isFavorite);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class MovieDetailPage extends StatefulWidget {
  final Map<String, String> movie;
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;

  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}


class _MovieDetailPageState extends State<MovieDetailPage> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.movie['title']!),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              widget.onFavoriteChanged(isFavorite);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Image
              Center(
                child: Image.network(
                  widget.movie['image']!,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                widget.movie['title']!,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Rating
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Rating: ${widget.movie['rating']!}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Content Section
              Text(
                'Sinopsis',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                widget.movie['content']!,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),

              // Description Section
              Text(
                'Deskripsi Lengkap',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                widget.movie['description'] ?? 'Tidak ada deskripsi',
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 30),

              // Favorite Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                    widget.onFavoriteChanged(isFavorite);
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.purple,
                  ),
                  label: Text(
                    isFavorite ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
