import 'package:flutter/cupertino.dart';

class ClassReserva with ChangeNotifier{
  String  _userID;
  String  _restaurantID;
  String  _reservafirstName;
  String  _reservalastName;
  String  _reservanumeroIdentidad;
  int     _reservamaxPersons;
  String  _reservadate;
  String  _reservamessage; 

  String get reservafirstName => this._reservafirstName;
  String get reservalastName => this._reservalastName;
  String get reservanumeroIdentidad => this._reservanumeroIdentidad;
  int get reservamaxPersons => this._reservamaxPersons;
  String get reservadate => this._reservadate;
  String get reservamessage => this._reservamessage;

  String get userID => this._userID;
  String get restaurantID => this._restaurantID;

  set reservafirstName(String reservafirstName){
    this._reservafirstName = reservafirstName;
  }
  set reservalastName(String reservalastName){
    this._reservalastName = reservalastName;
  }
  set reservanumeroIdentidad(String reservanumeroIdentidad){
    this._reservanumeroIdentidad = reservanumeroIdentidad;
  }
  set reservamaxPersons(int reservamaxPersons){
    this._reservamaxPersons = reservamaxPersons;
  }
  set reservadate(String reservadate){
    this._reservadate = reservadate;
  }
  set reservamessage(String reservamessage){
    this._reservamessage = reservamessage;
  }

  set userID(String id){
    this._userID = id;
  }

  set restaurantID(String id){
    this._restaurantID=id;
  }
}