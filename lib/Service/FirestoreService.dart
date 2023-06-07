import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/Movie.dart';

class FirestoreService {
  final CollectionReference moviesCollection =
  FirebaseFirestore.instance.collection('movies');

  Future<void> addMovie(Movie movie) {
    Map<String, dynamic> mov = movie.toMap();
    return moviesCollection.doc(mov['movieId']).set(mov);

  }

  Stream<List<Movie>> getMovies() {
    return moviesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList();
    });
  }

  Future<void> updateMovie(String movieId, Movie updatedMovie) {
    return moviesCollection.doc(movieId).update(updatedMovie.toMap());
  }

  Future<void> deleteMovie(Movie movie) async {
    try {
      final movieId = movie.movieId;
      await moviesCollection.doc(movieId).delete();
      print(movieId);
    } catch (e) {
      print('刪除電影時發生錯誤：$e');
    }
  }
  Future<List<Movie>> searchMoviesByTitle(String movieId) async {
    final querySnapshot = await moviesCollection.where('movieId', isEqualTo: movieId).get();
    final movies = querySnapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList();
    print(movies);
    return movies;
  }

}

