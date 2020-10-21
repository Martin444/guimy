import 'package:flutter/material.dart';

import 'PerfilBody.dart';

class RankUserBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 70.0,bottom: 40.0),
      color: Colors.grey[300],
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 20.0,),
            RankUser(tamImg: 100.0,),
            Divider(),
            MisCanjes(),
            Divider(),
            Container(height: 100.0,)
          ],
        ),
      ),
    );
  }
}

class MisCanjes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text("Mis Canjes",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0,color: Colors.grey[700]),),
        Container(
          color: Colors.red,
          width: size.width,
          height: 130.0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
                Container(color: Colors.blue, width: 50.0, height: 50.0, margin: EdgeInsets.all(10.0),), 
              ],
            )
          ),
        ),
      ],
    );
  }
}