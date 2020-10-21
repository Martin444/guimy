import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';

class ItemConsultasFour  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _titleStyle = TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 20.0);
    final _subtitleStyle = TextStyle(color: Colors.black45,fontSize: 18.0);
    final _h1Style = TextStyle(color: Colors.red,fontSize: 30.0,fontWeight: FontWeight.w600);
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(child: Text("¿Comó puedo asociar mi restaurante a Guimy?", style: _titleStyle,textAlign: TextAlign.center,),width: double.infinity,margin: EdgeInsets.only(top: 20.0,bottom: 40.0),),
          Container(child: Text("!Hola!",style: _h1Style,),width: double.infinity,),
          Text("Si deseas ser parte de Guimy, ingresa al siguiente link y empieza una nueva experiencia con tu negocio de comida. Escala alto y destaca entre los demás negocios de comida.",style: _subtitleStyle,),

          _codeShare(),
          _SeccionCopyShare("www.algo.com"),
        ],
      ),
    );
  }


  Widget _codeShare(){
     final TextEditingController controller = TextEditingController(text:"CODE USER");

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
      height: 40.0,
      child: TextField(
        // controller: _email,
        // autofocus: false,
        
        enabled: false,
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.orange[200], fontWeight: FontWeight.bold,),
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintText: "Codigo",
          hintStyle: TextStyle(color: Colors.red[100],),
          alignLabelWithHint: false,
          filled: true
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}


class _SeccionCopyShare extends StatelessWidget {

  final String frase;

  _SeccionCopyShare(this.frase);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: (){
              Toast.show("Codigo copiado", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
              // print("####### COPIADO");
              Clipboard.setData(ClipboardData(text: frase));
            },
            child: Icon(Icons.content_copy,size: 40.0,color: Colors.grey,)
          ),

          GestureDetector(
            onTap: (){
              // Clipboard.setData(ClipboardData(text: frase));
              Share.share('flutter is Cool');
            },
            child: Icon(Icons.share,size: 40.0,color: Colors.grey,)
          )
        ],
      ),
    );
  }
}