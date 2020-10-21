import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:guimyapp/src/GraphQL/GraphQl.dart';
import 'package:guimyapp/src/Pages/Body/ConsultasMensajerias/ConsultasBody.dart';
import 'package:guimyapp/src/Pages/Body/ConsultasMensajerias/ItemReportar.dart';
import 'package:guimyapp/src/Pages/Body/ConsultasMensajerias/ItemConsultasFour.dart';
import 'package:guimyapp/src/Pages/Body/ConsultasMensajerias/MensajeriaBody.dart';
import 'package:guimyapp/src/Provider/ClassMensajeProblem.dart';
import 'package:guimyapp/src/Provider/ModelProvider.dart';
import 'package:guimyapp/src/Provider/ModelReportConsultasMensajeria.dart';
import 'package:provider/provider.dart';
GraphQLClass gpql = new GraphQLClass();
class ReportarBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ModelProvider provider = Provider.of<ModelProvider>(context);
    return Container(
      padding: EdgeInsets.only(top: 60.0,bottom: 50.0),
      color: Colors.grey[300],
      height: double.infinity,
      // child: _CerrarSesion(),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 30.0,),
              GestureDetector(
                onTap: () {
                  provider.indexPage=8;
                  Provider.of<ModelReportConsultasMensajerias>(context, listen: false).currentPage = 0;
                  Provider.of<ModelReportConsultasMensajerias>(context, listen: false).bodyPage = 0;
                },
                child: Row(children: <Widget>[Icon(Icons.chevron_left),Text("Atrás")],)
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      int numAux = Provider.of<ModelReportConsultasMensajerias>(context, listen: false).bodyPage;
                      if(numAux ==0){
                        Provider.of<ModelReportConsultasMensajerias>(context, listen: false).currentPage = 0;
                        PageController contr =  Provider.of<ModelReportConsultasMensajerias>(context, listen: false).pageViewController;
                        contr.jumpToPage(0);
                        Provider.of<ModelReportConsultasMensajerias>(context, listen: false).pageViewController = contr;
                      }else{
                        Provider.of<ModelReportConsultasMensajerias>(context, listen: false).bodyPage =0;
                      }
                    },
                    child: _TopIndexPage("Consultas",0)
                  ),
                  GestureDetector(
                    onTap: () async{
                      ClassMensajeProblem problem = Provider.of<ClassMensajeProblem>(context,listen: false);
                      ModelProvider prov = Provider.of<ModelProvider>(context,listen: false);
                      problem.listaMsj = await gpql.ejecutarConsultaMensajes(prov.userIdGraphql);
                      int numAux = Provider.of<ModelReportConsultasMensajerias>(context, listen: false).bodyPage;
                      if(numAux ==0){
                        Provider.of<ModelReportConsultasMensajerias>(context, listen: false).currentPage = 1;
                        PageController contr =  Provider.of<ModelReportConsultasMensajerias>(context, listen: false).pageViewController;
                        contr.jumpToPage(1);
                        // Provider.of<ModelReportConsultasMensajerias>(context, listen: false).bodyPage = 0;
                        Provider.of<ModelReportConsultasMensajerias>(context, listen: false).pageViewController = contr;
                      }
                      

                    },
                    child: _TopIndexPage("Mensajería",1)
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),

              _retornoBody(context),// _PageViewMensajeriaConsultas(),
              SizedBox(height: 15.0,),
            ],
          ),
        ),
      ),
    );
  }


  Widget _retornoBody(BuildContext context){

    ModelReportConsultasMensajerias providerBody = Provider.of<ModelReportConsultasMensajerias>(context);
    switch (providerBody.bodyPage) {
      case 0:
        return  _PageViewMensajeriaConsultas();
        break;
      case 1:
        return  ItemReportar(title: "Tuve un problema con mi pedido",);
        break;
      case 2:
        return  ItemReportar(title: "Mis canjes y promociones no funcionan",);
        break;
      case 3:
        return  ItemReportar(title: "Tuve una mala experiencia con el repartidor",);
        break;
      case 4:
        return  ItemConsultasFour();
        break;
      case 5:
        return  ItemReportar(title: "Tuve un problema con el pago",);
        break;
      case 6:
        return  ItemReportar(title: "Otro tipo de problema",);
        break;
      default:
        return  _PageViewMensajeriaConsultas();
    }
    
  }
}

class _PageViewMensajeriaConsultas extends StatefulWidget {

  @override
  __PageViewMensajeriaConsultasState createState() => __PageViewMensajeriaConsultasState();
}

class __PageViewMensajeriaConsultasState extends State<_PageViewMensajeriaConsultas> {


  PageController pageViewController = new PageController();

  @override
  void dispose() {
    super.dispose();
    //pageViewController.dispose();
  }

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      // print(pageViewController.page);
      Provider.of<ModelReportConsultasMensajerias>(context, listen: false).currentPage = pageViewController.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    pageViewController = Provider.of<ModelReportConsultasMensajerias>(context).pageViewController;
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width-40,
      height: size.height-250,
      child: PageView(
        onPageChanged: (value) {
            Provider.of<ModelReportConsultasMensajerias>(context, listen: false).currentPage = value/1.0;
        },
        scrollDirection: Axis.horizontal,
        controller: pageViewController,
        children: <Widget>[
          ConsultasBody(),
          MensajeriaBody(),

        ],
      ),
    );
  }
}

class _TopIndexPage extends StatelessWidget {
  final String texto;
  final int index;
  _TopIndexPage(this.texto,this.index);
  @override
  Widget build(BuildContext context) {
    double currentPage = Provider.of<ModelReportConsultasMensajerias>(context).currentPage;
    return Column(
      children:<Widget>[
        Text("$texto",style: TextStyle(color: Colors.grey[600],fontSize: 20.0,fontWeight: FontWeight.w800),),
        
        if(currentPage < 0.5)
          SlideInRight(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: (index ==0)?Colors.grey[600]:Colors.transparent,
              ),
              height: 5.0,
              width: 50.0,
            ),
          ),
        
        if(currentPage >= 0.5)
          SlideInLeft(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: (index ==1)?Colors.grey[600]:Colors.transparent,
              ),
              height: 5.0,
              width: 50.0,
            ),
          ),
        
      ] 
    );
  }
}
