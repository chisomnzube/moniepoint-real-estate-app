import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-33.86, 151.20);

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("Sydney"),
      position: LatLng(-33.86, 151.20),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    print("Map created!");
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      print("Location permission granted");
    } else if (status.isDenied) {
      print("Location permission denied");
    } else if (status.isPermanentlyDenied) {
      // You can prompt the user to open app settings
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
