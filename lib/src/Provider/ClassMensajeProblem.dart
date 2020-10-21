import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:guimyapp/src/Pages/Body/ConsultasMensajerias/ItemMensajeria.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
// import 'package:mime_type/mime_type.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

class ClassMensajeProblem with ChangeNotifier{
  String _tag;
  String _msg;
  String _urlImagen;

  String get tag => this._tag;
  String get msg => this._msg;
  String get urlImagen => this._urlImagen;

  set tag(String tag){this._tag = tag;}
  set msg(String msg){this._msg = msg;}
  set urlImagen(String urlImagen){this._urlImagen = urlImagen;}


  Future<String> subirImagen(File imagen)async{
    final url = Uri.parse("https://api.cloudinary.com/v1_1/guimyapp/image/upload?upload_preset=ezacjkrt");
    final mineType = mime(imagen.path).split("/"); // image/jpg
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      "file", 
      imagen.path,
      contentType: MediaType(mineType[0],mineType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if(resp.statusCode != 200 && resp.statusCode != 201){
      print("Algo salio mal");
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }



  ////////////////////////////////////
  ///
  List _listaMsj;
  List _listaMsjWidget;

  set listaMsj(List msg){
    
    this._listaMsj = msg;
    listaMsjWidget = this._listaMsj;
    notifyListeners();
  }
  List get listaMsjWidget =>this._listaMsjWidget;
  set listaMsjWidget(List msg){
    this._listaMsjWidget = this._listaMsj?.map((mensaje) {
      return ItemMensajeria(
        tag     : mensaje["category"],
        mesage  : mensaje["message"],
        state   : mensaje["state"],
        date    : mensaje["created_at"].toString().substring(0,10)
      );
    })?.toList();
    notifyListeners();
  }
  agregarUnMensajeMAP( item){
    // print("---------------------------------------------");
    // print(item);
    // print("---------------------------------------------");
    this._listaMsj.add(
      item
    );
    // print("---------------------------------------------");
    // print(this._listaMsj);
    // print("---------------------------------------------");

    notifyListeners();
  }

  agregarUnMensaje( item){
    // print("---------------------------------------------");
    // print(item);
    // print("---------------------------------------------");
    this._listaMsjWidget.add(
      ItemMensajeria(
        tag     : item["tag"],
        mesage  : item["message"],
        state   : item["state"],
        date    : item["created_at"].toString().substring(0,10)
      )
    );
    // print("---------------------------------------------");
    // print(this._listaMsjWidget);
    // print("---------------------------------------------");

    notifyListeners();
  }
  
  
  //  cargarmensajes(){
  //   //  print("%%%%%%^^^^^^^^%%%%%%%%%%%%");
  //   //   print(this._listaMsj); 
  //     this._listaMsjWidget = this._listaMsj?.map((mensaje) {
  //     return ItemMensajeria(
  //       tag     : mensaje["tag"],
  //       mesage  : mensaje["message"],
  //       state   : mensaje["state"],
  //       date    : mensaje["created_at"].toString().substring(0,10)
  //     );
  //   })?.toList();
  //   // notifyListeners();
  //  }



}