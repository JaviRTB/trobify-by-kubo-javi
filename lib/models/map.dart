import 'package:trobify/models/marker.dart';

abstract class Map {
  List<MapMarker> mapMarkers;
  List<MapMarker> getMarkers();
  void addMarker(MapMarker marker);
  void deleteMarker(MapMarker marker);
  List<MapMarker> getMapMarkers();
  Map(this.mapMarkers);
}
