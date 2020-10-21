

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guimyapp/src/Provider/ClassMensajeProblem.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:guimyapp/src/Provider/ModelReportConsultasMensajeria.dart';
import 'package:guimyapp/src/Templates/HomePage.dart';
// import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
final _picker = ImagePicker();
File imagen;

String _problema ="Tuve un problema con mi pedido";
String _mensajeProblema ="";
// ignore: must_be_immutable
class ItemReportar extends StatefulWidget {

  String title;
  ItemReportar({@required this.title});
  @override
  _ItemReportarState createState() => _ItemReportarState(title: title);
}

class _ItemReportarState extends State<ItemReportar> {

  String title;
  _ItemReportarState({@required this.title});

  List<Problem> _companies = Problem.getProblems();
  List<DropdownMenuItem<Problem>> _dropdownMenuItems;
  Problem _selectedProblem;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedProblem = _dropdownMenuItems[0].value;
    super.initState();
  }


  List<DropdownMenuItem<Problem>> buildDropdownMenuItems(List problems) {
    List<DropdownMenuItem<Problem>> items = List();
    for (Problem problem in problems) {
      items.add(
        DropdownMenuItem(
          value: problem,
          child: Text(problem.name),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(Problem selectedProblem) {
    setState(() {
      _selectedProblem = selectedProblem;
    });
  }


  @override
  Widget build(BuildContext context) {
    final _titleStyle = TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 20.0);
    final _subtitleStyle = TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,);
    final _textBotonStyle = TextStyle(color: Colors.white,fontWeight: FontWeight.bold,);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("$title",style: _titleStyle,),
            Container(
              // color: Colors.red,
              margin: EdgeInsets.symmetric(vertical: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: DropdownButton(
                value: _selectedProblem,
                items: _dropdownMenuItems,

                onChanged: (Problem valor){
                  onChangeDropdownItem(valor);
                  _problema = valor.name;
                },
                isExpanded: true,
              ),
            ),
            Container(
              width: double.infinity,
              child: Text("Danos mas detalles",style: _subtitleStyle,)
            ),
            Container(
              // color: Colors.red,
              // height: 200.0,
              margin: EdgeInsets.only(bottom: 10.0),
              width: double.infinity,
              child: TextField(
                // expands: true,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Escribe aqui",
                  // border: OutlineInputBorder(),
                  
                  filled: true,
                ),
                onChanged: (value) {
                  _mensajeProblema = value;
                },
              ),
            ),
            _insertarImagen(_subtitleStyle, _textBotonStyle),
            GestureDetector(
              onTap: () async {
                  Toast.show("Reporte enviado..", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                  ClassMensajeProblem _sendProblem = Provider.of<ClassMensajeProblem>(context, listen: false);
                  ModelProvider _prov = Provider.of<ModelProvider>(context,listen: false);
                  


                  // ClassMensajeProblem _sendProblem = Provider.of<ClassMensajeProblem>(context, listen: false);

                  final dato = await _funcionCargarDatos(_sendProblem);
                  _sendProblem.urlImagen = dato;

                  _sendProblem.tag = _problema;
                  _sendProblem.msg = _mensajeProblema;

                  Map respuesta = await graphQl.insertarReportar(
                    categoria: "$title",
                    estado: "En revision",
                    tag: _sendProblem.tag, 
                    msg: _sendProblem.msg,
                    imgUrl: _sendProblem.urlImagen??"sin imagen",
                    userID: _prov.userIdGraphql
                  );

                  print("&&&&&&&&& $respuesta");
                  _sendProblem.agregarUnMensaje(respuesta["insert_chats_one"]);
                  _sendProblem.agregarUnMensajeMAP(respuesta["insert_chats_one"]);
                  print(" LISTA MENSAJES ${_sendProblem.listaMsjWidget}");
                  _sendProblem.tag = "";
                  _sendProblem.msg = "";
                  _sendProblem.urlImagen="";
                  _mensajeProblema="";
                  imagen = null;
                  Provider.of<ModelReportConsultasMensajerias>(context, listen: false).bodyPage =0;

              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                // color: Colors.orange,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(50.0)
                ),
                child: Text("Enviar",style: _textBotonStyle,),
              ),
            ) ,

            GestureDetector(
              onTap: () async {
                  Toast.show("Mensaje cancelado", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                  ClassMensajeProblem _sendProblem = Provider.of<ClassMensajeProblem>(context, listen: false);
                  // ModelProvider _prov = Provider.of<ModelProvider>(context,listen: false);
                  


                  // ClassMensajeProblem _sendProblem = Provider.of<ClassMensajeProblem>(context, listen: false);

                  // final dato = await _funcionCargarDatos(_sendProblem);
                  // _sendProblem.urlImagen = dato;

                  // _sendProblem.tag = _problema;
                  // _sendProblem.msg = _mensajeProblema;

                  // await graphQl.insertarReportar(
                  //   categoria: "$title",
                  //   estado: "En revision",
                  //   tag: _sendProblem.tag,
                  //   msg: _sendProblem.msg,
                  //   imgUrl: _sendProblem.urlImagen??"sin imagen",
                  //   userID: _prov.userIdGraphql
                  // );


                  _sendProblem.tag = "";
                  _sendProblem.msg = "";
                  _sendProblem.urlImagen="";
                  _mensajeProblema="";
                  imagen = null;
                  Provider.of<ModelReportConsultasMensajerias>(context, listen: false).bodyPage =0;

              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                // color: Colors.orange,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(50.0)
                ),
                child: Text("Cancelar",style: _textBotonStyle,),
              ),
            ) ,
            
          ],
        ),
      ),
    );


  }

  _insertarImagen(TextStyle _subtitleStyle, TextStyle _textBotonStyle) {

    
    return Wrap(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Inserte una imagen",style: _subtitleStyle),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                    ),
                    child: (imagen!=null)?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(image: FileImage(imagen),fit: BoxFit.cover,)
                      )
                    :
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
                      strokeWidth: 1.0,
                    ) ,
                  )
                ],
              ),

              GestureDetector(
                onTap: () async{
                  
                  // ModelProvider _prov = Provider.of<ModelProvider>(context,listen: false);
                  final pickedFile = await _picker.getImage(source: ImageSource.gallery);
                  imagen = File(pickedFile.path);


                  

                  setState(() {
                    
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  // color: Colors.orange,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(50.0)
                  ),
                  child: Text("Insertar Imagen",style: _textBotonStyle),
                ),
              ) 
            ],
          );
  }

  Future<String> _funcionCargarDatos(ClassMensajeProblem currentUser)async{

    String valor;

    if(imagen!= null){
      valor = await currentUser.subirImagen(imagen);
    }else{
      print("####c### _image es null");
      valor = "nulo";
    }    
    return valor;
  }
  
}


class Problem {
  int id;
  String name;
  Problem(this.id, this.name);
 
  static List<Problem> getProblems() {
    return <Problem>[
      Problem(1, 'No llego lo que pedi'),
      Problem(2, 'No llego lo que pedi'),
      Problem(3, 'No llego lo que pedi'),
      Problem(4, 'No llego lo que pedi'),
      Problem(5, 'No llego lo que pedi'),
    ];
  }
}