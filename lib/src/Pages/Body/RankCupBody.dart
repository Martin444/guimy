// RankCupBody
import 'package:flutter/material.dart';
import 'package:guimyapp/src/Provider/ClassMisions.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:guimyapp/src/Widgets/retosProgress.dart';
import 'package:provider/provider.dart';
// import 'package:guimyapp/src/BaseDeDatos/GraphQl.dart';
// import 'package:guimyapp/src/Provider/ClassMisions.dart';
// import 'package:guimyapp/src/Widgets/retosProgress.dart';
// import 'package:provider/provider.dart';
// GraphQLClass graphQl = new GraphQLClass();
class RankCupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClassMisions mision = Provider.of<ClassMisions>(context);

    final listaMisiones = mision.listaMisiones;

    List<Widget> listaMisionesWidget = (listaMisiones != null )? listaMisiones.map((OneMision mision) {
      return RetosProgress(progress: "0/${mision.misionNeedsTotal}",title: mision.misionNeedsAction,porcentageProg: 0,puntos: mision.misionGivePoints,);
    }).toList():[Container()];
    return Container(
      padding: EdgeInsets.only(top: 60.0,bottom: 50.0),
      color: Colors.pink[50],
      height: double.infinity,
      // child: _CerrarSesion(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            _TopRango(),
            ...listaMisionesWidget,
            SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }

  
}

class _TopRango extends StatefulWidget {
  @override
  __TopRangoState createState() => __TopRangoState();
}

class __TopRangoState extends State<_TopRango> {

  @override
  Widget build(BuildContext context) {
    ModelProvider prov = Provider.of<ModelProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.red,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 65.0,
                    // child: Icon(Icons.plus_one),
                    backgroundImage: NetworkImage(prov.userAvatar),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sin Rango", style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.w500,color: Colors.orange),),
                        Text("0 pts", style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w500,color: Colors.orange),),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 30.0,
                    // color: Colors.green,
                  )
                ],
              ),

              Positioned(
                top: 5.0,
                left: 20.0,
                child: Column(
                  children: [
                    Icon(Icons.timer,size: 50.0,color: Colors.orange,),
                    Text("24:00:00",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.orange),)
                  ],
                ),
              ),

              Positioned(
                top: 5.0,
                right: 20.0,
                child: Image.asset("lib/src/Sources/IconsBar/sports-and-competition.png",fit: BoxFit.cover,width: 50.0,color: Colors.orange,)
              )
              
            ],
          ),
        ],
      ),
    );
  }
}
