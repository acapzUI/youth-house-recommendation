

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
                '청년 보금자리',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
          ),
          body: Center(
            child: Column(
              children: [
                Container(height: 180,),
                Center(
                    child: Image(width:300, image: AssetImage('assets/logo2.png')),
                ),
                Container(height: 20,),
                Center(
                  child: Container(
                    width: 400,
                    child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pushNamed(
                            context,
                            "/f",
                          );
                        },
                        child: Text("시작하기")
                    ),
                  ),
                )
              ],
            )
          )
        )
    );
  }
}

