import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapMarker {
  final String id;
  final Double latitude;
  final Double longitude;

  MapMarker(this.id, this.latitude, this.longitude);
  String getMarkerId();
  Double getMarkerLatitude();
  Double getMarkerLongitude();
}
