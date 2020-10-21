import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class LocationBody extends StatefulWidget {
  @override
  _LocationBodyState createState() => _LocationBodyState();
}

class _LocationBodyState extends State<LocationBody> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-12.046340, -77.042470),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 0.0,
      target: LatLng(-12.046340, -77.042470),
      //tilt: 59.440717697143555,
      tilt: 0.0,
      zoom: 14.151926040649414);
      
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 70.0,),
            Container(
              width: size.width,
              height: (size.height/10)*6.5,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _createMarkers(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: _goToTheLake,
                  label: Text('Centrar mapa'),
                  //icon: Icon(Icons.directions_boat),
                  backgroundColor: Colors.orange,
                  heroTag: "hero1",
                ),
                FloatingActionButton.extended(
                  onPressed:()=> _ultimasVisitas(context),
                  label: Text('Ultimas visitas'),
                  //icon: Icon(Icons.directions_boat),
                  backgroundColor: Colors.orange,
                  heroTag: "hero2",
                ),
              ],
            ),
            // SizedBox(height: 100.0,),
          ],
        ),
      ),
    );
  }

  Set<Marker> _createMarkers(){
    var tmp = Set<Marker>();
    tmp.add(Marker(
      markerId: MarkerId("idMarker1"),
      position: LatLng(-12.044836, -77.042067),

    ));

    tmp.add(Marker(
      markerId: MarkerId("idMarker1"),
      position: LatLng(-12.040016, -77.042944)
    ));

    tmp.add(Marker(
      markerId: MarkerId("idMarker1"),
      position: LatLng(-12.044801, -77.039589),
      infoWindow: InfoWindow(title: "Restaurante TITULO", snippet: "subdescripcion del restaurante")
    ));


    return tmp;
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  _ultimasVisitas(BuildContext context){
    Navigator.pushNamed(context, "/UltimasVisitasPage");
  }
}