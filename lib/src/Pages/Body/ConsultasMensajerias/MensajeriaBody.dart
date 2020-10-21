import 'package:flutter/material.dart';
// import 'package:guimyapp/src/GraphQL/GraphQl.dart';
// import 'package:guimyapp/src/Pages/Body/ConsultasMensajerias/ItemMensajeria.dart';
import 'package:guimyapp/src/Provider/ClassMensajeProblem.dart';
import 'package:provider/provider.dart';

// GraphQLClass gpql = new GraphQLClass();

class MensajeriaBody extends StatefulWidget {
  @override
  _MensajeriaBodyState createState() => _MensajeriaBodyState();
}

class _MensajeriaBodyState extends State<MensajeriaBody> {


  @override
  Widget build(BuildContext context) {
    ClassMensajeProblem problem = Provider.of<ClassMensajeProblem>(context);
    return SingleChildScrollView(
      child: Column(
        children: 
        problem.listaMsjWidget??[Container()],
      ),
    );
  }
}