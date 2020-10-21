import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:guimyapp/src/Widgets/BackGroundWidget.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginUser extends StatefulWidget {

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

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
          width: double.infinity,
          child: SlideInUp(
            child: Container(
              margin: EdgeInsets.only(top: 60),
              child: SvgPicture.asset("lib/src/Sources/Logos/LogoGuimySVG.svg", height: 60, color: Colors.white,),
              ),
            ),
          )
          
          
          
        

      ],
    );

  }

  Widget _centerPart(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(child: Container(height: 180.0,),),
          Text("INGRESA",style: TextStyle(
               color: Colors.white,
               fontSize: 25.0,
               fontWeight: FontWeight.bold,

             ),),
             SizedBox(height: 15.0,),
          Container(
            width: size.width * 0.8,
            //height: size.height * 0.6,
            //color: Colors.blue,
            child: Column(
              children: [
                _inputEmail(),
                _inputPass(),
                //SizedBox(height: 5.0,),
                _botonLogin(context),
                //Text("¿Olvidaste tu contraseña? ")
                _textoBajo(),
                _textoRegistrate(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _inputEmail(){
    return Container(
      height: 50.0,
      margin: EdgeInsets.all(8.0),
      child: TextField(
        controller: _email,
        style: TextStyle(
          color: Colors.white
        ),
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
        controller: _password,
        style: TextStyle(
          color: Colors.white
        ),
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
          alignLabelWithHint: false,
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
  
  Widget _botonLogin(BuildContext context){
    return GestureDetector(
      onTap: (){
        _loginUser(_email.text, _password.text, context);
      },
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFFFCB242),
          
        ),
        child: Text("Ingresar",style: TextStyle(
                 color: Colors.white,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,

               ),),
        margin: EdgeInsets.all(8.0),
        // padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
        alignment: Alignment.center,
      ),
    );
  }

  Widget _textoBajo(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.orange[800]),
          children: [
            TextSpan(text: '¿Olvidaste tu contraseña? ',style: TextStyle( color: Colors.white)),
            TextSpan(text: 'Recuperala ahora',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ]
        )
      ),
    );
  }
  Widget _textoRegistrate(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ()=>Navigator.pushNamed(context, "/Register"),
        child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.orange[800]),
            children: [
              TextSpan(text: '¿No tienes una Cuenta? ', style: TextStyle( color: Colors.white)),
              TextSpan(text: 'Registrate',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ]
          )
        ),
      ),
    );
  }
}

void _loginUser(String email, String password, BuildContext context) async{
  ModelProvider _modelProvider = Provider.of<ModelProvider>(context,listen: false);
  Toast.show("Validando Datos", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);

  try {
    if(await _modelProvider.loginUser(email, password, context)){
      Navigator.of(context).pushReplacementNamed("/homePage");
    }else{
      Toast.show("Datos inexistentes", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
      print("############## no puedes iniciar session");
    }
  } catch (e) {
    Toast.show("Error inesperado $e", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
    print("##\$## error: $e");
  }

}