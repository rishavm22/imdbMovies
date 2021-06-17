import 'package:flutter/material.dart';

class ModeProvider extends ChangeNotifier {
  bool _movieSearchMode=false;
  String _title='';

  bool get getMovieSearchMode => _movieSearchMode;
  String get getTitle => _title;

  movieSearchModeOn(String title) {
    _title=title;
    _movieSearchMode = true;
    notifyListeners();
  }
  movieSearchModeOff() {
    _title='';
    _movieSearchMode = false;
    notifyListeners();
  }
}