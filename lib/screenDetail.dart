

import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class screenDetail extends StatelessWidget {
  const screenDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text(
                '청년 보금자리',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
          ),
        body: Column(
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
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    child: Column(
                      children: const [
                        Image(
                          image: AssetImage('assets/1.jpeg'),
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
                options: const NaverMapViewOptions(
                    indoorEnable: true,
                    locationButtonEnable: false,
                    consumeSymbolTapEvents: false
                ),
                onMapReady: (controller) async {
                  //mapControllerCompleter.complete(controller);
                  log("onMapReady", name: "onMapReady");
                },
              ),
            ),
            Container(height: 10,),
            Text(
                "경기도 수원시 영통구 하동",
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                )
            ),
          ],
        )
      )
    );
  }
}