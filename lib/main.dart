import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/services.dart'; // لإغلا
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationChecker(),
    );
  }
}


class LocationChecker extends StatefulWidget {
  @override
  _LocationCheckerState createState() => _LocationCheckerState();
}

class _LocationCheckerState extends State<LocationChecker> {
  final double targetLatitude = 30.580996; // Latitude للشقة أو المكان
  final double targetLongitude = 31.4904367; // Longitude للشقة أو المكان
  final double allowedDistance = 5; // المسافة المسموح بها (بالمتر)

  late StreamSubscription<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    _startLocationCheck();
  }

  // تعريف الدالة مع void
  void _startLocationCheck() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position position) {
      double distance = Geolocator.distanceBetween(
        targetLatitude,
        targetLongitude,
        position.latitude,
        position.longitude,
      );

      print('Current Distance: $distance meters');

      if (distance > allowedDistance) {
        // إذا تعدى المسافة المسموحة
        _closeApp();
      }
    });
  }

  // تعريف الدالة مع void
  void _closeApp() {
    print("CLOSED APP =============================================");
    SystemNavigator.pop(); // لإغلاق التطبيق
  }

  @override
  void dispose() {
    _positionStream.cancel(); // إيقاف متابعة الموقع عند غلق الشاشة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Checker'),
      ),
      body: Center(
        child: Text('Checking your location...'),
      ),
    );
  }
}
