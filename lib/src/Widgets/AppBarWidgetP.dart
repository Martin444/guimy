import 'package:flutter/material.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:provider/provider.dart';

class AppBarWidgetP extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 80.0,
      width: size.width,
      //decoration: BoxDecoration(
      //  color: Colors.blue,
      //  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight:Radius.circular(20.0) )
      //),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight:Radius.circular(20.0)) ,
        ),
        margin: EdgeInsets.only(left: 0.0,right: 0.0, top: 0.0,bottom: 5.0),
        elevation: 5.0,
        child: Container(
          width: size.width,
          height: 80.0,
          //color: Colors.red,
          child: Container(
            decoration: BoxDecoration(
              //color: Colors.orange,
              gradient: LinearGradient(
                colors: [Colors.white,Colors.grey[300]],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight:Radius.circular(20.0)) 
            ) ,
            child: _contenidoAppBar(context),
            //color: Colors.blue,
          ),
        )
      ),
    );
  }

  Widget _contenidoAppBar(BuildContext context){
    //final img = (NetworkImage("https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png") == null)?AssetImage("lib/src/Sources/IconsBar/Pasteles.png",):NetworkImage("https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png");
    ModelProvider prov = Provider.of<ModelProvider>(context);
    final tamIconAvatar = 25.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      child: InkWell(
        onTap: (){
            Provider.of<ModelProvider>(context,listen: false).indexPage=8;
          },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ########################

            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.transparent,
              //backgroundColor: Colors.black,
              backgroundImage: (prov.userAvatar != "cargando..")?NetworkImage(prov.userAvatar):AssetImage("lib/src/Sources/loadingimage/jar-loading.gif"),
              //backgroundColor: Colors.blue,
            ),

            //Image.network("https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX24476126.jpg"),


            // ########################

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Hola"),
                    Text("${prov.userName}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
            ),

            // ########################

             Container(
               height: 45,
               width: 45,
               child: InkWell(
                 onTap: (){
                   Provider.of<ModelProvider>(context,listen: false).indexPage=5;
                 },
                 child: Card(
                   shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)) ,
                    ),
                    margin: EdgeInsets.only(left: .0,right: 5.0, top: 0.0,bottom: 5.0),
                   elevation: 5.0,
                   child: CircleAvatar(
                    radius: tamIconAvatar,
                    backgroundImage: AssetImage("lib/src/Sources/IconsBar/AvatarRegalo.png"),
                    backgroundColor: Colors.transparent,
                    //backgroundColor: Colors.blue,
            ),
                 ),
               ),
             ),

            // #########################
            SizedBox(width: 5.0,),
             Container(
               height: 45,
               width: 45,
               child: InkWell(
                 onTap: (){
                   Provider.of<ModelProvider>(context,listen: false).indexPage=6;
                 },
                 child: Card(
                   shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)) ,
                    ),
                    margin: EdgeInsets.only(left: 0.0,right: 5.0, top: 0.0,bottom: 5.0),
                   elevation: 5.0,
                   child: CircleAvatar(
                    radius: tamIconAvatar,
                    backgroundImage: AssetImage("lib/src/Sources/IconsBar/AvatarTicket.png"),
                    backgroundColor: Colors.transparent,
                    //backgroundColor: Colors.blue,
            ),
                 ),
               ),
             ),

            // #########################
            SizedBox(width: 5.0,),
             Container(
               height: 45,
               width: 40,
               child: InkWell(
                 onTap: (){
                   Provider.of<ModelProvider>(context,listen: false).indexPage=7;
                 },
                 child: Card(

                   shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)) ,
                    ),
                    margin: EdgeInsets.only(left: 0.0,right: 0.0, top: 0.0,bottom: 4.0),
                   elevation: 5.0,
                   child: CircleAvatar(
                    radius: tamIconAvatar,

                    backgroundImage: AssetImage("lib/src/Sources/IconsBar/AvatarCampana.png",),
                    backgroundColor: Colors.transparent,
            ),
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }
}