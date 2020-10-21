
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:guimyapp/src/Pages/Body/RestaurandBody.dart';

class ClassRestaurant with ChangeNotifier {
  String _restID;
  String _restEmail; 
  String _resLatitud;
  String _resLongitud;
  String _resName;
  String _resPhone;
  String _resDetails;
  String _resManager;
  String _resLogo;
  List<Categorias> _resCategories;

  List<Comentario> _comentarios;

  // List<Widget> _widgetsComentarios;
  

  // List get widgetsComentarios => this._widgetsComentarios;
  // set widgetsComentarios(List<Comentario> comentarios){
  //   this._comentarios = comentarios?.map((Comentario comentario) {
  //     return Opiniones(comentario: comentario.comentary,autor: comentario.nameComplete,);
  //   })?.toList()??[];
  //   notifyListeners();
  // }


  List<Comentario> get comentarios => this._comentarios;
  set comentarios(List lista){
    this._comentarios = lista.map((comentario) {
      return Comentario(comentario["NameComplete"], comentario["commentary"], comentario["date_public"]);
    })?.toList()??[];
    notifyListeners();
  }

  nuevoComentario(comentario){
    this._comentarios.add(Comentario(comentario["NameComplete"], comentario["commentary"], comentario["date_public"]));
    notifyListeners();
  }

  String _comentarioUser;

  String get comentarioUser => this._comentarioUser;
  set comentarioUser(String coment){
    this._comentarioUser = coment;
    notifyListeners();
  }

  

  String get restID => this._restID;
  String get restEmail => this._restEmail;
  String get resLatitud => this._resLatitud;
  String get resLongitud => this._resLongitud;
  String get resName => this._resName;
  String get resPhone => this._resPhone;
  String get resDetails => this._resDetails;
  String get resManager => this._resManager;
  String get resLogo => this._resLogo;
  List<Categorias> get resCategories => this._resCategories;


  set restID (String restID){
    this._restID = restID;
  }
  set restEmail (String restEmail){
    this._restEmail = restEmail;
  }
  set resLatitud (String resLatitud){
    this._resLatitud = resLatitud;
  }
  set resLongitud (String resLongitud){
    this._resLongitud = resLongitud;
  }
  set resName (String resName){
    this._resName = resName;
    notifyListeners();
  }
  set resPhone (String resPhone){
    this._resPhone = resPhone;
  }
  set resDetails (String resDetails){
    this._resDetails = resDetails;
  }
  set resManager (String resManager){
    this._resManager = resManager;
  }

  set resLogo(String logo){
    this._resLogo = logo;
  }

  set resCategories(List categoriasJson){
    // this._resCategories= ;
    this._resCategories = categoriasJson.map((categoria) {
      return Categorias(categoria["category"],categoria["restaurant"],categoria["information"]);
    }).toList();
  }

  cargarDatos(Map datos){
    print("########### datos ######### $datos");
    restID        = datos["restaurants_by_pk"]["id"];
    restEmail     = datos["restaurants_by_pk"]["email"];
    resLatitud    = datos["restaurants_by_pk"]["latitude"]??"nulo";
    resLongitud   = datos["restaurants_by_pk"]["longitude"]??"nulo";
    resName       = datos["restaurants_by_pk"]["name"];
    resPhone      = datos["restaurants_by_pk"]["phone"];
    resDetails    = datos["restaurants_by_pk"]["details"];
    resLogo       = datos["restaurants_by_pk"]["logo"];

    resCategories = datos["restaurant_categories"];


    // print("restID = ... $restID");
    // print("restEmail = ... $restEmail");
    // print("resLatitud = ... $resLatitud");
    // print("resLongitud = ... $resLongitud");
    // print("resName = ... $resName");
    // print("resPhone = ... $resPhone");
    // print("resDetails = ... $resDetails");
    // print("resLogo = ... $resLogo");
    // print("______##______ ");
    // print("resCategories = ... ${resCategories[0].imprimir()}");
    // print("resCategories = ... ${resCategories[1].imprimir()}");
  }

  cargarComentarios(Map datos){
    comentarios = datos["restaurant_comments"];
    //notifyListeners();
  }


}

class Categorias{
  String _categoryID ;
  String _restaurantID;
  Map _informacion;

  Categorias(String categoria, String restaurant, Map infor){
    categoryID = categoria;
    restaurantID = restaurant;
    informacion = infor;
  }

  String get categoryID => this._categoryID;
  String get restaurantID => this._restaurantID;
  Map get informacion => this._informacion;

  set categoryID(String categoria){
    this._categoryID =categoria;
  }

  set restaurantID(String restaurant){
    this._restaurantID = restaurant;
  }

  set informacion(Map informacion){
    this._informacion = informacion;
  }


  imprimir(){
    print(" _categoryID = $categoryID");
    print(" _restaurantID = $_restaurantID");
    print(" _informacion name = ${_informacion["name"]}");
    print(" _informacion logo = ${_informacion["logo"]}");
    print(" _informacion description = ${_informacion["description"]}");
  }

}

class Comentario{
  String _nameComplete;
  String _comentary;
  String _datepublic;

  Comentario(String name, String comentari, String date){
    nameComplete = name;
    comentary = comentari;
    datepublic = date;
  }

  String get nameComplete => this._nameComplete;
  String get comentary => this._comentary;
  String get datepublic => this._datepublic;

  set nameComplete(String dato){
    this._nameComplete=dato;
  }
  set comentary(String dato){
    this._comentary=dato;
  }
  set datepublic(String dato){
    this._datepublic=dato;
  }
}