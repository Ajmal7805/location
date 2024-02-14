import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location_screen extends StatefulWidget {
  const Location_screen({super.key});

  @override
  State<Location_screen> createState() => _Location_screenState();
}

class _Location_screenState extends State<Location_screen> {
  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: TextButton(
            onPressed: () {
              getLocation();
            },
            child: Text("Get location")),
      ),
    );
  }
}
