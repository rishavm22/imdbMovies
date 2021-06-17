import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  bool _isMoviesListCalling = true;

  bool get isMoviesListCalling => _isMoviesListCalling;

  setIsMoviesListCalling(bool value) {
    _isMoviesListCalling = value;
    notifyListeners();
  }

}