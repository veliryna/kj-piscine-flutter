class Movie {
  final String genre;
  final String imdbRating;
  final String title;
  final String poster;
  final String year;
  final String actors;
  final String language;

  Movie(this.genre, this.imdbRating, this.title, this.poster, this.year, this.actors, this.language);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        json['Genre'],
        json['imdbRating'],
        json['Title'],
        json['Poster'],
        json['Year'],
        json['Actors'],
        json['Language']
    );
  }
}
