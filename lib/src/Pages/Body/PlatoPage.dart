import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
bool _mostrar = false;
class PlatoPage extends StatefulWidget {
  @override
  _PlatoPageState createState() => _PlatoPageState();
}

class _PlatoPageState extends State<PlatoPage> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
    super.initState();
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle _titleStyle = TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 20.0);
    TextStyle _subtitleStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.normal,);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.height,
              color: Colors.green,
              child: Image.network("https://www.ketotrace.com/wp-content/uploads/2018/07/costillas-1300x867.jpeg",fit: BoxFit.cover,),
            ),
            Positioned(
              left: (_mostrar)?-260.0:0.0,
              child: Container(
                width: 300.0,
                height: size.height,
                color: Colors.black45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Tacos con carne y pollo",style: _titleStyle,),
                                  Text("▶️ ingrediente 1 \n▶️ ingrediente 1 \n▶️ ingrediente 1 \n▶️ ingrediente 1 \n▶️ ingrediente 1 \n▶️ ingrediente 1 \n▶️ ingrediente 1 \n▶️ ingrediente 1 \n▶️ ingrediente 1 \n",style: _subtitleStyle,overflow: TextOverflow.clip,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.monetization_on,color: Colors.white,),
                                      Text(" 150 PEN",style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)
                                  ],),
                                ],
                              ),
                            ),
                          ),
                          //Icon(Icons.keyboard_arrow_left,color: Colors.white,size: 40.0,)
                          IconButton(
                            padding: EdgeInsets.all(5.0),
                            icon: Icon((!_mostrar)?Icons.chevron_left:Icons.chevron_right,color: Colors.white,size: 50.0,), 
                            onPressed: (){
                              _mostrar = !_mostrar;
                              setState(() {
                                
                              });
                            }
                          )
                        ],
                      ),
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text("Añadir",style: TextStyle(color: Colors.white),),
                          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                          margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(color: Colors.orange),
                          ),
                          child: Text("Solicitar",style: TextStyle(color: Colors.white),),
                          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                          margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                        ),
                        SizedBox(width: 20.0,)
                      ],
                    ),
                    SizedBox(height: 20.0,)
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20.0,
              top: 20.0,
              child: FloatingActionButton(onPressed: ()=>Navigator.pop(context),heroTag: "x3",mini: true,backgroundColor: Colors.black,child: Icon(Icons.close, color: Colors.white,),)
            )
          ],
        ),
      ),
    );
  }
}