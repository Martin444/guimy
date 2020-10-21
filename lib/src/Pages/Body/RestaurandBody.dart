

import 'package:flutter/material.dart';
import 'package:guimyapp/src/GraphQL/GraphQl.dart';
import 'package:guimyapp/src/Provider/ClassReserva.dart';
import 'package:guimyapp/src/Provider/ClassRestaurant.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:guimyapp/src/Widgets/AppBarRestaurant.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';


class MaxPersonas {
  int id;
  int cantidad;
  MaxPersonas(this.id, this.cantidad);
 
  static List<MaxPersonas> getProblems() {
    return <MaxPersonas>[
      MaxPersonas(1, 1),
      MaxPersonas(2, 2),
      MaxPersonas(3, 3),
      MaxPersonas(4, 4),
      MaxPersonas(5, 5),
      MaxPersonas(6, 6),
      MaxPersonas(7, 7),
      MaxPersonas(8, 8),
    ];
  }
}

GraphQLClass graphQl = new GraphQLClass();

class RestaurantBody extends StatefulWidget {

  @override
  _RestaurantBodyState createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  final TextStyle _title = TextStyle(color: Colors.orange[700],fontWeight: FontWeight.w600);

  final TextStyle _styleTitle = TextStyle(color: Colors.orange[700], fontWeight: FontWeight.bold,fontSize: 30.0);

  final TextStyle _styleSubTitle = TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 14.0);
  DateTime selectedData = DateTime.now();
  final DateFormat dateFormat = DateFormat('dd/MM/yy HH:mm');

  List<MaxPersonas> _companies = MaxPersonas.getProblems();
  List<DropdownMenuItem<MaxPersonas>> _dropdownMenuItems;
  MaxPersonas _selectedProblem;

  TextEditingController _control = new TextEditingController();

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedProblem = _dropdownMenuItems[0].value;
    _control.addListener(() { });
    super.initState();
  }


  onChangeDropdownItem(MaxPersonas selectedProblem) {
    setState(() {
      _selectedProblem = selectedProblem;
    });
  }

  List<DropdownMenuItem<MaxPersonas>> buildDropdownMenuItems(List problems) {
    List<DropdownMenuItem<MaxPersonas>> items = List();
    for (MaxPersonas problem in problems) {
      items.add(
        DropdownMenuItem(
          value: problem,
          child: Text(problem.cantidad.toString()),
        ),
      );
    }
    return items;
  }


  @override
  Widget build(BuildContext context) {
    ModelProvider prov = Provider.of<ModelProvider>(context);
    ClassRestaurant rest = Provider.of<ClassRestaurant>(context);
    return Container(
      padding: EdgeInsets.only(top: 60.0,bottom: 50.0),
      color: Colors.grey[300],
      height: double.infinity,
      width: double.infinity,
      // child: _CerrarSesion(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 30.0,),
            _appBody(rest),
            // Spacer()
            if(prov.indexPageRestaurant == 0)_bodyRestaurant(context,rest),
            if(prov.indexPageRestaurant == 1)_bodyRestaurantReserva(context),
            // if(prov.indexPageRestaurant == 1)_bodyRestaurantReserva(context),
            // if(prov.indexPageRestaurant == 2)Container(color: Colors.black,width: double.infinity,height: 200.0,),
            // if(prov.indexPageRestaurant == 3)Container(color: Colors.blue,width: double.infinity,height: 200.0,),
          ],
        ),
      ),

    );
  }

  Widget _appBody(ClassRestaurant rest){
  
  return AppBodyRestaurant(nameRestaurant: rest.resName??"cargando..",urlLogo: (rest.resLogo!= null)?rest.resLogo:"https://img.icons8.com/doodle/48/000000/chef-hat--v1.png",);
  }

  _bodyRestaurant(BuildContext context, ClassRestaurant rest){
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          _btnReservar(context),
          _conocenos(rest),
          _categorias(rest),
          _galeria(),
          _platos(),
          _opiniones(rest),
          _btnOpinar(context),
          
          SizedBox(height: 20.0,)
        ],
      ),
    );
  }

  Widget _btnReservar(BuildContext context){
    ModelProvider prov = Provider.of<ModelProvider>(context,listen: false);
    return Container(
      margin: EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0),
      child: Row(
        children: <Widget>[
          Spacer(),
          InkWell(
            onTap: () {
              prov.indexPageRestaurant = 1;
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(50.0)
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
              child: Text("Reservar",style: _styleSubTitle,),
            ),
          )
        ],
      ),
    );
  }

  Widget _conocenos(ClassRestaurant rest){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Conocenos",style: _title,),
          Text(rest.resDetails??"Nostrud duis amet ipsum exercitation consequat ut anim sit cupidatat duis eiusmod aliquip magna. Proident commodo nostrud non aliquip minim. Nulla laborum voluptate exercitation adipisicing consectetur do ut ex eiusmod minim excepteur. Eiusmod tempor anim occaecat ipsum minim et excepteur dolor est irure ea incididunt proident velit. Labore quis aliquip laboris eu et dolore nisi ex mollit laboris incididunt. Cupidatat enim do amet in nisi aliqua culpa Lorem occaecat.")
        ],
      ),
    );
  }

  Widget _categorias(ClassRestaurant rest){

    final _aux = Card(
                child: Image.asset("lib/src/Sources/categorias/Bebidasyjugos.png"),
                color: Colors.transparent,
                elevation: 0.0,
                margin: EdgeInsets.all(8.0),
              );

    final List<Categorias> vectorCategorias = rest.resCategories;
    print("### VECTOR CATEGIRIAS == ## $vectorCategorias");

    List<Widget> vectorWidgetsCategorias = 
    (vectorCategorias != null)?
    vectorCategorias.map((cat) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        width: 120.0,
        height: 120.0,
        margin: EdgeInsets.all(8.0),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: <Widget>[
            Image.network(cat.informacion["logo"]??"https://es.freelogodesign.org/Content/img/logo-samples/flooop.png",width: 80.0, height: 80.0, fit: BoxFit.cover, ),
            Text(cat.informacion["name"]??"Cargando..",style: _title,)
          ],
        ),
      );
    })?.toList():
    [_aux,_aux,_aux,_aux];

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text("Categorias",style: _title,),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                SizedBox(width: 12.0,),
                ...vectorWidgetsCategorias
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _galeria(){
    final _aux = Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0)
          ),
          child:Image.asset("lib/src/Sources/loadingimage/jar-loading.gif",height: 150.0,)
        ),
      ),
    );
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Galeria",style: _title,),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              SizedBox(width: 12.0,),
              _aux,
              _aux,
              _aux,
              _aux,
              _aux,
              _aux,
              _aux,
              _aux,
              _aux,
              _aux,
            ],
          ),
        )
      ],
    );
  }

  Widget _platos(){
    final Widget _aux =
     InkWell(
       onTap: () {
         Navigator.pushNamed(context, "/Plato");
       },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(10.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // borderRadius: BorderRadius.circular(20.0),
                  // shape: BoxShape.circle
                ),
                child:CircleAvatar(
                  radius: 45.0,
                  backgroundImage: AssetImage("lib/src/Sources/loadingimage/jar-loading.gif"),
                  backgroundColor: Colors.white,
                  // child: Image.asset("lib/src/Sources/loadingimage/jar-loading.gif",height: 100.0,width: 100.0,))
                ),
              ),
            )
          ),
          Container(
            width: 100,
            child: Text("Fetuchin a la carbonera", overflow: TextOverflow.clip,textAlign: TextAlign.center,)
          )
        ],
      ),
    );
    
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text("Platos",style: _title,),
        ),
        Wrap(
          children: <Widget>[
            SizedBox(width: 12.0,),
            _aux,
            _aux,
            _aux,
            _aux,
            _aux,
            _aux,
            _aux,
            _aux,
            _aux,
            _aux,
          ],
        )
      ],
    );
  }

  Widget _opiniones(ClassRestaurant rest){

    List<Comentario> comentarios = rest.comentarios;

    // rest.llenarwidgetsComentarios (comentarios);

    List<Widget> widgetsComentarios = comentarios?.map((Comentario comentario) {
      return Opiniones(comentario: comentario.comentary,autor: comentario.nameComplete,);
    })?.toList()??[Container()];

    print("object ###%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");


    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Opiniones",style: _title,),
              Column(
                children: widgetsComentarios,
              )
            ],
          ),
        ),
        
      ],
    );
  }

  Widget _btnOpinar(BuildContext context){
    ClassRestaurant rest = Provider.of<ClassRestaurant>(context,listen: false);
    ModelProvider prov = Provider.of<ModelProvider>(context,listen: false);
    // ModelProvider prov = Provider.of<ModelProvider>(context,listen: false);

    return Column(
      children: <Widget>[
        Text("Dejanos tu comentario", style: TextStyle(color: Colors.orange, fontSize: 20.0, fontWeight: FontWeight.w600),),
        Container(
          // color: Colors.red,
          // height: 200.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black45)
          ),
          margin: EdgeInsets.symmetric(horizontal: 20.0,),
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          child: TextField(
            // expands: true,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Comentario aqui..",
              // border: OutlineInputBorder(),
              
              filled: true,
            ),
            onChanged: (value) {
              rest.comentarioUser = _control.text;
              // print("#################");
              // print(_control.text);
              // print(_control.value);
              // print(_control.toString());

              // _control.value;
              // _control.text = value + "x";
            },

            controller: _control,
          ),
        ),
        InkWell(
          onTap: () async {
            // prov.indexPage = 11;
            final respuesta = await graphQl.insertarComentarioRest(
              prov.userIdGraphql,
              rest.restID,
              rest.comentarioUser,
              prov.userName,
            );


            // Map comentarios = await graphQl.ejecutarConsultaComentarios(rest.restID);
            // print("### resultado DATOS: $comentarios");
            // await rest.cargarComentarios(comentarios);
            Toast.show("Gracias por tu comentario", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
            // comentarios = 
            _control.text = "";
            // print("####################33");
            // print(rest.comentarios);
            await rest.nuevoComentario(respuesta["insert_restaurant_comments_one"]);
            // List<Comentario> comentarios2 = rest.comentarios;
            // rest.llenarwidgetsComentarios (comentarios2);
            setState(() {
              
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            width: double.infinity,
            child: Text("Opinar",style: _styleSubTitle,),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(50.0)
            ),

          ),
        ),
      ],
    );
  }

  _bodyRestaurantReserva(BuildContext context){
    ModelProvider prov = Provider.of<ModelProvider>(context,listen: false);
    ClassReserva reserva = Provider.of<ClassReserva>(context,listen: false);
    ClassRestaurant restaurant = Provider.of<ClassRestaurant>(context,listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Text("Reserva",style: _styleTitle,),
          _inputNombre(reserva),
          _inputApellido(reserva),
          _inputNumeroID(reserva),
          _inputMaxPersonas(reserva),
          _seleccionarFechaHora(context,reserva),
          _inputMensaje(reserva),
          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    prov.indexPageRestaurant = 0;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Colors.orange,width: 2.0)
                    ),
                    child: Text("Cancel", style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async{
                    // print(prov.uid);
                    // print(prov.userId);
                    // print(prov.userIdGraphql);
                    
                    reserva.userID = prov.userIdGraphql;
                    reserva.restaurantID = restaurant.restID;

                    prov.indexPage = 12;
                    Future.delayed(Duration(seconds: 3),(){
                      prov.indexPage = 13;
                    });
                      // cargarNuevaPagina(prov);
                    // await graphQl.insertarReserva(
                    //   reserva.userID, 
                    //   reserva.reservafirstName, 
                    //   reserva.reservalastName, 
                    //   reserva.reservanumeroIdentidad, 
                    //   reserva.reservamaxPersons, 
                    //   reserva.reservadate, 
                    //   reserva.reservamessage, 
                    //   reserva.restaurantID
                    //   );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Colors.orange,width: 2.0)
                    ),
                    child: Text("Solicitar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  Widget _inputNombre(ClassReserva reserva){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0)
          ),
          hintText: "Nombres",
          alignLabelWithHint: false,
          filled: true
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          reserva.reservafirstName = value;
          // print(value);
        },
      ),
    );
  }

  Widget _inputApellido(ClassReserva reserva){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0)
          ),
          hintText: "Apellidos",
          alignLabelWithHint: false,
          filled: true
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          reserva.reservalastName = value;
        },
      ),
    );
  }

  Widget _inputNumeroID(ClassReserva reserva){
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0)
          ),
          hintText: "Numero de identidad",
          alignLabelWithHint: false,
          filled: true
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          reserva.reservanumeroIdentidad = value;
        },
      ),
    );
  }

  Widget _inputMaxPersonas(ClassReserva reserva){
    return Column(
      children: <Widget>[
        Text("Max. de personas"),
        Container(
          // color: Colors.red,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: Colors.black45)
          ),
          child: DropdownButton(
            value: _selectedProblem,
            items: _dropdownMenuItems,
            onChanged: (value) {
              
              onChangeDropdownItem(value);
              print(value.cantidad);
              reserva.reservamaxPersons = value.cantidad;
            },

            isExpanded: true,
          ),
        ),
      ],
    );
  }

  _seleccionarFechaHora(BuildContext context,ClassReserva reserva){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
      child: Column(
        children: <Widget>[
          Text("Fecha de reserva: ${dateFormat.format(selectedData)}", style: TextStyle(fontWeight: FontWeight.bold),),
          GestureDetector(
            onTap: () async {
              final selectedData = await _selecDate(context);
              print("## DATE $selectedData");

              final selectTime = await _selectedTime(context);
              print("## TIME $selectTime");
              reserva.reservadate = "${selectedData.toString().substring(0,10)} ${selectTime.toString().substring(10,15)}";

              setState(() {
                this.selectedData = DateTime(
                  selectedData?.year,
                  selectedData?.month,
                  selectedData?.day,
                  selectTime?.hour,
                  selectTime?.minute

                )??DateTime.now();
              });
            },
            child: Container(
              // height: 50.0,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.black45)
              ),
              child: Text("Seleccione Dia y Hora de reserva",style: TextStyle(fontSize: 12.0),),
              padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
            ),
          )
        ],
      ),
    );
  }

  _inputMensaje(ClassReserva reserva){
    return Container(
      // color: Colors.red,
      // height: 200.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.black45)
      ),
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      width: double.infinity,
      child: TextField(
        // expands: true,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: "Mensaje",
          // border: OutlineInputBorder(),
          
          filled: true,
        ),
        onChanged: (value) {
          reserva.reservamessage = value;
        },
      ),
    );
  }

  Future<TimeOfDay> _selectedTime(BuildContext context) {
    final now = DateTime.now();
    
    return showTimePicker(context: context, initialTime: TimeOfDay(hour: now.hour, minute: now.minute));
  }

  Future<DateTime> _selecDate(BuildContext context)=>showDatePicker(
                context: context, 
                initialDate: DateTime.now().add(Duration(seconds: 1)), 
                firstDate: DateTime.now(), 
                lastDate: DateTime(2023)
              );
}
//"El Fundo del abuelo"


class Opiniones extends StatelessWidget {
  final String comentario;
  final String autor;
  Opiniones({@required this.comentario,@required this.autor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          // maxHeight: 80.0,
          minHeight: 50.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text("$autor")),
                Row(
                  children: <Widget>[
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star,color: Colors.orange,),
                    Icon(Icons.star_half,color: Colors.orange,),
                  ],
                ),
              ],
            ),
            Container(child: Text("$comentario", overflow: TextOverflow.fade,)),
            // Row(
            //   children: <Widget>[
            //     Spacer(),
            //     Text("ver mas..."),
            //   ],
            // )
          ],
        ),
      ),

    );
  }

}