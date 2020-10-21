
import 'package:flutter/material.dart';
import 'package:guimyapp/src/Pages/Body/starBodyParts/Local.dart';
import 'package:guimyapp/src/Pages/Body/starBodyParts/Global.dart';
import 'package:guimyapp/src/Pages/Body/starBodyParts/Regional.dart';
import 'package:guimyapp/src/Provider/ModelTopRest.dart';
import 'package:provider/provider.dart';
class StarBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60.0,bottom: 30.0),
      color: Colors.grey[300],
      height: double.infinity,
      // child: _CerrarSesion(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            // Divider(),
            _SelectedCategory(),
            _BodyRankWidget(),
            // Divider(),
            // Column(
            //   children: [
            //     Text("1°",style: TextStyle(color: Colors.orange, fontSize: 50.0,fontWeight: FontWeight.bold),),

            //     _BodyRankWidget(),

            //     Text("Astrid & Gaston",style: TextStyle(color: Colors.orange, fontSize: 30.0,fontWeight: FontWeight.bold),),

            //     Container(
            //       margin: EdgeInsets.symmetric(horizontal: 50.0,vertical: 40.0),
            //       padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(50.0),
            //         color: Colors.orange,

            //       ),
            //       child: Text("Visitar",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.0),),
            //       alignment: Alignment.center,
            //     )
            //   ],
            // ),
            //SizedBox(height: 20.0,)
          ],
        ),
      ),

    );
  }
}

class _BodyRankWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _provIndex = Provider.of<ModelTopRest>(context).topBodyPage;
    
    return _widgetIndex(_provIndex);
  }

  Widget _widgetIndex(int index){
    print(index);
    switch (index) {
      case 1:
        return new GlobalWidget();
        break;
      case 2:
        return new RegionalWidget();
        break;
      case 3:
        return new LocalWidget();
        break;
      default:
        return new GlobalWidget();
    }

  }

}


class _SelectedCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double alturaCont = 35.0;
    final _color = Color(0xffFEAD4C);
    final _colorSec = Colors.white;
    final _shadow = [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 3),
                  blurRadius: 3.0
                )
              ];
    final _stiloText = TextStyle(color: Colors.white,fontSize: 16.0, fontWeight: FontWeight.w700);
    final _stiloTextSec = TextStyle(color: Colors.orange,fontSize: 16.0,  fontWeight: FontWeight.w700);
    ModelTopRest _providerTop = Provider.of<ModelTopRest>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                _providerTop.topBodyPage = 1;
              },
              child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: (_providerTop.topBodyPage == 1)?_colorSec:_color,
                boxShadow: _shadow
              ),
              height: alturaCont,
              child: Text("Global",style: (_providerTop.topBodyPage == 1)?_stiloTextSec:_stiloText,),
              alignment: Alignment.center,


          ),
            )),
          Expanded(
            child: GestureDetector(
              onTap: (){
                _providerTop.topBodyPage = 2;
              },
              child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: (_providerTop.topBodyPage == 2)?_colorSec:_color,
                boxShadow: _shadow
              ),
              height: alturaCont,
              child: Text("Regional",style:(_providerTop.topBodyPage == 2)?_stiloTextSec:_stiloText,),
              alignment: Alignment.center,

          ),
            )),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _providerTop.topBodyPage = 3;
              },
              child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: (_providerTop.topBodyPage == 3)?_colorSec:_color,
                boxShadow: _shadow
              ),
              height: alturaCont,
              child: Text("Local",style:(_providerTop.topBodyPage == 3)?_stiloTextSec:_stiloText,),
              alignment: Alignment.center,

          ),
            ))
        ],
      ),
    );
  }
}


