import 'package:flutter/material.dart';
class HomeBody extends StatelessWidget {
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
            _BodySupPart(),
            Divider(),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 150.0,
              child: Image.asset("lib/src/Sources/Logos/baner1.png")
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),

    );
  }
}

class _BodySupPart extends StatefulWidget {
  @override
  __BodySupPartState createState() => __BodySupPartState();
}

class __BodySupPartState extends State<_BodySupPart> {
  final _controllerPage = PageController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: 330,
          child: PageView(
            controller: _controllerPage,

            onPageChanged: (index){
              // print("####### controller: ${_controllerPage.offset} ___ index: $index");
            },
            scrollDirection: Axis.horizontal,
            children: [
              _ItemBodySupPart(Colors.orange),
              _ItemBodySupPart(Colors.yellow),
              _ItemBodySupPart(Colors.blue),
            ],
            // child: Row(
            //   children: [
            //     _ItemBodySupPart(Colors.orange),
            //     _ItemBodySupPart(Colors.yellow),
            //     _ItemBodySupPart(Colors.blue),
            //   ],
            // ),
          ),
        ),
        Positioned(
          child: Row(
            children:[ 
              GestureDetector(
              onTap: () {
                _controllerPage.previousPage (duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              },
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                child: Icon(Icons.arrow_left,color: Colors.grey),
                alignment: Alignment.topLeft,
              ),
            ),
            Container(
              height: 350,
            )
            ]
          )
        ),
        Positioned(
          right: 0.0,
          child: Row(
            children:[ 
              GestureDetector(
              onTap: () {
                _controllerPage.nextPage (duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              },
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                child: Icon(Icons.arrow_right,color: Colors.grey),
                alignment: Alignment.topLeft,
              ),
            ),
            Container(
              height: 350,
            )
            ]
          )
        ),
      ],
    );
  }
}

class _ItemBodySupPart extends StatelessWidget {
  final Color color;
  _ItemBodySupPart(this.color);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: size.width-20,
      height: 350,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset("lib/src/Sources/Logos/panel1.png", fit: BoxFit.cover,)),
    );
  }
}