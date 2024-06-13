

import 'package:flutter/material.dart';

class screenTitle extends StatelessWidget {
  const screenTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
          body: Container(
            color: Colors.blue,
            child: Column(
              children: [
                Container(height: 180,),
                Center(
                    child: Image(width:300, image: AssetImage('assets/logo3.png')),
                ),
                Container(height: 50,),
                Center(
                  child: Container(
                    width: 300,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            "/f",
                          );
                        },
                        child: Text("시작하기", style: TextStyle(color: Colors.blue),)
                    ),
                  ),
                ),
              ],
            )
          )
        )
    );
  }
}

