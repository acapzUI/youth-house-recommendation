import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:youth_house_recommendation/screenDetail.dart';
import 'package:youth_house_recommendation/screenFilter.dart';
import 'package:youth_house_recommendation/screenMap.dart';
import 'package:youth_house_recommendation/screenTitle.dart';


void main() async {
  await _initialize();
  runApp(const MyApp());
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
    clientId: '5w88jixbdb',
    onAuthFailed: (e) => log("naver map auth error: $e", name: "onAuthFailed")
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/t",
      routes: {
        "/t": (context) => screenTitle(),
        "/f": (context) => screenFilter(),
        "/m": (context) => screenMap(),
        "/d": (context) => screenDetail(),
      },
    );
  }
}


