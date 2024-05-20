import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

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

    final Completer<NaverMapController> mapControllerCompleter = Completer();

    return MaterialApp(
        home: Scaffold (
          appBar: AppBar(
            title: Text('this is app')
          ),
          body: NaverMap(
            options: const NaverMapViewOptions(
              indoorEnable: true,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false
            ),
            onMapReady: (controller) async {
              mapControllerCompleter.complete(controller);
              log("onMapReady", name: "onMapReady");
            },
          ),
        )
    );
  }
}
