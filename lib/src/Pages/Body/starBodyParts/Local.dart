import 'package:flutter/material.dart';

class LocalWidget extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
      final _controller = PageController();

      final size = MediaQuery.of(context).size;

      return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height-200,
          child: PageView(
            controller: _controller,

            onPageChanged: (index){
              // print("####### controller: ${_controllerPage.offset} ___ index: $index");
            },
            scrollDirection: Axis.horizontal,
            children: [
              _ItemPageView(1),
              _ItemPageView(2),
              _ItemPageView(3),
              _ItemPageViewRecomendacion()
            ],
          ),
        ),
        Positioned(
          left: 20.0,
          child: Row(
            children:[ 
              GestureDetector(
              onTap: () {
                _controller.previousPage (duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              },
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 3.0,
                      color: Colors.black26
                    )
                  ]
                ),
                child: Icon(Icons.arrow_left,color: Colors.grey),
                alignment: Alignment.topLeft,
              ),
            ),
            Container(
              height: size.height/2,
            )
            ]
          )
        ),
        Positioned(
          right: 20.0,
          child: Row(
            children:[ 
              GestureDetector(
              onTap: () {
                _controller.nextPage (duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              },
              child: Container(
                width: 25.0,
                height: 25.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 3.0,
                      color: Colors.black26
                    )
                  ]
                ),
                child: Icon(Icons.arrow_right,color: Colors.grey),
                alignment: Alignment.topLeft,
              ),
            ),
            Container(
              height: size.height/2,
            )
            ]
          )
        ),
      ],
    );
    }
}

class _ItemPageView extends StatelessWidget {
  final int numero;

  _ItemPageView(this.numero);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$numero°",style: TextStyle(color: Colors.orange, fontSize: 50.0,fontWeight: FontWeight.bold),),
        CircleAvatar(
          radius: 80.0,
          backgroundColor: Colors.red,
        ),
        SizedBox(height: 10.0,),
                Text("Local",style: TextStyle(color: Colors.orange, fontSize: 30.0,fontWeight: FontWeight.bold),),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 50.0,vertical: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.orange,

                  ),
                  child: Text("Visitar",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.0),),
                  alignment: Alignment.center,
                )
      ],
    );
  }
}



class _ItemPageViewRecomendacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.star,color: Colors.orange,size: 30.0,),
        Text("Recomendacion por",style: TextStyle(color: Colors.orange, fontSize: 20.0,fontWeight: FontWeight.bold),),
        Text("Guimy",style: TextStyle(color: Colors.orange, fontSize: 30.0,fontWeight: FontWeight.bold),),
        CircleAvatar(
          radius: 80.0,
          backgroundColor: Colors.red,
        ),
        SizedBox(height: 5.0,),
        Text("Astrid & Gaston",style: TextStyle(color: Colors.orange, fontSize: 30.0,fontWeight: FontWeight.bold),),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.orange,

          ),
          child: Text("Visitar",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.0),),
          alignment: Alignment.center,
        )
      ],
    );
  }
}