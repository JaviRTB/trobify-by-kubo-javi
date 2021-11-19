import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  State<MapView> createState() => MapSampleState();
}

class MapSampleState extends State<MapView> {
  GoogleMapController _controller;

  static final CameraPosition vlcLocation = CameraPosition(
    target: LatLng(39.4702, -0.376805),
    zoom: 12,
  );

  void onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/maps/map_style.json');
    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> _markers = Set();
    final Marker marker0 = Marker(
      markerId: MarkerId('example'),
      position: LatLng(39.4714, -0.376815),
      onTap: null,
    );
    final Marker marker1 = Marker(
      markerId: MarkerId('example'),
      position: LatLng(39.4906, -0.376805),
      onTap: null,
    );
    final Marker marker2 = Marker(
      markerId: MarkerId('example'),
      position: LatLng(39.4850, -0.336430),
      onTap: null,
    );
    final Marker marker3 = Marker(
      markerId: MarkerId('example'),
      position: LatLng(39.4680, -0.336810),
      onTap: null,
    );
    final Marker marker4 = Marker(
      markerId: MarkerId('example'),
      position: LatLng(39.4730, -0.336536),
      onTap: null,
    );
    setState(() {
      _markers.add(marker0);
      _markers.add(marker1);
      _markers.add(marker2);
      _markers.add(marker3);
      _markers.add(marker4);
    });
    return new Scaffold(
      body: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: vlcLocation,
          onMapCreated: onMapCreated,
          markers:
              Set<Marker>.of(_markers) //aqui van los marcadores de los pisos
          ),
    );
  }
}
