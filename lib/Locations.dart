
import 'dart:ffi';

import 'package:flutter_naver_map/flutter_naver_map.dart';

class Locations {
  final NLatLng targetLocation;
  final String targetLocationName;
  final String targetLocationAdress;
  final NLatLng maintargetLocation;
  final String maintargetLocationName;

  const Locations(this.targetLocation, this.targetLocationName, this.targetLocationAdress, this.maintargetLocation, this.maintargetLocationName);
}