import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/Movie.dart';
import '../../Service/FirestoreService.dart';
import 'add.dart';
import 'delete.dart';
import 'edit.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}
class _MovieScreenState extends State<MovieScreen> {
  final FirestoreService firestoreService = FirestoreService();
  List<Movie> searchResults = [];
  String searchKeyword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('電影'),
      ),
      body: StreamBuilder<List<Movie>>(
        stream: firestoreService.getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data;
            if (searchKeyword.isNotEmpty && searchResults.isNotEmpty) {
              return ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final movie = searchResults[index];
                  return ListTile(
                    title: Text(movie.title),
                    subtitle: Text(movie.director),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showEditMovieDialog(context, movie);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDeleteMovieDialog(context, movie);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return ListView.builder(
                itemCount: movies!.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ListTile(
                    title: Text(movie.title),
                    subtitle: Text(movie.director),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showEditMovieDialog(context, movie);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDeleteMovieDialog(context, movie);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showAddMovieDialog(context);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchKeyword = value;
              });
            },
            decoration: InputDecoration(
              labelText: '搜尋編號',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final matchingMovies =
                  await firestoreService.searchMoviesByTitle(searchKeyword);
                  setState(() {
                    searchResults = matchingMovies;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
