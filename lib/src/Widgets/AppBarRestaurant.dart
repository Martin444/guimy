import 'package:flutter/material.dart';
class AppBodyRestaurant extends StatelessWidget {
  final TextStyle _styleTitle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0);
  final TextStyle _styleSubTitle = TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 14.0);
  
  final String nameRestaurant;
  final String urlLogo;
  AppBodyRestaurant({@required this.nameRestaurant  , @required this.urlLogo});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        width: double.infinity,
        height: 150.0,
        decoration: BoxDecoration(
          // color: Colors.red,
          gradient: LinearGradient(
            colors: [Colors.red,Colors.red[900]],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter
          ),

        ),alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Bienvenid(a)", style: _styleSubTitle,),
                  Text(nameRestaurant, style: _styleTitle, overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50.0,
              backgroundImage: NetworkImage(urlLogo),
            )
          ],
        ),
      );
  }
}