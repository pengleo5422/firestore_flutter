import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/Movie.dart';
import '../../Service/FirestoreService.dart';
void showAddMovieDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      String movieId = '';
      String title = '';
      String director = '';
      int year = 0;
      String type = '';
      final FirestoreService firestoreService = FirestoreService();
      return AlertDialog(
        title: Text('新增電影'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => movieId = value,
                decoration: InputDecoration(labelText: '編號'),
              ),
              TextField(
                onChanged: (value) => title = value,
                decoration: InputDecoration(labelText: '標題'),
              ),
              TextField(
                onChanged: (value) => director = value,
                decoration: InputDecoration(labelText: '導演'),
              ),
              TextField(
                onChanged: (value) => year = int.parse(value),
                decoration: InputDecoration(labelText: '出產年'),
              ),
              TextField(
                onChanged: (value) => type = value,
                decoration: InputDecoration(labelText: '類型'),
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
              final newMovie = Movie(
                movieId: movieId,
                title: title,
                director: director,
                year: year,
                type: type,
              );

              firestoreService.addMovie(newMovie);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}