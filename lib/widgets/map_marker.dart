import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker extends StatelessWidget {
  final Marker marker = Marker(
    markerId: null,
    position: null,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MapMarker(),
    );
  }
}
