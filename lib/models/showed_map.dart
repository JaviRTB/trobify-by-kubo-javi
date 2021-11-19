import 'package:flutter/cupertino.dart';
import 'package:trobify/models/map.dart';
import 'package:trobify/models/marker.dart';

class ShowedMap extends Map {
  ShowedMap({@required List<MapMarker> mapMarkers}) : super(mapMarkers);
  List<MapMarker> getMarkers() {
    return this.mapMarkers;
  }

  void addMarker(MapMarker marker) {
    this.mapMarkers.add(marker);
  }

  void deleteMarker(MapMarker marker) {
    if (this.mapMarkers.contains(marker)) {
      this.mapMarkers.remove(marker);
    }
  }

  List<MapMarker> getMapMarkers() {
    return this.mapMarkers;
  }
}
