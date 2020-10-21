import 'package:flutter/material.dart';
import 'package:guimyapp/src/Widgets/TargetIntercambio.dart';
class RegaloBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 60.0,bottom: 50.0),
      color: Colors.grey[300],
      height: double.infinity,
      // child: _CerrarSesion(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            Row( 
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20.0,),
                Image(image: AssetImage("lib/src/Sources/iconsCoins/guimiCoin.png"),width: 50.0,),
                SizedBox(width: 10.0,),
                Text("0",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 35.0),)
              ],
            ),
            SizedBox(height: 20.0,),
            Column(
              children: [
                Wrap(alignment: WrapAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TargetIntercambio(precio: "45" ,  icon: "15descuento",promo: "15% descuento"  ,comprar: (){print("hola");},regalar: (){},),
                    TargetIntercambio(precio: "25" ,  icon: "bebida",promo: "1 bebida gratis"     ,comprar: (){},regalar: (){},),
                    TargetIntercambio(precio:  "50",  icon: "postre",promo: "1 postre gratis"     ,comprar: (){},regalar: (){},),
                    TargetIntercambio(precio: "150",icon: "bebidaAlcoholica",promo: "1 bebida alcoholica" ,comprar: (){},regalar: (){},),
                    TargetIntercambio(precio: "40",icon: "Envio",promo: "1 envio gratis"                 ,comprar: (){},regalar: (){},),
                    TargetIntercambio(precio: "100",icon: "25Descuento",promo: "25% descuento"            ,comprar: (){},regalar: (){},),
                    
                  ],
                ),
                // SizedBox(height: 30.0,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     TargetIntercambio(precio: "150",icon: "bebidaAlcoholica",promo: "1 bebida alcoholica" ,comprar: (){},regalar: (){},),
                //     TargetIntercambio(precio: "40",icon: "Envio",promo: "1 envio gratis"                 ,comprar: (){},regalar: (){},),
                //     TargetIntercambio(precio: "100",icon: "25Descuento",promo: "25% descuento"            ,comprar: (){},regalar: (){},),
                //   ],
                // )
              ],
            ),
            Divider(),
            SizedBox(height: 30.0,),
          ],
        ),
      ),

    );
  }
}