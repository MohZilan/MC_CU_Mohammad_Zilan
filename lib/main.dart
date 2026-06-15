import 'package:flutter/material.dart';


void main() {

  runApp(const MyApp());

}


class MyApp extends StatelessWidget {

  const MyApp({super.key});


// This widget is the root of your application.

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',

      theme: ThemeData(

// This is the theme of your application.

//

// TRY THIS: Try running your application with "flutter run". You'll see

// the application has a purple toolbar. Then, without quitting the app,

// try changing the seedColor in the colorScheme below to Colors.green

// and then invoke "hot reload" (save your changes or press the "hot

// reload" button in a Flutter-supported IDE, or press "r" if you used

// the command line to start the app).

//

// Notice that the counter didn't reset back to zero; the application

// state is not lost during the reload. To reset the state, use hot

// restart instead.

//

// This works for code too, not just values: Most code changes can be

// tested with just a hot reload.

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

      ),

      home: const MyHomePage(title: 'Movie Catalog'),

    );

  }

}


class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});


// This widget is the home page of your application. It is stateful, meaning

// that it has a State object (defined below) that contains fields that affect

// how it looks.


// This class is the configuration for the state. It holds the values (in this

// case the title) provided by the parent (in this case the App widget) and

// used by the build method of the State. Fields in a Widget subclass are

// always marked "final".


  final String title;


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
    },
    {
      'title': 'The Godfather',
      'content': 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
      'rating': '9.2',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
    },
    {
      'title': 'The Dark Knight',
      'content': 'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      'rating': '9.0',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
    },
    {
      'title': 'Pulp Fiction',
      'content': 'The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
      'rating': '8.9',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
    },
    {
      'title': 'Inception',
      'content': 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
      'rating': '8.8',
      'image': 'https://cdn.pixabay.com/photo/2016/01/09/18/27/camera-1130731_1280.jpg',
    },
  ];



  int _counter = 0;


  void _incrementCounter() {

    setState(() {

// This call to setState tells the Flutter framework that something has

// changed in this State, which causes it to rerun the build method below

// so that the display can reflect the updated values. If we changed

// _counter without calling setState(), then the build method would not be

// called again, and so nothing would appear to happen.

      _counter++;

    });

  }




  @override

  Widget build(BuildContext context) {

// This method is rerun every time setState is called, for instance as done

// by the _incrementCounter method above.

//

// The Flutter framework has been optimized to make rerunning build methods

// fast, so that you can just rebuild anything that needs updating rather

// than having to individually change instances of widgets.

    return Scaffold(

      appBar: AppBar(

// TRY THIS: Try changing the color here to a specific color (to

// Colors.amber, perhaps?) and trigger a hot reload to see the AppBar

// change color while the other colors stay the same.

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

// Here we take the value from the MyHomePage object that was created by

// the App.build method, and use it to set our appbar title.

        title: Text(widget.title),

      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Card(
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
                  )
                ],
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: _incrementCounter,

        tooltip: 'Increment',

        child: const Icon(Icons.add),

      ),

    );

  }

}
