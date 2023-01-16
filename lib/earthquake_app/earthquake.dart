import 'dart:async';

import 'package:earthquake_app/earthquake_app/network/network.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

import 'model/quake_model.dart';

class EarthquakeApp extends StatefulWidget {
  const EarthquakeApp({Key? key}) : super(key: key);

  @override
  State<EarthquakeApp> createState() => _EarthquakeAppState();
}

class _EarthquakeAppState extends State<EarthquakeApp> {
  late Future<QuakeModel> _quakeData;
  Completer<GoogleMapController> _controller = Completer();
  final List<Marker>_markerList = <Marker>[];
  @override
  void initState() {

    super.initState();
    _quakeData = Network().getAllQuakes();
    _quakeData.then((values) => {
      print("Place: ${values.features![0].properties!.place}")
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Earthquake"),
      ),
      body: Stack(
        children: [
          _buildGoogleMap(context)
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            findQuakes();
          },
          label: Text("Find Quakes")),
    );
  }

 Widget _buildGoogleMap(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
             onMapCreated: (GoogleMapController controller){
               _controller.complete(controller);
             },
        initialCameraPosition: CameraPosition(target: LatLng(23.816591317488747, 90.41560944927275),zoom: 3),
        markers: Set<Marker>.of(_markerList),

      ),
    );
 }

  void findQuakes() {
     setState(() {
       _markerList.clear(); //clear the map in the beginning
       _hendelResponse();
     });
  }

  void _hendelResponse() {
   _quakeData.then((quakes) => {
     quakes.features?.forEach((quake) {
       _markerList.add(Marker(markerId: MarkerId(quake.id.toString()),
       infoWindow: InfoWindow(title: quake.properties?.mag.toString(),snippet: quake.properties!.title),
       position: LatLng(quake.geometry!.coordinates![1], quake.geometry!.coordinates![0]),
         icon: BitmapDescriptor.defaultMarker,
         onTap: (){

         }
       ));
     })
   });
  }
  }

