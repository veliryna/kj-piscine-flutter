import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'movie.dart';
import 'movie_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movie List',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<Movie>> _movies;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _movies = _loadMovies();
    _searchController = TextEditingController();
  }

  Future<List<Movie>> _loadMovies() async {
    String data = await rootBundle.loadString('assets/movies.json');
    List<dynamic> jsonData = json.decode(data);
    List<Movie> movies = [];
    for (var item in jsonData) {
      movies.add(Movie.fromJson(item));
    }
    movies.sort((a, b) => b.imdbRating.compareTo(a.imdbRating));
    return movies;
  }

  List<Movie> _filteredMovies(List<Movie> movies, String query) {
    return movies
        .where((movie) =>
        movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: _movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Movie> filteredMovies =
            _filteredMovies(snapshot.data!, _searchController.text);
            return ListView.builder(
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                return Card.outlined(
                  elevation: 5.0,
                  child: ListTile(
                    leading: Image.network(
                      filteredMovies[index].poster,
                      fit: BoxFit.fill,
                      width: 50.0,
                      height: 60.0,
                    ),
                    title: Text(
                        filteredMovies[index].title,
                      style: const TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    subtitle: Text(
                        filteredMovies[index].genre,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey.shade600
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailPage(movie: filteredMovies[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

