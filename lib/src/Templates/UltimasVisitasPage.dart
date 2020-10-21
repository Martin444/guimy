import 'package:flutter/material.dart';
import 'package:guimyapp/src/Widgets/AppBarWidgetP.dart';

class UltimasVistasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                AppBarWidgetP(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: <Widget>[
                        Text("Ultimas Visitas",style: TextStyle(color: Colors.grey, fontSize: 20.0),),
                        Icon(Icons.keyboard_arrow_down,color: Colors.grey,size: 30.0,)
                      ],
                    ),
                  ),
                ),
                Expanded(child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _ItemRest(),
                      _ItemRest(),
                      _ItemRest(),
                      _ItemRest()
                    ],
                  ),
                ))

                ///////////////
                
                
              ],
            ),
          )
      ),
    );
  }
}

class _ItemRest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent
      ),
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
      child: Stack(
        children: <Widget>[
          
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network("https://www.cursosgastronomia.com.mx/wp-content/uploads/2014/05/caracteristicas-de-restaurante-exitoso.JPG",fit: BoxFit.cover,width: double.infinity,)
          ),
          Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black54
                ),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              
              CircleAvatar(
                radius: 35.0,
                backgroundImage: NetworkImage("https://www.vacunodeelite.es/wp-content/uploads/2015/07/macdonald.jpg"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("El Fundo del Abuelo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),overflow: TextOverflow.ellipsis,),
                  Text("Av. central #15412",style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 10.0),overflow: TextOverflow.ellipsis,),
                ],
              ),
              IconButton(icon: Icon(Icons.remove_red_eye,color: Colors.white,), onPressed: (){})
            ],
          )

        ],
      ),
    );
  }
}