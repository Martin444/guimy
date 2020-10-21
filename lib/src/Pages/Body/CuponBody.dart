import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
class CuponBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60.0,bottom: 40.0),
      // color: Colors.grey[300],
      // height: size.height,
      
      child: SingleChildScrollView(
        child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 580.0,
          maxHeight: 600.0
        ),
          child: Stack(
            children: [
              HeaderEnCurve(),
              Column(
                children: [
                  Container(height: 20.0,),
                  _inputCode(),
                  Image(image: AssetImage("lib/src/Sources/Logos/ticket.png"),height: 200.0,fit: BoxFit.cover,),
                  SizedBox(height: 80.0,),
                  Text("¿Quieres ganar"   ,style: TextStyle(color: Colors.orange[200], fontSize: 24.0,fontWeight: FontWeight.bold,),),
                  Text("15% de descuento?",style: TextStyle(color: Colors.orange[200], fontSize: 28.0,fontWeight: FontWeight.bold,),),
                  Text("invita a tus amigos",style: TextStyle(color: Colors.orange[200], fontSize: 18.0),),
                  _codeShare(),
                  _SeccionCopyShare("CODIG COPIADO"),

                  // CustomToolTip(text: "CODIGO",),
                  Container(height: 20.0,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _inputCode(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
      height: 40.0,
      child: TextField(
        // controller: _email,
        
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintText: "Insertar Codigo",
          hintStyle: TextStyle(color: Colors.red[100],),
          alignLabelWithHint: false,
          filled: true
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      ),
    );
  }



  Widget _codeShare(){
     final TextEditingController controller = TextEditingController(text:"CODE USER");

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
      height: 40.0,
      child: TextField(
        // controller: _email,
        // autofocus: false,
        
        enabled: false,
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.orange[200], fontWeight: FontWeight.bold,),
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          hintText: "Codigo",
          hintStyle: TextStyle(color: Colors.red[100],),
          alignLabelWithHint: false,
          filled: true
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}

class _SeccionCopyShare extends StatelessWidget {

  final String frase;

  _SeccionCopyShare(this.frase);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: (){
              Toast.show("Codigo copiado", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              // print("####### COPIADO");
              Clipboard.setData(ClipboardData(text: frase));
            },
            child: Icon(Icons.content_copy,size: 40.0,color: Colors.grey,)
          ),

          GestureDetector(
            onTap: (){
              // Clipboard.setData(ClipboardData(text: frase));
              Share.share('flutter is Cool');
            },
            child: Icon(Icons.share,size: 40.0,color: Colors.grey,)
          )
        ],
      ),
    );
  }
}
class HeaderEnCurve extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      //color: Colors.purpleAccent,
      child: CustomPaint(
        painter: _HeaderCurvePainter(),
      ),
    );
  }
}

class _HeaderCurvePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();
    //propiedades
    lapiz.color = Colors.red;
    lapiz.style = PaintingStyle.fill;//stroke 
    lapiz.strokeWidth = 10;

    final path = Path();

    //dibujar con el path y el lapiz
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.55);
    path.quadraticBezierTo(size.width * 0.5, size.height *0.40, size.width, size.height * 0.55);
    //path.lineTo(size.width * 0.5, size.height *0.40);
    //path.lineTo(size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    


    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

