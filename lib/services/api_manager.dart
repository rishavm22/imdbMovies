import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imd_assignment/constants/strings_constant.dart';
import 'package:imd_assignment/models/movies.dart';

class ApiManager {
  var movies;
  Future<Movies> getMovies(String title) async{
    Movies searchedMovie;
    var client = http.Client();
    try {
      var response;
      response  = await client
          .get(Uri.parse(StringsConstants.moviesUrl));
      movies = Movies.fromJson(json.decode(response.body));
      if(title.isNotEmpty){
        searchedMovie= Movies.fromJson(json.decode(response.body));
        if(searchedMovie.getMovie(title).items.length>0) {
          movies = searchedMovie.getMovie(title);
          return movies;
        }else {
          return new Movies(items: [],errorMessage: 'Not Found');
        }
      }
      return movies;
    }
    catch(error) {
      return new Movies(items: [],errorMessage: 'Not Found');
    }
  }
}