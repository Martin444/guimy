import 'package:flutter/cupertino.dart';

class ClassMisions with ChangeNotifier{

  List<OneMision> _listaMisiones;

  List<OneMision> get listaMisiones => this._listaMisiones;
  set listaMisiones(List lista){
    this._listaMisiones = cargarMisiones(lista);
    notifyListeners();
  }
  

   List cargarMisiones(List misions){
     List<OneMision> misiones = misions?.map((m) {
      //  print("##%%%%%%%##  $m");
       return new OneMision(m);
     })?.toList()??[];
    return misiones;
   }

}

class OneMision {

  OneMision(Map m){
    misionID          = m["id"];
    misionName        = m["name"];
    misionNeedsAction = m["needs_action"];
    misionGivePoints  = int.parse(m["gives_points"].toString());
    misionNeedsTotal  = int.parse(m["needs_total"].toString());
  }

  String  _misionID;
  String  _misionName;
  String  _misionNeedsAction;
  int     _misionGivePoints;
  int     _misionNeedsTotal;

   String get misionID => this._misionID;
   String get misionName => this._misionName;
   String get misionNeedsAction => this._misionNeedsAction;
   int get misionGivePoints => this._misionGivePoints;
   int get misionNeedsTotal => this._misionNeedsTotal;


   set misionID(String misionID){
     this._misionID = misionID;
   }
   set misionName(String misionName){
     this._misionName = misionName;
   }
   set misionNeedsAction(String misionNeedsAction){
     this._misionNeedsAction = misionNeedsAction;
   }
   set misionGivePoints(int misionGivePoints){
     this._misionGivePoints = misionGivePoints;
   }
   set misionNeedsTotal(int misionNeedsTotal){
     this._misionNeedsTotal = misionNeedsTotal;
   }
}