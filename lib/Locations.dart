
import 'dart:ffi';

import 'package:flutter_naver_map/flutter_naver_map.dart';

class Locations {
  final NLatLng targetLocation;
  //final String targetLocationName;
  final String targetLocationAdress;
  final NLatLng maintargetLocation;
  final String maintargetLocationName;
  final int picIndex;
  final int picCounts;
  final String price;
  final double point;
  final Map<String, bool> outdoorFacility;
  final Map<String, bool> indoorFacility;

  const Locations(this.targetLocation, /*this.targetLocationName,*/ this.targetLocationAdress, this.maintargetLocation, this.maintargetLocationName, this.picIndex, this.picCounts, this.price, this.point, this.outdoorFacility, this.indoorFacility);
}