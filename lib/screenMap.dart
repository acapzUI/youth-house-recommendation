import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter/services.dart';

import 'Filters.dart';
import 'Locations.dart';

class screenMap extends StatelessWidget {
  screenMap({Key? key}) : super(key: key);

  List<NLatLng> locations = [
    NLatLng(37.5568961252672, 127.041607745077),
    NLatLng(37.5567129920758 ,127.042508405187),
    NLatLng(37.5565009541884, 127.041589643716),
    NLatLng(37.5566041846132, 127.041657379798),
    NLatLng(37.5566041846132, 127.041657379798),
    NLatLng(37.5564984012924, 127.041929506644),
    NLatLng(37.5562860573636, 127.041869857816),
    NLatLng(37.5564502427838, 127.041032455657),
    NLatLng(37.5562459729189, 127.041586785817),
    NLatLng(37.5565375066403, 127.041155411556),
  ];

  List<NCircleOverlay> locationCircles = [];
  List<NMarker> locationMarkers = [];


  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    NLatLng loc = NLatLng(37.557160, 127.045441);

    for(int i=0;i<10;i++) {
      locationCircles.add(NCircleOverlay(id: i.toString() + "c", color: Colors.red, radius: 15, center: locations[i]));
    }
    for(int i=0;i<10;i++) {
      locationMarkers.add(NMarker(id: i.toString() + "m", position: locations[i]));
    }

    // if (arguments['filters'].location == "쿠팡") {
    //   loc = NLatLng(37.515750, 127.099055);
    // } else if (arguments['filters'].location == "한양대학교") {
    //   loc = NLatLng(37.557160, 127.045441);
    // } else {
    //   loc = NLatLng(37.557160, 127.045441);
    // }

    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //final Completer<NaverMapController> mapControllerCompleter = Completer();
    BuildContext ctx = context;
    return MaterialApp(
        home: Scaffold (
          appBar: AppBar(
              backgroundColor: Colors.blue,
              shadowColor: Colors.black,
              title: Text(
                '청년 보금자리 - 둥지',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
          ),
          body: Stack(
              children: [
                NaverMap(
                  options: NaverMapViewOptions(
                      indoorEnable: true,
                      locationButtonEnable: false,
                      consumeSymbolTapEvents: false,
                      initialCameraPosition: NCameraPosition(
                        target: NLatLng(loc.latitude-0.0025, loc.longitude),
                        zoom: 15,
                      ),
                  ),
                  onMapReady: (controller) async {


                    //mapControllerCompleter.complete(controller);
                    final marker1 = NCircleOverlay(
                        id: "var",
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        center: loc,
                        radius: 500,
                    );

                    final marker2 = NMarker(
                        id: "pos",
                        position: loc
                    );

                    controller.addOverlay(marker1);
                    controller.addOverlay(marker2);
                    locationCircles.forEach((lc) {
                      controller.addOverlay(lc);
                    });
                    locationMarkers.forEach((lm) {
                      controller.addOverlay(lm);
                    });

                    final onMarkerInfoWindow = NInfoWindow.onMarker(
                        id: "pos",
                        text: arguments['filters'].location
                    );
                    marker2.openInfoWindow(onMarkerInfoWindow);

                    log("onMapReady", name: "onMapReady");
                  },
                ),
                DraggableScrollableSheet(
                    initialChildSize: 0.4,
                    minChildSize: 0.4,
                    maxChildSize: 1.0,
                    snap: true,
                    builder: (BuildContext context, ScrollController scrollcontroller) {
                      return SingleChildScrollView(
                        controller: scrollcontroller,
                        child: Container(
                            height: 1500,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.grey),
                            child: Products(ctx, locations)
                        ),
                      );
                    }
                )
              ]
          ),
        )
    );
  }
}

class Products extends StatefulWidget {
  final BuildContext ctx;
  final List<NLatLng> locs;
  const Products(this.ctx, this.locs, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _Products(ctx, locs);
  }
}

class _Products extends State<Products> {
  final BuildContext ctx;
  final List<NLatLng> searchResultLocations;
  _Products(this.ctx, this.searchResultLocations);

  List<String> searchResultAddress = [
    "서울시 성동구 행당동 37-34",
    "서울시 성동구 행당동 32-31",
    "서울시 성동구 행당동 37-92",
    "서울시 성동구 행당동 37-78",
    "서울시 성동구 행당동 37-78",
    "서울시 성동구 행당동 37-73",
    "서울시 성동구 행당동 70-18",
    "서울시 성동구 행당동 39-1",
    "서울시 성동구 행당동 70-23",
    "서울시 성동구 행당동 37-99"
  ];
  List<AssetImage> searchResultImages = [];
  List<int> searchResultImageCounts = [
    7, 5, 3, 5, 6, 5, 4, 5, 5, 5
  ];
  List<double> searchResultPoints = [
    15.6, 15.5, 15.2, 15.2, 15.2, 15.2, 15.2, 15.2, 15.2, 15.2
  ];
  List<String> searchResultPrices = [
    "5000/45",
    "4000/40",
    "2000/50",
    "1000/55",
    "500/55",
    "1000/55",
    "5000/55",
    "5000/60",
    "6000/50",
    "500/56"
  ];
  List<double> searchResultcPrices = [
    14381.818,
    12727.273,
    14000,
    13000,
    12500,
    13000,
    17000,
    18090.909,
    16909.091,
    12718.182,
  ];
  List<Map<String, bool>> outdoorFacilities = [
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
    {
      "subway": true,
      "bus": true,
      "conv-store": true,
      "mart": true,
      "hospital": true,
      "pharmacy": true,
      "park": true,
      "public": true,
      "culture": true,
      "restaurant": true,
      "cafe": true
    },
  ];
  List<Map<String, bool>> indoorFacilities = [
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": false,
      "bed": true,
      "closet": true
    },
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": true,
      "bed": true,
      "closet": true
    },
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": true,
      "bed": true,
      "closet": true
    },
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": true,
      "bed": true,
      "closet": true
    },
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": true,
      "bed": true,
      "closet": true
    },
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": true,
      "bed": true,
      "closet": true
    },
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": true,
      "bed": true,
      "closet": true
    },
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": true,
      "bed": true,
      "closet": true
    },
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": true,
      "bed": true,
      "closet": true
    },
    {
      "air": true,
      "refrigerator": true,
      "stove": true,
      "wifi": false,
      "washer": true,
      "dryer": false,
      "desk": true,
      "bed": true,
      "closet": true
    },
  ];

  @override
  Widget build(BuildContext context) {

    final searchResultsLength = 10;
    for(int i=1;i<=10;i++) {
      searchResultImages.add(AssetImage('assets/p' + i.toString() + '-1.png'));
    }
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          shadowColor: Colors.black,
          title: Text(
            '매물 $searchResultsLength건',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Expanded(
          child: Builder(
            builder: (context) {
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: searchResultsLength,
                  itemBuilder: (context, searchResultsIndex) {
                    final address = searchResultAddress[searchResultsIndex];
                    final point = searchResultPoints[searchResultsIndex];
                    final price = searchResultPrices[searchResultsIndex];
                    final pic = searchResultImages[searchResultsIndex];
                    return Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          Navigator.pushNamed(
                            ctx, "/d",
                            arguments:{
                              "locations": Locations(
                                searchResultLocations[searchResultsIndex],
                                searchResultAddress[searchResultsIndex],
                                NLatLng(37.557160, 127.045441),
                                "한양대학교",
                                searchResultsIndex+1,
                                searchResultImageCounts[searchResultsIndex],
                                searchResultPrices[searchResultsIndex],
                                searchResultPoints[searchResultsIndex],
                                outdoorFacilities[searchResultsIndex],
                                indoorFacilities[searchResultsIndex]
                              )
                            }
                          );
                        },
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image(
                                  image: pic,
                                  width: 80,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "$address",
                                          style: TextStyle(
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 3),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 6, 0),
                                            child: Text(
                                              "$point",
                                              style: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "$price",
                                          style: TextStyle(
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                              ],
                            )
                          )
                        )
                      ),
                    );
                  }
              );
            },
          ),
        )
    );
  }
}
