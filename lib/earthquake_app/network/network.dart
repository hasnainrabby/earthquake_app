import 'dart:convert';

import 'package:http/http.dart';

import '../model/quake_model.dart';

class Network{
  Future<QuakeModel> getAllQuakes() async{
    var apiUrl = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson";

    final response = await get(Uri.parse(Uri.encodeFull(apiUrl)));

    if (response.statusCode == 200){
      print("Quake Data: ${response.body}");
      return QuakeModel.fromJson(json.decode(response.body));
    }else{
      throw Exception("Error getting Quakes.");
    }
  }
}