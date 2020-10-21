import 'package:flutter/material.dart';
class BackGroundWidget extends StatelessWidget {

  final Size size;
  BackGroundWidget(this.size);

  @override
  Widget build(BuildContext context) {
    double _opacity = 0.8;

    final size = MediaQuery.of(context).size;
    final _width = size.width/100;
    final _heigh = size.height/100;
    final iconTam = _width*30;
    double _sizeImage = iconTam;
    return Container(
      color: Color(0xFFFC4242),
      child: Stack(
        children: [
          Positioned( top: _heigh,     left: _width,          height: _sizeImage,     width: _sizeImage ,    child: Image.asset("lib/src/Sources/Elements/Beverage.png",color: Colors.white.withOpacity(_opacity),     height: iconTam,width: iconTam,)),
          Positioned( top: _heigh*10,  right: _width*5,       height: _sizeImage,     width: _sizeImage ,    child: Image.asset("lib/src/Sources/Elements/Dessert.png",color: Colors.white.withOpacity(_opacity),      height: iconTam,width: iconTam,)),
          Positioned( top: _heigh*30,  left: _width,          height: _sizeImage,     width: _sizeImage ,    child: Image.asset("lib/src/Sources/Elements/Maincourse.png",color: Colors.white.withOpacity(_opacity),   height: iconTam,width: iconTam,)),
          Positioned( top: _heigh*40,  right: _width,         height: _sizeImage,     width: _sizeImage ,    child: Image.asset("lib/src/Sources/Elements/Mexicanfood-1.png",color: Colors.white.withOpacity(_opacity),height: iconTam,width: iconTam,)),
          Positioned( top: _heigh*60,  left: _width,          height: _sizeImage,     width: _sizeImage-20 , child: Image.asset("lib/src/Sources/Elements/Salad.png",color: Colors.white.withOpacity(_opacity),        height: iconTam,width: iconTam,)),
          Positioned( top: _heigh*70,  right: _width,         height: _sizeImage,     width: _sizeImage ,    child: Image.asset("lib/src/Sources/Elements/Burger.png",color: Colors.white.withOpacity(_opacity),       height: iconTam,width: iconTam,)),
          Positioned( top: _heigh*85,  left: _width*35,       height: _sizeImage,     width: _sizeImage ,    child: Image.asset("lib/src/Sources/Elements/Mexicanfood-1.png",color: Colors.white.withOpacity(_opacity),height: iconTam,width: iconTam,)),
        ],
      ),
    );
  }
}