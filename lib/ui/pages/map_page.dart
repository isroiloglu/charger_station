import 'dart:developer';

import 'package:charge_me/core/const/colors.dart';
import 'package:charge_me/core/extensions.dart';
import 'package:charge_me/ui/widgets/station_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_maps_mapkit/mapkit.dart' as mapkt;
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart' as map;
import 'package:yandex_maps_mapkit/src/bindings/image/image_provider.dart'
    as image_provider;

import '../../core/listeners/map_tap_listener.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // late YandexMap. _mapController;
  mapkt.MapWindow? _mapWindow;
  PersistentBottomSheetController? controller;
  static final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _indexToPlacemarkType = <int, dynamic>{};

  mapkt.Point? _userLocation;
  final List<mapkt.Point> locations = [
    const mapkt.Point(latitude: 41.2995, longitude: 69.2401),
    const mapkt.Point(latitude: 41.3111, longitude: 69.2797),
    const mapkt.Point(latitude: 41.3265, longitude: 69.2285),
    const mapkt.Point(latitude: 41.3123, longitude: 69.2787),
    const mapkt.Point(latitude: 41.3270, longitude: 69.2820),
    const mapkt.Point(latitude: 41.2916, longitude: 69.2652),
    const mapkt.Point(latitude: 41.2825, longitude: 69.1390),
    const mapkt.Point(latitude: 41.3225, longitude: 69.3371),
    const mapkt.Point(latitude: 41.2974, longitude: 69.2106),
    const mapkt.Point(latitude: 41.3565, longitude: 69.2870),
    const mapkt.Point(latitude: 41.3243, longitude: 69.2998),
    const mapkt.Point(latitude: 41.3503, longitude: 69.3293),
    const mapkt.Point(latitude: 41.3260, longitude: 69.2378),
    const mapkt.Point(latitude: 41.3143, longitude: 69.2205),
    const mapkt.Point(latitude: 41.2833, longitude: 69.2010),
    const mapkt.Point(latitude: 41.2601, longitude: 69.1904),
    const mapkt.Point(latitude: 41.2998, longitude: 69.2409),
    const mapkt.Point(latitude: 41.3355, longitude: 69.3142),
    const mapkt.Point(latitude: 41.2730, longitude: 69.2773),
    const mapkt.Point(latitude: 41.3277, longitude: 69.2413),
  ];

  List<mapkt.MapObject> objects = [];
  bool _isMapkitActive = false;
  late final AppLifecycleListener _lifecycleListener;

  final imageProvider = image_provider.ImageProvider.fromImageProvider(
      const AssetImage('assets/images/marker.png'));
  final userImageProvider = image_provider.ImageProvider.fromImageProvider(
      const AssetImage('assets/images/user_marker.png'));

  @override
  void initState() {
    _startMapkit();
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        _startMapkit();
      },
      onInactive: () {
        _stopMapkit();
      },
    );
  }

  @override
  void dispose() {
    _stopMapkit();
    _lifecycleListener.dispose();
    super.dispose();
  }

  void _stopMapkit() {
    if (_isMapkitActive) {
      _isMapkitActive = false;
      mapkit.onStop();
    }
  }

  void _startMapkit() {
    if (!_isMapkitActive) {
      _isMapkitActive = true;
      mapkit.onStart();
    }
  }

  late final _placemarkTapListener = MapObjectTapListenerImpl(
    onMapObjectTapped: (mapObject, _) {
      final placemarkPoint =
          mapObject.castOrNull<mapkt.PlacemarkMapObject>()?.geometry;
      showBottomSheetDialog(context, StationDialog(index: 1));
      return true;
    },
  );

  @override
  Widget build(BuildContext context) {
    log('OBJECTS: $objects');
    return Scaffold(
      body: Stack(children: [
        map.YandexMap(
          // mapObjects: objects,

          onMapCreated: (controller) async {
            log('MAP CREATED');
            _mapWindow = controller;

            addUserLocation();
          },
        ),
        Positioned(
            bottom: 130,
            right: 16,
            child: button(() {
              _mapWindow?.map.move(mapkt.CameraPosition(_userLocation!,
                  zoom: 15.0, azimuth: 150.0, tilt: 30.0));
            }))
      ]),
    );
  }

  Future<void> _determinePosition() async {}

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

  void addUserLocation() async {
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
      _userLocation = mapkt.Point(
          latitude: position.latitude, longitude: position.longitude);
    });

    for (var p in locations) {
      _mapWindow?.map.mapObjects.addPlacemark()
        ?..geometry = mapkt.Point(latitude: p.latitude, longitude: p.longitude)
        ..setIcon(
          imageProvider,
        )
        ..setIconStyle(const mapkt.IconStyle(scale: 0.5))
        ..addTapListener(_placemarkTapListener);
    }

    if (_userLocation != null) {
      _mapWindow?.map.mapObjects.addPlacemark()
        ?..geometry = mapkt.Point(
            latitude: _userLocation!.latitude,
            longitude: _userLocation!.longitude)
        ..setIcon(
          userImageProvider,
        )
        ..setIconStyle(const mapkt.IconStyle(scale: 0.2));

      _mapWindow?.map.move(mapkt.CameraPosition(_userLocation!,
          zoom: 15.0, azimuth: 150.0, tilt: 30.0));
    }
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
