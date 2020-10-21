import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guimyapp/src/Widgets/BackGroundWidget.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 5),(){
        Navigator.pushReplacementNamed(context, "/ourRoot");
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Color.fromRGBO(239,241,250, 1.0),
        //backgroundColor: Colors.black,
        body: Stack(
          children: [
            BackGroundWidget(size),
            Container(
              alignment: Alignment.center,
              child:SvgPicture.asset("lib/src/Sources/Logos/LogoGuimySVG.svg", height: 60, color: Colors.white,),),
          ],
        ),
      ),
    );
  }

  // Widget _background(Size size){
  //   double _sizeImage = 110.0;
  //   double _opacity = 0.3;
  //   return Stack(
  //     children: [
  //       Positioned(top: 20.0, left: 20.0,   width: _sizeImage , child: Image.asset("lib/src/Sources/Elements/Beverage.png",color: Colors.black.withOpacity(_opacity),)),
  //       Positioned(top: 100.0, right: 30.0, width: _sizeImage , child: Image.asset("lib/src/Sources/Elements/Dessert.png",color: Colors.black.withOpacity(_opacity),)),
  //       Positioned(top: 180.0, left: 20.0,  width: _sizeImage , child: Image.asset("lib/src/Sources/Elements/Maincourse.png",color: Colors.black.withOpacity(_opacity),)),
  //       Positioned(top: 300.0, right: 20.0, width: _sizeImage , child: Image.asset("lib/src/Sources/Elements/Mexicanfood-1.png",color: Colors.black.withOpacity(_opacity),)),
  //       Positioned(top: 400.0, left: 10.0,  width: _sizeImage-20 , child: Image.asset("lib/src/Sources/Elements/Salad.png",color: Colors.black.withOpacity(_opacity),)),
  //       Positioned(top: 410.0, right: 10.0,  width: _sizeImage , child: Image.asset("lib/src/Sources/Elements/Burger.png",color: Colors.black.withOpacity(_opacity),)),
  //       Positioned(top: 530.0, left: size.width/2 -55,  width: _sizeImage , child: Image.asset("lib/src/Sources/Elements/Mexicanfood-1.png",color: Colors.black.withOpacity(_opacity),)),
  //     ],
  //   );
  // }
}