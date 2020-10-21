import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guimyapp/src/GraphQL/GraphQl.dart';
import 'package:guimyapp/src/Pages/Body/CompartirReserva.dart';
import 'package:guimyapp/src/Pages/Body/ConfirmarReserva.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:guimyapp/src/Pages/Body/CuponBody.dart';
import 'package:guimyapp/src/Pages/Body/EnviandoSolicitud.dart';
import 'package:guimyapp/src/Pages/Body/HomeBody.dart';
import 'package:guimyapp/src/Pages/Body/LocarionBody.dart';
import 'package:guimyapp/src/Pages/Body/NotificationBody.dart';
import 'package:guimyapp/src/Pages/Body/PerfilBody.dart';
import 'package:guimyapp/src/Pages/Body/RankCupBody.dart';
import 'package:guimyapp/src/Pages/Body/RankUserBody.dart';
import 'package:guimyapp/src/Pages/Body/RegaloBody.dart';
import 'package:guimyapp/src/Pages/Body/ReportarBody.dart';
import 'package:guimyapp/src/Pages/Body/RestaurandBody.dart';
import 'package:guimyapp/src/Pages/Body/StarBody.dart';
import 'package:guimyapp/src/Provider/ClassRespQr.dart';
import 'package:guimyapp/src/Provider/ClassRestaurant.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:guimyapp/src/Widgets/AppBarWidgetP.dart';
import 'package:guimyapp/src/Widgets/BottomBarWidget.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:toast/toast.dart';
// import 'package:shared_preferences/shared_preferences.dart';

GraphQLClass graphQl = new GraphQLClass();
String userId ="--";
// String readRepositories = """
//   query MyQuery (\$idx: uuid!){
//     users_by_pk(id:  \$idx) {
//       id
//       avatar
//       email
//       extend_phone
//       name
//       password
//       phone
//     }
//   }
// """;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    _cargarPreferencias();
    super.initState();
    
  }

  _cargarPreferencias()async{
    await Provider.of<ModelProvider>(context,listen: false).actualizarDato();
    userId =  Provider.of<ModelProvider>(context,listen: false).userId;
    print("## DATO RECUPERADO ## : $userId");
    _cargarDato(userId);
  }
  Future _cargarDato(String userId)async{
    print("########### userId $userId");
    Map mapa = await graphQl.ejecutarConsultaInicio(userId);
    _renovarProvider(mapa);
  }

  _renovarProvider(Map mapa){
    // print("### cargando Provider");
    ModelProvider prov = Provider.of<ModelProvider>(context,listen: false);
    prov.userAvatar = mapa["avatar"];
    prov.userName = mapa["name"];
    prov.userPassword = mapa["password"];
    // print("### user name provider ${prov.userName}");
    prov.userPhone = mapa["phone"];
    prov.extencionPhone = mapa["extend_phone"];
    prov.userEmail = mapa["email"];
    prov.userIdGraphql = mapa["id"];
    // print("### cargando Provider");
  }


  // _cargarProvider(){
      
  //   // return FutureBuilder(
  //   //   future: _cargarDato(),
  //   //   builder: (context, snapshot) {
  //   //     ModelProvider prov  = Provider.of<ModelProvider>(context);
  //   //     return Query(
  //   //       options: QueryOptions(
  //   //         documentNode: gql(readRepositories), // this is the query string you just created
  //   //         variables: {
  //   //           'idx': snapshot.data,
  //   //         },
  //   //       ),
  //   //       builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
          
  //   //         if (result.hasException) {
  //   //             return Text(result.exception.toString());
  //   //         }

  //   //         if (result.loading) {
  //   //           return Text('Loading');
  //   //         }

  //   //           print(" !!!! #### result ${result.data}");
  //   //         Map repositories = result.data["users_by_pk"];
            
  //   //         prov.futureAvatar(repositories);

  //   //         return Container();
  //   //       },
  //   //     );
  //   //   },
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final int index = Provider.of<ModelProvider>(context).indexPage;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              // _cargarProvider(),
              _returnPage(index),
              Positioned(child: AppBarWidgetP(),top: 0.0,left: 0.0,),
              Positioned(child: BottomBarWidget(),bottom: 0.0,left: 0.0,),
              //Text("#######$index"),
            ],
          ),
        ),
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 5.0,
          onPressed: ()=>_readQR(),
          backgroundColor: Colors.white,
          child: FaIcon(FontAwesomeIcons.qrcode,color: Colors.red,),
        ),
        //bottomNavigationBar: BottomBarWidget(),
      ),
    );
  }

  _readQR()async{
    String cameraScanResult = '';  
    try {
      cameraScanResult =await scanner.scan();
    } catch (e) {
      cameraScanResult = e.toString();
    }
    if(cameraScanResult != null){
      // print(" ### $cameraScanResult");
      ModelProvider prov = Provider.of<ModelProvider>(context,listen: false);
      ClassRestaurant rest = Provider.of<ClassRestaurant>(context,listen: false);
      
      //m
      cameraScanResult = cameraScanResult.substring(1,cameraScanResult.length-1);

      try {
        prov.indexPage = 11;
        Map jsonPrueba = json.decode(cameraScanResult);
        // print("##%## prueba Json ${jsonPrueba["restaurant"]}");
        // print("##%## prueba Json ${jsonPrueba["sucursal"]}");

        ClassRespQr resqr = Provider.of<ClassRespQr>(context,listen: false);
        resqr.cargarRespuesta(jsonPrueba);
        // print("##%## prueba Json ${resqr.restaurantID}");

        Map datos = await graphQl.consultarRestaurante(resqr.restaurantID);
        // print("### resultado DATOS: $datos");

        rest.cargarDatos(datos);

        Map comentarios = await graphQl.ejecutarConsultaComentarios(rest.restID);
        print("### resultado DATOS: $comentarios");
        rest.cargarComentarios(comentarios);

      } catch (e) {
        print("##########%%%^^^######### $e");
        prov.indexPage = 0;
        Toast.show("Error al tratar de leer el QR", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

      }
      // print("##%## prueba Json ${resqr.sucursalID}");
    }
    
  }

  Widget _returnPage(int index){
    switch (index) {
      case 0:
        return HomeBody();
        break;
      case 1:
        return StarBody();
        break;
      case 3:
        return LocationBody();
        break;
      case 4:
        return RankCupBody();
        break;
      case 5:
        return RegaloBody();
        break;
      case 6:
        return CuponBody();
        break;
      case 7:
        return NotificationBody();
        break;
      case 8:
        return PerfilBody();
        break;
      case 9:
        return RankUserBody();
        break;
      case 10:
        return ReportarBody();
        break;
      case 11:
        return RestaurantBody();
        break;
      case 12:
        return EnviandoSolicitud();
        break;
      case 13:
        return ConfirmarReserva();
        break;
      case 14:
        return CompartirReserva();
        break;
      default:
        return HomeBody();
    }
  }
}