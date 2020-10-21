import 'package:flutter/material.dart';
class TargetIntercambio extends StatelessWidget {
  final String precio;
  final String icon;
  final String promo;
  final Function comprar;
  final Function regalar;
  TargetIntercambio({@required this.icon, this.promo = "Cargando...",@required this.comprar,@required this.regalar, @required this.precio});
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100.0,
      // height: 300.0,
      margin: EdgeInsets.all(10.0),
      // color: Colors.blue,
      child: Column(
        children: [
          Image(image: AssetImage("lib/src/Sources/iconsCoins/$icon.png"),width: 130.0,fit: BoxFit.cover,),
          
          ConstrainedBox(
            // color: Colors.blueAccent,
            // width: 150.0,
            constraints: BoxConstraints(
              maxWidth: 130.0,
              // minWidth: 150.0
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 0.0,
                  child:Icon(Icons.info,color: Colors.orange,size: 15.0,) 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("lib/src/Sources/iconsCoins/guimiCoin.png"),width: 20.0,),
                    Text("$precio",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 25.0),)
                  ],
                ),
              ],
            ),
          ),

          ConstrainedBox(constraints: BoxConstraints(maxWidth: 130.0) ,child: Text("$promo",style: TextStyle(color: Colors.orange[300], fontWeight: FontWeight.bold,fontSize: 13.0, ),overflow: TextOverflow.ellipsis,)),
          _BotonComprar(comprar: comprar,),
          _BotonRegalar(regalar: regalar,),
        ],
      ),
    );
  }
}

class _BotonComprar extends StatelessWidget {

  final Function comprar;

  const _BotonComprar({@required this.comprar}) ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black,
      onTap: comprar,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 130.0
        ),
        child: Container(
          // color: Colors.orange,
          // width: size.width / 3.5,
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
          margin: EdgeInsets.symmetric(vertical: 2.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.orange,
          ),
          child: Text("Comprar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

class _BotonRegalar extends StatelessWidget {
  final Function regalar;

  const _BotonRegalar({@required  this.regalar}) ;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: regalar,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 130.0
        ),
        child: Container(
          // color: Colors.orange,
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
          margin: EdgeInsets.symmetric(vertical: 2.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.transparent,
            border: Border.all(
              color: Colors.orange,width: 2.0
            )
          ),
          child: Text("Regalar", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold,),),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}