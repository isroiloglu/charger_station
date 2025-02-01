import 'dart:developer';

import 'package:charge_me/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_maps_mapkit_lite/mapkit.dart' as mapkit;
import 'package:yandex_maps_mapkit_lite/yandex_map.dart' as map;
import 'package:yandex_maps_mapkit_lite/src/bindings/image/image_provider.dart'
    as image_provider;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // late YandexMap. _mapController;
  mapkit.MapWindow? _mapWindow;
  PersistentBottomSheetController? controller;
  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  mapkit.Point? _userLocation;
  final List<mapkit.Point> locations = [
    const mapkit.Point(latitude: 41.2995, longitude: 69.2401),
    const mapkit.Point(latitude: 41.3111, longitude: 69.2797),
    const mapkit.Point(latitude: 41.3265, longitude: 69.2285),
    const mapkit.Point(latitude: 41.3123, longitude: 69.2787),
    const mapkit.Point(latitude: 41.3270, longitude: 69.2820),
    const mapkit.Point(latitude: 41.2916, longitude: 69.2652),
    const mapkit.Point(latitude: 41.2825, longitude: 69.1390),
    const mapkit.Point(latitude: 41.3225, longitude: 69.3371),
    const mapkit.Point(latitude: 41.2974, longitude: 69.2106),
    const mapkit.Point(latitude: 41.3565, longitude: 69.2870),
    const mapkit.Point(latitude: 41.3243, longitude: 69.2998),
    const mapkit.Point(latitude: 41.3503, longitude: 69.3293),
    const mapkit.Point(latitude: 41.3260, longitude: 69.2378),
    const mapkit.Point(latitude: 41.3143, longitude: 69.2205),
    const mapkit.Point(latitude: 41.2833, longitude: 69.2010),
    const mapkit.Point(latitude: 41.2601, longitude: 69.1904),
    const mapkit.Point(latitude: 41.2998, longitude: 69.2409),
    const mapkit.Point(latitude: 41.3355, longitude: 69.3142),
    const mapkit.Point(latitude: 41.2730, longitude: 69.2773),
    const mapkit.Point(latitude: 41.3277, longitude: 69.2413),
  ];

  List<mapkit.MapObject> objects = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _determinePosition();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('OBJECTS: $objects');
    return Scaffold(
      body: Stack(children: [
        map.YandexMap(
          // mapObjects: objects,
          onMapCreated: (controller) {
            log('MAP CREATED');
            // _mapController = controller;

            // _mapController.moveCamera(CameraUpdate.newCameraPosition(
            //     CameraPosition(target: locations[0], zoom: 5)));
          },
        ),
        Positioned(
            bottom: 130,
            right: 16,
            child: button(() {
              _mapWindow?.map.move(mapkit.CameraPosition(_userLocation!,
                  zoom: 17.0, azimuth: 150.0, tilt: 30.0));
              // _mapController.moveCamera(CameraUpdate.newCameraPosition(
              //     CameraPosition(target: _userLocation!, zoom: 14)));
            }))
      ]),
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = mapkit.Point(
          latitude: position.latitude, longitude: position.longitude);
    });
    final imageProvider = image_provider.ImageProvider.fromImageProvider(
        AssetImage('assets/images/marker.png'));
    final userImageProvider = image_provider.ImageProvider.fromImageProvider(
        AssetImage('assets/images/user_marker.png'));
    final placemark = _mapWindow?.map.mapObjects.addPlacemark()

      ?..geometry = const mapkit.Point(latitude: 55.751225, longitude: 37.62954)
      ..setIcon(imageProvider);
    _mapWindow?.map.mapObjects.addPlacemarks(
        imageProvider, mapkit.IconStyle(scale: 0.5),
        points: locations);
    _mapWindow?.map.mapObjects.addPlacemark()
      ?..geometry = mapkit.Point(
          latitude: _userLocation!.latitude,
          longitude: _userLocation!.longitude)
      
      ..setIcon(userImageProvider);
    _mapWindow?.map.move(mapkit.CameraPosition(_userLocation!,
        zoom: 17.0, azimuth: 150.0, tilt: 30.0));
  }

  Widget button(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Image.asset(
          'assets/icons/params.png',
          height: 24,
          width: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}

void showBottomSheetDialog(
  BuildContext context,
  Widget dialog,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return dialog;
    },
  );
}
