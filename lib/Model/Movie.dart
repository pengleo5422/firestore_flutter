class Movie {
  final String movieId;
  final String title;
  final String director;
  final int year;
  final String type;

  Movie({
    required this.movieId,
    required this.title,
    required this.director,
    required this.year,
    required this.type,
  });

  factory Movie.fromMap(Object? map) {
    final data = Map<String, dynamic>.from(map as Map<dynamic, dynamic>);
    return Movie(
      movieId: data['movieId'],
      title: data['title'],
      director: data['director'],
      year: data['year'],
      type: data['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movieId': movieId,
      'title': title,
      'director': director,
      'year': year,
      'type': type,
    };
  }
}