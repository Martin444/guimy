import 'package:flutter/material.dart';
import 'package:guimyapp/src/GraphQL/GraphQl.dart';
import 'package:guimyapp/src/Provider/ClassReserva.dart';
import 'package:guimyapp/src/Provider/ClassRestaurant.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
GraphQLClass graphQl = new GraphQLClass();
class ConfirmarReserva extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ClassReserva reserva = Provider.of<ClassReserva>(context);
    ClassRestaurant rest = Provider.of<ClassRestaurant>(context);
    ModelProvider prov = Provider.of<ModelProvider>(context);
    final size = MediaQuery.of(context).size;
    final _styleTitle = TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20.0);
    final _styleSubTitle = TextStyle(color: Colors.grey[400],fontWeight: FontWeight.bold,fontSize: 18.0);
    return Container(
      // color: Colors.orange,
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 100.0,),
          Container(child: Text("Tu pedido",style: _styleTitle,),width: double.infinity,),
          Row(
            children: <Widget>[
              Expanded(child: Text("Mesa para ${reserva.reservamaxPersons} personas",style: _styleSubTitle,overflow: TextOverflow.ellipsis,)),
              Text("15 PEN", style: TextStyle(color: Colors.red,fontSize: 17.0, fontWeight: FontWeight.bold),)
            ],
          ),
          Divider(),
          Container(child: Text("Fecha y hora",style: _styleTitle,),width: double.infinity,),
          Row(
            children: <Widget>[
              Expanded(child: Text("${reserva.reservadate?.substring(0,10)}",style: _styleSubTitle,overflow: TextOverflow.ellipsis,)),
              Text("${reserva.reservadate?.substring(11,16)}",style: _styleSubTitle)
            ],
          ),
          Divider(),
          Container(child: Text("Lugar",style: _styleTitle,),width: double.infinity,),
          Column(
            children: <Widget>[
              Container(child: Text("${rest.resName}",style: _styleSubTitle),width: double.infinity,)
            ],
          ),
          Divider(),
          Container(child: Text("Metodo de pago",style: _styleTitle,),width: double.infinity,),
          Divider(),
          GestureDetector(
            onTap: () async{
            Toast.show("Gracias por su reserva", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
              
 
              await graphQl.insertarReserva(
                reserva.userID, 
                reserva.reservafirstName, 
                reserva.reservalastName, 
                reserva.reservanumeroIdentidad, 
                reserva.reservamaxPersons, 
                reserva.reservadate, 
                reserva.reservamessage, 
                reserva.restaurantID
                );

                reserva.userID = "";
                reserva.reservafirstName = "";
                reserva.reservalastName = "";
                reserva.reservanumeroIdentidad = "";
                reserva.reservamaxPersons = 0;
                reserva.reservadate = "                       ";
                reserva.reservamessage = "";
                reserva.restaurantID = "";
                prov.indexPageRestaurant = 0;

                prov.indexPage = 14;
                Future.delayed(Duration(seconds: 7),(){
                  prov.indexPage = 11;
                });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(50.0),

              ),
              padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
              child: Text("Confirmar Reserva",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
            ),
          ),GestureDetector(
            onTap: () {
              

                reserva.userID = "";
                reserva.reservafirstName = "";
                reserva.reservalastName = "";
                reserva.reservanumeroIdentidad = "";
                reserva.reservamaxPersons = 0;
                reserva.reservadate = "                      ";
                reserva.reservamessage = "";
                reserva.restaurantID = "";
                prov.indexPageRestaurant = 0;
                prov.indexPage = 11;
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(50.0),

              ),
              padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
              child: Text("Cancelar",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
            ),
          ),

          SizedBox(height: 100.0,),
        ],
      ),
    );
  }
}