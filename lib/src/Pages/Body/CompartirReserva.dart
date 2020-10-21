import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';

class CompartirReserva extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0,),
              Stack(
                children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                      strokeWidth: 5.0,
                      // backgroundColor: Colors.grey.withOpacity(0.2), 
                      value: 1.0,

                      // value: 0.9,
                    ),
                    height: 200.0,
                    width: 200.0,
                  ),
                  SizedBox(
                    child: Icon(Icons.check,size: 150.0,color: Colors.orange,),
                    height: 200.0,
                    width: 200.0,
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              Text("Hemos confirmado tu reserva con exito",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.grey[800]),textAlign: TextAlign.center,),
              SizedBox(height: 30.0,),
              Text("Comparte con tus amigos",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.0,color: Colors.grey[700]),textAlign: TextAlign.center,),
              SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      // Clipboard.setData(ClipboardData(text: frase));
                      Share.share('flutter is Cool');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.black38,
                            blurRadius: 2.0
                          )
                        ]
                      ),
                      child: Icon(Icons.share,size: 30.0,color: Colors.white,)
                    )
                  ),
                  GestureDetector(
                    onTap: (){
                      Toast.show("Codigo copiado", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                      // print("####### COPIADO");
                      Clipboard.setData(ClipboardData(text: "texto copiado"));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            color: Colors.black38,
                            blurRadius: 2.0
                          )
                        ]
                      ),
                      child: Icon(Icons.content_copy,size: 30.0,color: Colors.white,)
                    )
                  ),

                ],
              ),
              SizedBox(height: 100.0,),
            ],
          ),
        ),
      ),
    );
  }
}