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
    );
  }
}
