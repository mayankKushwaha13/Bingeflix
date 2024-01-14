import 'package:flutter/material.dart';

class WatchListProvider extends ChangeNotifier{
  List _watchlistMovies=[];
  get watchlistMovies => _watchlistMovies;

  void addToWatchlist(List x,int index){
    _watchlistMovies.add(x[index]);
    notifyListeners();
  }
}