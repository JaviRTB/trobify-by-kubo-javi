import '../models/property_type.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';

class Property {
  final String id;
  final String title;
  final String location;
  final String description;
  final int area;
  final int nRooms;
  final int nBaths;
  final int height;
  final int yearBuilt;
  final List<String> images;
  final bool parking;
  final bool furnished;
  final bool elevator;
  final PropertyType type;
  final LatLng position;
  final String publisherId;

  const Property({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.description,
    @required this.area,
    this.nRooms,
    this.nBaths,
    this.height,
    @required this.yearBuilt,
    @required this.images,
    this.parking,
    this.furnished,
    this.elevator,
    @required this.type,
    this.position,
    this.publisherId,
  });
}
