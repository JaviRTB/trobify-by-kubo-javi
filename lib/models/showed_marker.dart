import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trobify/models/marker.dart';
import 'package:flutter/foundation.dart';

class ShowedMapMarker extends MapMarker {
  ShowedMapMarker(
      {@required String id,
      @required Double latitude,
      @required Double longitude})
      : super(id, latitude, longitude);

  String getMarkerId() {
    return this.id;
  }

  Double getMarkerLatitude() {
    return this.latitude;
  }

  Double getMarkerLongitude() {
    return this.longitude;
  }
}
