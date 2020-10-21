import 'package:flutter/material.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:guimyapp/src/root/root.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';  
class PerfilBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60.0,bottom: 50.0),
      color: Colors.grey[300],
      height: double.infinity,
      // child: _CerrarSesion(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            _PerfilSuperior(),
            Divider(),
            InformacionUsuarioWidget(),
            Divider(),
            RankUser()
          ],
        ),
      ),

    );
  }
}

class RankUser extends StatelessWidget {

  final double tamImg;

  RankUser({this.tamImg = 150.0});

  @override
  Widget build(BuildContext context) {
    ModelProvider provider = Provider.of<ModelProvider>(context);
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        provider.indexPage = 9;
      },
      child: Container(
        margin: EdgeInsets.only(bottom: (tamImg==150)?20.0:0.0),
        child: Column(
          children: [
            Image(
              height: 150.0,
              image: AssetImage("lib/src/Sources/Rangos/RangoGuimista.png")
            ),
            Text("Guimista",style: TextStyle(fontSize: 25.0, color: Colors.deepOrange, fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Container(
                  width: size.width /2-15,
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      _TextoRankBeneficio(size: size, texto: "1 envio gratis a la semana por dos semanas",),
                      _TextoRankBeneficio(size: size, texto: "35 Guimy coins por invitar algun amigo",),
                    ],
                  ),
                ),
                Container(
                  width: size.width /2-15,
                  child: Column(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      _TextoRankBeneficio(size: size, texto: "Regalo especial Guimy",),
                      _TextoRankBeneficio(size: size, texto: "50 Guimy coins",),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _TextoRankBeneficio extends StatelessWidget {

  final String texto;
  const _TextoRankBeneficio({
    @required this.size, 
    @required this.texto,
  }) ;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check,color: Colors.grey[850],),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          // color: Colors.red,
          width: size.width /2-40,
          child: Text("$texto",overflow: TextOverflow.clip,style: TextStyle(color: Colors.grey[850], fontSize: 10.0 ),)
        )
      ],
    );
  }
}

class InformacionUsuarioWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ModelProvider prov = Provider.of<ModelProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          ListTile(
            title: Text("Correo electronico"),
            subtitle: Text(prov.userEmail),
          ),
          ListTile(
            title: Text("Contraseña"),
            subtitle: Text(prov.userPassword),
          ),
          ListTile(
            title: Text("Celular"),
            subtitle: Text("${prov.extencionPhone} ${prov.userPhone}"),
          ),
          _CerrarSesion()
        ],
      ),
    );
  }
}
class _PerfilSuperior extends StatefulWidget {
  @override
  __PerfilSuperiorState createState() => __PerfilSuperiorState();
}

class __PerfilSuperiorState extends State<_PerfilSuperior> {
  Color _color = Color.fromRGBO(254,173,76, 1.0);

  @override
  Widget build(BuildContext context) {
    ModelProvider prov = Provider.of<ModelProvider>(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 65.0,
                    backgroundImage: (prov.userAvatar != "cargando..")?NetworkImage(prov.userAvatar):AssetImage("lib/src/Sources/loadingimage/jar-loading.gif"),
                    // child: Icon(Icons.plus_one),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(prov.userName, style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w500,color: Colors.grey[850]),),
                        Icon(Icons.person_pin_circle,color: _color,)
                      ],
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 0.0,
                right: 20.0,
                child: InkWell(
                  onTap: () {
                    prov.indexPage =10;
                  },
                  child: Row(
                    children: [
                      Icon(Icons.question_answer,color: _color,),
                      Text("Reportar",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400,color: _color),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}





// ##########################################

class _CerrarSesion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: ()async{
        Toast.show("Cerrando Sesion", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        ModelProvider _currentUser = Provider.of<ModelProvider>(context, listen: false);
        String verif = await _currentUser.signOut();
        //Provider.of<ModelProvider>(context,listen: false).signOut();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // ignore: await_only_futures
        await prefs.setString("idUser","no-data-token");
        if(verif == "success"){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OurRoot()), (route) => false);
        }
      },
      child: Container(
        width: 200.0,
        height: 50.0,
        margin: EdgeInsets.only(bottom: 20.0,top: 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromRGBO(254,173,76, 1.0),
          borderRadius: BorderRadius.circular(50.0)
        ),
        child: Text("Cerrar sesion",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      )
      ),
    );
  }
}