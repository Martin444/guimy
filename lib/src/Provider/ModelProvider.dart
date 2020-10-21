import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guimyapp/src/GraphQL/GraphQl.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


GraphQLClass bdGraphQl = new GraphQLClass();

class ModelProvider extends ChangeNotifier{
  
  int _indexPage = 0;
  int get indexPage => this._indexPage;
  set indexPage(int index){
    this._indexPage=index;
    notifyListeners();
  }
  int _indexPageRestaurant = 0;
  int get indexPageRestaurant => this._indexPageRestaurant;
  set indexPageRestaurant(int index){
    this._indexPageRestaurant=index;
    notifyListeners();
  }

  //##################### auth ########################33
  // Current State User
  String _uid;
  String _email;

  String get uid => this._uid;
  String get email => this._email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp()async{
    String retVal = "error";
    try {
      User _firebaseUser =  _auth.currentUser;
      _uid = _firebaseUser.uid;
      _email = _firebaseUser.email;
      
      retVal = "success";
    } catch (e) {
      print("nuevo error encontrado en $e");
    }
    return retVal;
  }

  Future<String> signOut()async{
    String retVal = "error";
    try {
      await _auth.signOut();
      _uid = null;
      _email = null;
      retVal = "success";
    } catch (e) {
      print("nuevo error encontrado en $e");
    }
    return retVal;
  }

  //#############################################33

  Future<bool> signUpUser (String email, String password, BuildContext context) async {
    bool retVal = false;
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _userId = _authResult.user.uid;
      print("%%%%%%%%%%%%%%%%%%%%% ${_authResult.user.uid}");
      if(_authResult.user != null){
        retVal = true;
        _userId = _authResult.user.uid;
      }
    } catch (e) {
    Toast.show("Error de Registro : $e..", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
      print("Error de Registro $e");
    }
    print("###############################3");
    // onStartUp();
    // print(this._authResult.user.uid);
    
  if (retVal){
    bdGraphQl.insertarUsuario(
      this.userId,
      this.userAvatar,
      this.userName,
      this.userPassword,
      this.extencionPhone,
      this.userPhone,
      this.userCountry,
      this.userEmail
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    await prefs.setString("idUser",this.userId);
    print("###############################3");
  }

    // 10bf922f-a4fb-4b75-873f-f87252e1f63a
    return retVal;
  }
  
  Future<bool> loginUser (String email, String password, BuildContext context) async{
    bool retVal = false;

    try {
      UserCredential _authResult = 
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(_authResult.user != null){

        _uid = _authResult.user.uid;
        _email = _authResult.user.email;
        Toast.show("Bienvenido $_email", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
        retVal = true;
      }
    } catch (e) {
      Toast.show("Error inesperado #e", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
      print("Error encontrado en $e");
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    await prefs.setString("idUser",this._uid);
    
    return retVal;
  }



  // ################################################################
  // ############     RESERVADO PARA DATOS DE USUARIO   #############
  // ################################################################
  // bool _auxiliarBandera = true;
  String _userName = "cargando.."; 
  String _userEmail = "cargando..";
  String _userPassword ="cargando..";
  String _userCountry = "PERU";
  String _userPhone ="cargando..";

  String _extencionPhone = "+51";
  String _userAvatar ="cargando..";

  String _userId ="cargando.."; // token de firebase
  String _userIdGraphql = "cargando...";

  Future actualizarDato()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    this._userId = await prefs.getString("idUser")??"no data";
    print("##^^## ${this._userId} ");
  }
  //

  String get userId => this._userId; 
  String get userIdGraphql => this._userIdGraphql; 
  String get userAvatar => this._userAvatar;
  String get userPhone => this._userPhone;

  String get userName => this._userName;
  String get userEmail => this._userEmail;
  String get userPassword => this._userPassword;
  String get userCountry => this._userCountry;

  String get extencionPhone => this._extencionPhone;
  set extencionPhone(String number){
    this._extencionPhone = number;
  }

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

  // Future<void> futureAvatar(Map repositories)async{
  //   await Future.delayed(const Duration(milliseconds: 100), (){});
  //   print(repositories["name"]);
  //   this.userAvatar     = repositories["avatar"];
  //   this.userEmail      = repositories["email"];
  //   this.extencionPhone = repositories["extend_phone"];
  //   this.userName       = repositories["name"];//       = repositories["name"];
  //   this.userPassword   = repositories["password"];
  //   this.userPhone      = repositories["phone"];
  //   if(_auxiliarBandera){
  //     // await Future.delayed(const Duration(milliseconds: 300), (){});
  //     notifyListeners();
  //     print("#### ${this.userPhone}");
  //     _auxiliarBandera = false;
  //   } 
  // }

  set userAvatar(String url){
    this._userAvatar = url;
    print(this._userAvatar);
    notifyListeners();
  }

  set userName(String userName){
    this._userName = userName;
    // notifyListeners();
  }
  set userEmail(String userEmail){
    this._userEmail = userEmail;
    //notifyListeners();
  }
  set userPassword(String userPassword){
    this._userPassword = userPassword;
    //notifyListeners();
  }
  set userCountry(String userCountry){
    this._userCountry = userCountry;
    //notifyListeners();
  }

  set userPhone(String phone){
    this._userPhone = phone;
    // notifyListeners();
  }

  set userId(String id){
    this._userId = id;
  }
    
  set userIdGraphql(String id){
    this._userIdGraphql = id;
  }
    
  
}