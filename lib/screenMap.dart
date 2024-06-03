import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter/services.dart';
import 'package:youth_house_recommendation/screenDetail.dart';

import 'Filters.dart';

class screenMap extends StatelessWidget {
  const screenMap({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    NLatLng loc;
    if (arguments['filters'].location == "쿠팡") {
      loc = NLatLng(37.515750, 127.099055);
    } else if (arguments['filters'].location == "한양대학교") {
      loc = NLatLng(37.557160, 127.045441);
    } else {
      loc = NLatLng(37.557160, 127.045441);
    }
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //final Completer<NaverMapController> mapControllerCompleter = Completer();
    BuildContext ctx = context;
    return MaterialApp(
        home: Scaffold (
          appBar: AppBar(
              backgroundColor: Colors.blue,
              shadowColor: Colors.black,
              title: Text(
                '청년 보금자리',
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
                            child: Products(ctx)
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
  const Products(this.ctx, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _Products(ctx);
  }
}

class _Products extends State<Products> {
  final BuildContext ctx;
  _Products(this.ctx);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> searchResults = [
      {"name": "오피스텔 A", "point": "6.23점", "location": "경기도 수원시 영통구 하동"},
      {"name": "아파트 B", "point": "6.23점", "location": "경기도 수원시 영통구 하동"},
      {"name": "빌라 C", "point": "6.23점", "location": "경기도 수원시 영통구 하동"},
      {"name": "원룸 D", "point": "6.23점", "location": "경기도 수원시 영통구 하동"},
      {"name": "아파트 E", "point": "6.23점", "location": "경기도 수원시 영통구 하동"},
      {"name": "원룸 D", "point": "6.23점", "location": "경기도 수원시 영통구 하동"},
      {"name": "아파트 E", "point": "6.23점", "location": "경기도 수원시 영통구 하동"},
      {"name": "원룸 D", "point": "6.23점", "location": "경기도 수원시 영통구 하동"},
      {"name": "아파트 E", "point": "6.23점", "location": "경기도 수원시 영통구 하동"},
    ];

    final searchResultsLength = searchResults.length;
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
                    final searchResultsItem = searchResults[searchResultsIndex];
                    final name = searchResultsItem['name'];
                    final point = searchResultsItem['point'];
                    final location = searchResultsItem['location'];

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
                            ctx, "/d"
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
                                  image: AssetImage('assets/5.jpg'),
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
                                          "$name",
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
                                          "$location",
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
