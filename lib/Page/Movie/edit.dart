import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/Movie.dart';
import '../../Service/FirestoreService.dart';

void showEditMovieDialog(BuildContext context, Movie movie) {
  showDialog(
    context: context,
    builder: (context) {
      String updatedTitle = movie.title;
      String updatedDirector = movie.director;
      int updatedYear = movie.year;
      String updatedType = movie.type;
      final FirestoreService firestoreService = FirestoreService();
      return AlertDialog(
        title: Text('編輯電影'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => updatedTitle = value,
                decoration: InputDecoration(
                  labelText: '標題',
                  hintText: movie.title,
                ),
              ),
              TextField(
                onChanged: (value) => updatedDirector = value,
                decoration: InputDecoration(
                  labelText: '導演',
                  hintText: movie.director,
                ),
              ),
              TextField(
                onChanged: (value) => updatedYear = int.parse(value),
                decoration: InputDecoration(
                  labelText: '出產年',
                  hintText: movie.year.toString(),
                ),
              ),
              TextField(
                onChanged: (value) => updatedType = value,
                decoration: InputDecoration(
                  labelText: '類型',
                  hintText: movie.type,
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text('取消'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('儲存'),
            onPressed: () {
              final updatedMovie = Movie(
                movieId: movie.movieId,
                title: updatedTitle,
                director: updatedDirector,
                year: updatedYear,
                type: updatedType,
              );
              firestoreService.updateMovie(movie.movieId, updatedMovie);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}