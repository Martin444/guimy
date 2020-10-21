import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
final _picker = ImagePicker();
File imagen;
class ItemConsultasTwo extends StatefulWidget {
  @override
  _ItemConsultasTwoState createState() => _ItemConsultasTwoState();
}

class _ItemConsultasTwoState extends State<ItemConsultasTwo> {

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
            Text("Tuve un problema con mi pedido",style: _titleStyle,),
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
                onChanged: onChangeDropdownItem,
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
              ),
            ),
            _insertarImagen(_subtitleStyle, _textBotonStyle),

            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
              // color: Colors.orange,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(50.0)
              ),
              child: Text("Enviar",style: _textBotonStyle,),
            ) 
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
                    color: Colors.grey,
                    child: (imagen!=null)?
                    Image(image: FileImage(imagen),fit: BoxFit.cover,)
                    :
                    CircularProgressIndicator() ,
                  )
                ],
              ),

              GestureDetector(
                onTap: () async{
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