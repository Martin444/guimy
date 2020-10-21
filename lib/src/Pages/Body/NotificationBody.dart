import 'package:flutter/material.dart';
class NotificationBody extends StatelessWidget {
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
            _NotificationItem(
              fecha: "Lunes 10:50 PM",
              icono: Icons.check,
              title: "Jorge Rodrigues",
              subtitle: "He recibdo su paquete",
            ),
            _NotificationItem(
              fecha: "Lunes 10:50 PM",
              icono: Icons.check,
              title: "Jorge Rodrigues",
              subtitle: "He recibdo su paquete",
            ),
            _NotificationItem(
              fecha: "Lunes 10:50 PM",
              icono: Icons.check,
              title: "Jorge Rodrigues",
              subtitle: "He recibdo su paquete",
            ),
            SizedBox(height: 30.0,),
          ],
        ),
      ),
    );
  }
}


class _NotificationItem extends StatelessWidget {

  final IconData icono;
  final String title;
  final String subtitle;
  final String fecha;

  const _NotificationItem({
    @required this.icono,
    @required this.title,
    @required this.subtitle,
    @required this.fecha}
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
      padding: EdgeInsets.all(5.0),
      width: size.width,
      // height: 250.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey[200]),
        color: Colors.white,
        
      ),
      child: Column(
        children: <Widget>[
          // Container(),
          Row(
            children: <Widget>[
              Icon(icono,color: Colors.orange,),
              Container(
                width: size.width-100,
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(subtitle),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Spacer(),
              Text(fecha,style: TextStyle(color: Colors.grey[600]),),
            ],
          )
        ],
      ),
    );
  }
}