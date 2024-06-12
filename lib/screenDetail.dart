

import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'Locations.dart';

class screenDetail extends StatelessWidget {
  screenDetail({Key? key}) : super(key: key);

  List<AssetImage> imgs = [];


  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    Locations loc = arguments['locations'];

    for (int i=1; i<=loc.picCounts; i++) {
      imgs.add(
        AssetImage("assets/p"+loc.picIndex.toString()+"-"+i.toString()+".png")
      );
    }
    
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                '청년 보금자리 - 둥지',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
          ),
        body: Expanded(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 10,),
                Container(
                  height: 200,
                  child: Swiper(
                    viewportFraction: 0.8, // 전체 슬라이드 아이템 크기
                    scale: 0.9, // 활성화 슬라이드 아이템 크기
                    scrollDirection: Axis.horizontal, // 슬라이드 방향
                    axisDirection: AxisDirection.left, // 정렬
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter, // 페이지네이션 위치
                      builder: SwiperPagination.rect, // 세 가지 스타일의 pagination 사용 가능
                    ), // 페이지네이션
                    loop: true,// 반복
                    autoplay: true,// 자동 슬라이드
                    duration: 300,// 속도
                    itemCount: loc.picCounts,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        child: Column(
                          children: [
                            Image(
                              image: imgs[index],
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(height: 10,),
                Container(
                  height: 300,
                  child: NaverMap(
                    options: NaverMapViewOptions(
                      indoorEnable: true,
                      locationButtonEnable: false,
                      consumeSymbolTapEvents: false,
                      initialCameraPosition: NCameraPosition(
                        target: NLatLng(loc.targetLocation.latitude, loc.targetLocation.longitude+0.00125),
                        zoom: 15,
                      ),
                    ),
                    onMapReady: (controller) async {

                      //mapControllerCompleter.complete(controller);
                      final marker1 = NCircleOverlay(
                        id: "var",
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        center: loc.maintargetLocation,
                        radius: 500,
                      );

                      final marker2 = NMarker(
                          id: "pos",
                          position: loc.maintargetLocation
                      );
                      final marker3 = NMarker(
                          id: "pos2",
                          position: loc.targetLocation
                      );


                      controller.addOverlay(marker1);
                      controller.addOverlay(marker2);
                      controller.addOverlay(marker3);
                      final onMarkerInfoWindow = NInfoWindow.onMarker(
                          id: "pos",
                          text: loc.maintargetLocationName
                      );
                      marker2.openInfoWindow(onMarkerInfoWindow);
                      final onMarkerInfoWindow2 = NInfoWindow.onMarker(
                          id: "pos2",
                          text: loc.targetLocationAdress
                      );
                      marker3.openInfoWindow(onMarkerInfoWindow2);

                      log("onMapReady", name: "onMapReady");
                    },
                  ),
                ),
                Container(height: 10,),
                Text(
                    loc.targetLocationAdress,
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    )
                ),
                Text(
                    "가격: " + loc.price,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                    )
                ),
                Image.asset("assets/star5.png", width: 200,),
                Image.asset("assets/time.png"),
                Checklists_Detail(context, loc.outdoorFacility, loc.indoorFacility)
              ],
            ),
          ),
        )
      )
    );
  }
}

class Checklists_Detail extends StatefulWidget {
  final BuildContext ctx;
  final Map<String, bool> outdoorFacility;
  final Map<String, bool> indoorFacility;
  const Checklists_Detail(this.ctx, this.outdoorFacility, this.indoorFacility, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _Checklists_Detail(ctx, this.outdoorFacility, this.indoorFacility);
  }
}

class _Checklists_Detail extends State<Checklists_Detail> {
  final BuildContext ctx;
  final Map<String, bool> outdoorFacility;
  final Map<String, bool> indoorFacility;
  _Checklists_Detail(this.ctx ,this.outdoorFacility, this.indoorFacility);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(
            "주변 시설",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text("지하철"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['subway'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("버스\n정류장"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['bus'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("편의점"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['conv-store'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text("대형\n마트"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['mart'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("병원"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['hospital'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("약국"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['pharmacy'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text("공원"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['park'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("공공\n시설"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['public'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("문화\n시설"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['culture'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text("음식점"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['restaurant'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("카페"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: outdoorFacility['cafe'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(child: Container())
            ],
          ),
          Text(
            "내부 옵션",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text("에어컨"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: indoorFacility['air'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("냉장고"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: indoorFacility['refrigerator'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("레인지"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: indoorFacility['stove'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text("WIFI"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: indoorFacility['wifi'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("세탁기"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: indoorFacility['washer'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("건조기"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: indoorFacility['dryer'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text("책상"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: indoorFacility['desk'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("침대"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: indoorFacility['bed'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text("옷장"),
                  activeColor: Colors.deepOrangeAccent,
                  checkColor: Colors.black,
                  value: indoorFacility['closet'],
                  onChanged: (bool? val) {
                    setState(() {
                    });
                  },
                ),
              )
            ],
          ),
        ]
    );
  }
}