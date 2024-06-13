

import 'package:flutter/material.dart';
import 'package:youth_house_recommendation/Filters.dart';
import 'package:youth_house_recommendation/screenMap.dart';

class screenFilter extends StatelessWidget {
  const screenFilter({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
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
        body: SingleChildScrollView(
          child: Checklists(context),
        )
      )
    );
  }
}

class Checklists extends StatefulWidget {
  final BuildContext ctx;
  const Checklists(this.ctx, {super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _Checklists(ctx);
  }
}

class _Checklists extends State<Checklists> {
  final BuildContext ctx;
  _Checklists(this.ctx);

  List<String> locations = [
    "한양대학교",
  ];
  late String? locationValue = locations.first;
  double price = 5000;
  double time = 30;
  Map<String, bool> outdoorFacility = {
    "subway": false,
    "bus": false,
    "conv-store": false,
    "mart": false,
    "hospital": false,
    "pharmacy": false,
    "park": false,
    "public": false,
    "culture": false,
    "restaurant": false,
    "cafe": false
  };
  Map<String, bool> indoorFacility = {
    "air": false,
    "refrigerator": false,
    "stove": false,
    "sink": false,
    "washer": false,
    "dryer": false,
    "desk": false,
    "bed": false,
    "closet": false,
    "shoes": false,
    "induction": false,
    "waves": false
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 10,),
        Text(
          "위치",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton(
          value: locationValue,
          items: locations.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              locationValue = value;
            });
          },
        ),
        Text(
          "가격",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          value: price,
          min: 5000,
          max: 50000,
          divisions: 45,
          label: "${price~/10000}억 ${((price%10000).toInt())~/1000}천만원",
          onChanged: (double value) => setState(() { price=value; }),
        ),
        Text(
          "통근 시간",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          value: time,
          min: 30,
          max: 240,
          divisions: 21,
          label: "${time~/60}시간 ${(time%60).toInt()}분",
          onChanged: (double value) => setState(() { time=value; }),
        ),
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
                    outdoorFacility['subway'] = val ?? true;
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
                    outdoorFacility['bus'] = val ?? true;
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
                    outdoorFacility['conv-store'] = val ?? true;
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
                    outdoorFacility['mart'] = val ?? true;
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
                    outdoorFacility['hospital'] = val ?? true;
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
                    outdoorFacility['pharmacy'] = val ?? true;
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
                    outdoorFacility['park'] = val ?? true;
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
                    outdoorFacility['public'] = val ?? true;
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
                    outdoorFacility['culture'] = val ?? true;
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
                    outdoorFacility['restaurant'] = val ?? true;
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
                    outdoorFacility['cafe'] = val ?? true;
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
                    indoorFacility['air'] = val ?? true;
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
                    indoorFacility['refrigerator'] = val ?? true;
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
                    indoorFacility['stove'] = val ?? true;
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
                title: Text("싱크대"),
                activeColor: Colors.deepOrangeAccent,
                checkColor: Colors.black,
                value: indoorFacility['sink'],
                onChanged: (bool? val) {
                  setState(() {
                    indoorFacility['sink'] = val ?? true;
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
                    indoorFacility['washer'] = val ?? true;
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
                    indoorFacility['dryer'] = val ?? true;
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
                    indoorFacility['desk'] = val ?? true;
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
                    indoorFacility['bed'] = val ?? true;
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
                    indoorFacility['closet'] = val ?? true;
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
                title: Text("신발장"),
                activeColor: Colors.deepOrangeAccent,
                checkColor: Colors.black,
                value: indoorFacility['shoes'],
                onChanged: (bool? val) {
                  setState(() {
                    indoorFacility['shoes'] = val ?? true;
                  });
                },
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                title: Text("인덕션"),
                activeColor: Colors.deepOrangeAccent,
                checkColor: Colors.black,
                value: indoorFacility['induction'],
                onChanged: (bool? val) {
                  setState(() {
                    indoorFacility['induction'] = val ?? true;
                  });
                },
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                title: Text("전자레인지"),
                activeColor: Colors.deepOrangeAccent,
                checkColor: Colors.black,
                value: indoorFacility['waves'],
                onChanged: (bool? val) {
                  setState(() {
                    indoorFacility['waves'] = val ?? true;
                  });
                },
              ),
            )
          ],
        ),
        Container(height: 20,),
        Container(
          width: 400,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () async {
              Navigator.pushNamed(
                ctx, '/m',
                arguments:{
                  "filters" : Filters(locationValue!, price, time, outdoorFacility, indoorFacility)
                }
              );
            },
            child: Text("NEXT", style: TextStyle(color: Colors.white),),
          )
        ),
      ],
    );
  }
}