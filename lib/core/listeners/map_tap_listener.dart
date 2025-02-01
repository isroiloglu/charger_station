import 'dart:developer';

import 'package:yandex_maps_mapkit_lite/mapkit.dart';

final class StationTapListenerImpl implements MapObjectTapListener {
  final bool Function(MapObject, Point) onMapObjectTapped;

  const StationTapListenerImpl({required this.onMapObjectTapped});

  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {
    log('ONTAPPPP');
    return onMapObjectTapped(mapObject, point);
  }
}
