import 'dart:math';
// import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/controllers/home.controller.dart';
import 'package:real_estate_app/utils/constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  HomeController homeController = Get.find();
  late GoogleMapController mapController;
  final GlobalKey _markerKey = GlobalKey();

  final LatLng _center = const LatLng(-33.86, 151.20);

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _generateCustomMarker());

    // 🔁 Watch for changes and regenerate marker
    ever(homeController.isSimpleMarker, (_) {
      _generateCustomMarker(); // <- Regenerate marker when value changes
    });
  }

  List<LatLng> generateRandomNearbyPositions(
      LatLng center, int count, double maxDistanceInMeters) {
    final random = Random();
    final List<LatLng> positions = [];

    for (int i = 0; i < count; i++) {
      // Random angle and distance
      final angle = random.nextDouble() * 2 * pi;
      final distance = random.nextDouble() * maxDistanceInMeters;

      // Convert meters to degrees
      final deltaLat = (distance * cos(angle)) / 111320; // 1 deg ≈ 111.32 km
      final deltaLng =
          (distance * sin(angle)) / (111320 * cos(center.latitude * pi / 180));

      final newLat = center.latitude + deltaLat;
      final newLng = center.longitude + deltaLng;

      positions.add(LatLng(newLat, newLng));
    }

    return positions;
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/styles/map_style_dark.json');
    mapController.setMapStyle(style);

    print("Map created!");
  }

  final List<LatLng> staticPositions = [
    LatLng(-33.86, 151.200), // Point 1
    LatLng(-33.86, 151.2038), // Point 2
    LatLng(-33.863, 151.2028), // Point 3
    LatLng(-33.858, 151.2012), // Point 4
    LatLng(-33.855, 151.202), // Point 5
    LatLng(-33.857, 151.199), // Point 6
  ];

  Future<void> _generateCustomMarker() async {
    try {
      // Wait until next frame is fully drawn
      // await Future.delayed(Duration(milliseconds: 50));
      // await SchedulerBinding.instance.endOfFrame;
      await Future.delayed(const Duration(milliseconds: 100));
      await WidgetsBinding.instance.endOfFrame;
      await Future.delayed(
          const Duration(milliseconds: 50)); // Give extra buffer

      RenderRepaintBoundary boundary = _markerKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      if (boundary.debugNeedsPaint) {
        await Future.delayed(Duration(milliseconds: 50));
        await SchedulerBinding.instance.endOfFrame;
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final bitmap = BitmapDescriptor.fromBytes(pngBytes);

      // final positions = generateRandomNearbyPositions(
      //     _center, 6, 500); // 6 markers, up to 500 meters away

      final positions = staticPositions;

      setState(() {
        _markers.clear();
        for (int i = 0; i < positions.length; i++) {
          _markers.add(
            Marker(
              markerId: MarkerId('customMarker_$i'),
              position: positions[i],
              icon: bitmap,
            ),
          );
        }
      });
    } catch (e) {
      print("Error generating custom marker: $e");
    }
  }

  Widget _buildMarkerWidget() {
    return Obx(() {
      return homeController.isSimpleMarker.value
          ? Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.apartment,
                color: Colors.white,
                size: 28,
              ),
            )
          : Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('13,3 mnP')),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16.0,
          ),
          markers: _markers,
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          mapToolbarEnabled: false,
        ),
        // Invisible widget to render the custom marker for capture
        Positioned(
          left: -9999, // Offscreen but still rendered
          top: -9999,
          child: RepaintBoundary(
            key: _markerKey,
            child: _buildMarkerWidget(),
          ),
        ),
        // Opacity(
        //   opacity: 0.0,
        //   child: RepaintBoundary(
        //     key: _markerKey,
        //     child: _buildMarkerWidget(),
        //   ),
        // )
      ],
    );
  }
}
