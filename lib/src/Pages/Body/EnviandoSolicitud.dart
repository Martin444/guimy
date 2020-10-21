import 'package:flutter/material.dart';
class EnviandoSolicitud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.orange,
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  strokeWidth: 5.0,
                  backgroundColor: Colors.grey.withOpacity(0.2), 
                  // value: 0.9,
                ),
                height: 200.0,
                width: 200.0,
              ),
          SizedBox(height: 20.0,),
          Text("Estamos enviando tu solicitud",style: TextStyle(fontWeight: FontWeight.bold),),
          Text("Despues de enviar la solicitud deberas pagar el costo de reserva del restaurante",textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}