import 'package:flutter/cupertino.dart';

class ClassRespQr with ChangeNotifier{
  String _restaurantID;
  String _sucursalID;

  cargarRespuesta(Map modelo){
    restaurantID = modelo["restaurant"];
    sucursalID = modelo["sucursal"];
  }

  String get restaurantID => this._restaurantID;
  String get sucursalID => this._sucursalID;

  set restaurantID(String restaurant){
    this._restaurantID = restaurant; 
  }

  set sucursalID(String sucursal){
    this._sucursalID = sucursal;
  }
}