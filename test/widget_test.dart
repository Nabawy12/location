import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatelessWidget {
  Future<void> _getCurrentLocation() async { // Corrected here
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _getCurrentLocation,
          child: Text('Get Current Location'),
        ),
      ),
    );
  }
}

// Your Color OF Company
/*
I/flutter (30351): Latitude: 30.580996, Longitude: 31.4904367
*/

