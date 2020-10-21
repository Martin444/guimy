import 'package:flutter/material.dart';

class ItemMensajeria extends StatelessWidget {
  final String tag;
  final String mesage;
  final String state;
  final String date;

  const ItemMensajeria({@required this.tag, @required this.mesage, @required this.state, @required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 2.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 50.0,
          maxHeight: 70.0
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3.0,
                color: Colors.black12,
                spreadRadius: 1.2
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("$tag"),
              Text("$mesage"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("➤ $state"),
                  Text("$date"),
                ],
              )
            ],
          ),

        ),
      ),
    );
  }
}