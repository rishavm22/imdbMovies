import 'package:flutter/material.dart';
import 'package:imd_assignment/models/movies.dart';
import 'package:imd_assignment/provider/homePageProvider.dart';
import 'package:imd_assignment/provider/modeProvider.dart';
import 'package:imd_assignment/services/api_manager.dart';
import 'package:provider/provider.dart';

import 'movie_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Movies>? _movies;
  TextEditingController movieTitle =TextEditingController();
  // String mode= 'movies';

  @override
  void initState() {
    _movies = ApiManager().getMovies('');
    super.initState();
  }

  getMovies() async {
    context.read<HomePageProvider>().setIsMoviesListCalling(true);
    var movieTitle = context.read<ModeProvider>().getTitle;
    _movies = ApiManager().getMovies(movieTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            top: 50,
            right: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Home',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                TextFormField(
                  controller: movieTitle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal),
                    ),
                    hintText: 'Search for movies',
                    hintStyle: TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: () {
                        String title= movieTitle.text.toLowerCase().trim();
                        var mode = context.read<ModeProvider>();
                        title.trim().isNotEmpty
                            ? mode.movieSearchModeOn(title)
                            : mode.movieSearchModeOff();
                        getMovies();
                      },
                      icon: Icon(Icons.search),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(25, 12, 15, 12),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Consumer<ModeProvider>(
                  builder: (context, data, child) {
                    return moviesList(context, _movies!);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
