import 'package:flutter/cupertino.dart';

class ModelTopRest extends ChangeNotifier {

  int _topBodyPage = 1;

  int get topBodyPage => this._topBodyPage;
  set topBodyPage(int index){
    this._topBodyPage = index;
    notifyListeners();
  }

  
}