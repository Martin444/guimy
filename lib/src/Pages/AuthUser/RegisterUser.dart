import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:guimyapp/src/Widgets/BackGroundWidget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
// import 'package:shared_preferences/shared_preferences.dart';



File _image;
File _imageUrl;
bool _addPhoto = false;

 
class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  TextEditingController _fullNameController   = TextEditingController();
  TextEditingController _emailController      = TextEditingController();
  TextEditingController _passController       = TextEditingController();
  String                _countryController    = "PERU";
  String                _extencion    = "+51";
  // String                _avatar    = "";
  TextEditingController _phoneNumber          = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         body: Stack(
           children:[
             
              _createBackground(context),
              _centerPart(context),
           ] 
         ),
      ),
    );

  }

  Widget _createBackground(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackGroundWidget(size),
        Container(
          //color: Colors.blue,
          // height: 200.0,
          margin: EdgeInsets.only(top: 30),
          width: double.infinity,
          child: Hero(
            tag: "keyLogo",
            child: Container(
              height: 60,
              child: SvgPicture.asset("lib/src/Sources/Logos/LogoGuimySVG.svg", height: 40, color: Colors.white,),
            ),
          )
          //Hero(tag: "keyLogo",child: Image.asset("lib/src/Sources/Logos/LogoGuimy.png"))
        ),

      ],
    );

  }

  Widget _centerPart(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
          
               SizedBox(height: 115.0,),
            Container(
              width: size.width * 0.8,
              //height: size.height * 0.6,
              //color: Colors.blue,
              child: Column(
                children: [
                  _inputImage(),
                  _inputNombre(),
                  _inputEmail(),
                  _inputPass(),
                  _inputPais(),
                  _inputPhone(),
                  //SizedBox(height: 5.0,),
                  _botonSingUp(context),
                  //Text("¿Olvidaste tu contraseña? ")
                  _textoYaTienesCuenta(context),
                  //_textoRegistrate(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputImage(){
    return Container(
      width: double.infinity,
      
      child: Column(
        children: <Widget>[
          _mostrarFoto(),
          SizedBox(height: 20,),
          if(_addPhoto)Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  _seleccionarFoto();
                },
                child: Icon(Icons.photo_size_select_large,size: 40.0, color: Colors.white,),
              ),
              GestureDetector(
                onTap: () {
                  _tomarFoto();
                },
                child: Icon(Icons.camera_enhance,size: 40.0, color: Colors.white,),
              )
            ],
          )
        ],
      ),
    );
  }

  _mostrarFoto(){
    // imageCache.clear();
    if(_imageUrl != null){
      print("##### IMAGE URL ${_imageUrl.path}");
      return CircularProgressIndicator();
    }else{
      
      print("##### IMAGE  ${_image?.path}");
      return ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        
        child: (_image == null)?
          GestureDetector(
            onTap: () {
              if(_addPhoto) { _addPhoto = false;}
              else{_addPhoto = true;}
              print(_addPhoto);
              setState(() {
                
              });
            },
            child: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              child: Icon(Icons.add,size: 50.0,color: Colors.grey,),
            ),
          )
          : 
          Image(
            image: 
            FileImage(_image),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
      );
    }
  }

//   Future<void> retrieveLostData() async {
//   final LostData response =
//       await picker.getLostData();
//   if (response == null) {
//     return;
//   }
//   if (response.file != null) {
//     setState(() {
//       if (response.type == RetrieveType.video) {
//         _handleVideo(response.file);
//       } else {
//         _handleImage(response.file);
//       }
//     });
//   } else {
//     _handleError(response.exception);
//   }
// }

  _seleccionarFoto()async{
    final _picker = ImagePicker();
    final PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
    
   
    
    if(_image != null){
      //limpiez 
    }

    setState(() {
       _image = File(pickedFile.path);
    });
  }

  _tomarFoto()async{
    final _picker = ImagePicker();
    final PickedFile pickedFile = await _picker.getImage(source: ImageSource.camera);
    
    _image = File(pickedFile.path);
    
    if(_image != null){
      //limpiez 
    }

    setState(() {
      
    });
  }

  Widget _inputNombre(){
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(8.0),
      child: TextField(
        controller: _fullNameController,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: "Nombre",
          hintStyle: TextStyle(
            color: Colors.white
          ),
          alignLabelWithHint: true,
          filled: true
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _inputEmail(){
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(8.0),
      child: TextField(
        controller: _emailController,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: "E-mail",
          hintStyle: TextStyle(
            color: Colors.white
          ),
          alignLabelWithHint: true,
          filled: true
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      ),
    );
  }
  bool _showPassword = false;
  Widget _inputPass(){
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(8.0),
      child: TextField(
        controller: _passController,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.white
          ),
          alignLabelWithHint: true,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye,color: this._showPassword? Colors.blue:Colors.white,),
             
            onPressed: () {
              setState(() {
                this._showPassword = !this._showPassword;
              });
            },
          )
        ),
        //keyboardType: TextInputType.visiblePassword,
        obscureText: !this._showPassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }
  Widget _inputPhone(){
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(8.0),
      child: TextField(
        controller: _phoneNumber,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20.0)
          ),
          hintText: "Numero de celular",
          hintStyle: TextStyle(
            color: Colors.white
          ),
          alignLabelWithHint: true,
          filled: true
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  
  Widget _inputPais(){
    // falta controller
    return Container(
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        border: null,
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        
      ),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      alignment: Alignment.center,
      child: CountryCodePicker(
        textStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 25.0,color: Colors.grey[600]),
        onChanged: (x){
          _countryController = x.name;
          _extencion = x.dialCode;
          //print("#############${x.name}");
          return print(x);
        },
           // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
           initialSelection: 'PE',
           favorite: ['+51','PE','+52','MX','+591','BO',],
           // optional. Shows only country name and flag
           showCountryOnly: true,
           // optional. Shows only country name and flag when popup is closed.
           showOnlyCountryWhenClosed: true,
           // optional. aligns the flag and the Text left
           alignLeft: false,
         ),
    );

    
  }

  Widget _botonSingUp(BuildContext context){
    ModelProvider _currentUser = Provider.of<ModelProvider>(context, listen: false);
    return InkWell(
      onTap: () async {
        Toast.show("Registrando datos espere por favor..", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
        _currentUser.userName = _fullNameController.text;
        _currentUser.userEmail = _emailController.text;
        _currentUser.userPassword = _passController.text;
        _currentUser.userCountry = _countryController.toString();
        _currentUser.userPhone = _phoneNumber.text;
        _currentUser.extencionPhone = _extencion;

        final dato = await _funcionCargarDatos(_currentUser);
        _currentUser.userAvatar = dato;
        
         _signUpUser(_emailController.text, _passController.text, context);

      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFFFCB242),
          
        ),
        child: Text("Registrarme",style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,

              ),),
        margin: EdgeInsets.all(8.0),
        // padding: EdgeInsets.symmetric(hori]zontal: 20.0,vertical: 20.0),
        alignment: Alignment.center,
      ),
    );
  }

  // Widget _botonSingUp(BuildContext context){
  //   ModelProvider _currentUser = Provider.of<ModelProvider>(context, listen: false); 

  //   //#######################
  //   return Mutation(
  //       options: MutationOptions(
  //         documentNode: gql(_insertUser), 
  //         onCompleted: (dynamic resultData) async {
  //           print(" ##**## $resultData");
  //           Map resultado = resultData;
  //           SharedPreferences prefs = await SharedPreferences.getInstance();
  //           await prefs.setString('idUser', resultado["insert_users_one"]["id"]);
  //           print(" ##___## enviando dato a prefs ${resultado["insert_users_one"]["id"]}");

  //         },
  //       ),
  //       builder: (
  //         RunMutation runMutation,
  //         QueryResult result,
  //       ) {
          
  //         return InkWell(
            // onTap: ()async{

            //   _currentUser.userName = _fullNameController.text;
            //   _currentUser.userEmail = _emailController.text;
            //   _currentUser.userPassword = _passController.text;
            //   _currentUser.userCountry = _countryController.toString();
            //   _currentUser.userPhone = _phoneNumber.text;
            //   _currentUser.extencionPhone = _extencion;
              
            //   final dato = await _funcionCargarDatos(_currentUser);
            //   _currentUser.userAvatar = dato;
              // runMutation({
              //     "country": _currentUser.userCountry,
              //     "email": _currentUser.userEmail,
              //     "name": _currentUser.userName,
              //     "pass": _currentUser.userPassword,
              //     "phone": _currentUser.userPhone,
              //     "extendphone": _currentUser.extencionPhone,
              //     "avatar": _currentUser.userAvatar
              //   });
              
            //   _signUpUser(_emailController.text, _passController.text, context);
            // },
  //           child: Container(
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(50.0),
  //               color: Color.fromRGBO(235,122,39, 1.0),
                
  //             ),
  //             child: Text("Register",style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 20.0,
  //                     fontWeight: FontWeight.bold,

  //                   ),),
  //             margin: EdgeInsets.all(8.0),
  //             padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
  //             alignment: Alignment.center,
  //           ),
  //         );
  //       },
  //     );
  //   //#######################
    
  // }

  Future<String> _funcionCargarDatos(ModelProvider currentUser)async{

    String valor;

    if(_image!= null){
      valor = await currentUser.subirImagen(_image);
    }else{
      print("####### _image es null");
      valor = "https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png";
    }    
    return valor;
  }

  Widget _textoYaTienesCuenta(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()=>Navigator.pushNamed(context, "/Login"),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.orange[800]),
            children: [
              TextSpan(text: '¿Ya tienes una cuenta? '),
              TextSpan(text: 'Iniciar Sesion',style: TextStyle(fontWeight: FontWeight.bold)),
            ]
          )
        ),
      ),
    );
  }
}

void _signUpUser(String email, String pass, BuildContext context) async {
  ModelProvider _currentUser = Provider.of<ModelProvider>(context, listen: false);
  try {
    if(await _currentUser.signUpUser(email, pass,context)){
      Toast.show("Registro Exitoso, Bienvenido", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
      Navigator.pushReplacementNamed(context, "/homePage"); 
    }
  } catch (e) {
    Toast.show("Error de datos: $e..", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
    print(e);
  }
}