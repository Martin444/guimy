import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guimyapp/src/GraphQL/GraphQl.dart';
import 'package:guimyapp/src/Provider/ClassMisions.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:provider/provider.dart';

GraphQLClass graphQl = new GraphQLClass();
class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 60,
      //color: Colors.red,
      decoration: BoxDecoration(
        //color: Colors.orange,
        gradient: LinearGradient(
          
          colors: [
            Color(0xffFC4242),
            Color(0xff800000)
          ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter
        ),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight:Radius.circular(25.0)) 
      ),
      child: _iconos(context),
    );
  }

  Widget _iconos(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // InkWell(onTap: (){print("Hola");},child: Image.asset("lib/src/Sources/IconsBar/Iconhome.png",fit: BoxFit.cover,width: 25.0,)),
        InkWell(onTap: (){Provider.of<ModelProvider>(context,listen: false).indexPage=0;},child: FaIcon(FontAwesomeIcons.home,color: Colors.white,size: 25.0,)),
        InkWell(onTap: (){Provider.of<ModelProvider>(context,listen: false).indexPage=1;},child: Icon(Icons.star,color: Colors.white,size: 35.0,)),
        // InkWell(onTap: (){},child: Image.asset("lib/src/Sources/IconsBar/Tops.png",fit: BoxFit.cover,width: 25.0,)),
        Container(width: 35.0,),
        // Image.asset("lib/src/Sources/IconsBar/Iconhome.png",fit: BoxFit.cover,width: 35.0,),
        InkWell(onTap: (){Provider.of<ModelProvider>(context,listen: false).indexPage=3;},child: Icon(Icons.pin_drop,color: Colors.white,size: 30.0,)),
        InkWell(onTap: ()async{
          Provider.of<ModelProvider>(context,listen: false).indexPage=4;
          ClassMisions mision = Provider.of<ClassMisions>(context,listen: false);
          await _cargarMisiones(mision);
          // mision.listaMisiones = await listaMisiones;
          },child: Image.asset("lib/src/Sources/IconsBar/sports-and-competition.png",fit: BoxFit.cover,width: 23.0,)),
      ],
    );
  }

  _cargarMisiones(ClassMisions mision)async{

    final Map misiones = await graphQl.ejecutarConsultaMisiones();
    // graphQl.ejecutarConsultaMisiones();
    // misiones.listaMisiones = misiones["misions"];

    mision.listaMisiones = misiones["missions"];
    // final List listaMisiones =  mision.cargarMisiones(misiones["misions"]);
    // print("##################################");
    // print(listaMisiones?? "no hay datos ");
    // return listaMisiones;
    // return null;
  }
}