import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Model/Movie.dart';
import '../../Service/FirestoreService.dart';

void showDeleteMovieDialog(BuildContext context, Movie movie) {
  showDialog(
    context: context,
    builder: (context) {
      final FirestoreService firestoreService = FirestoreService();
      return AlertDialog(
        title: Text('刪除電影'),
        content: Text('確定要刪除此電影嗎？'),
        actions: [
          ElevatedButton(
            child: Text('取消'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('刪除'),
            onPressed: () {
              firestoreService.deleteMovie(movie);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

