import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:henil/onB2.dart';


class onB1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double pad = 15;


    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          width: 70,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => onB2()),
                );
              },
              backgroundColor: Color.fromARGB(255, 77, 85, 92),
              child: Icon(Icons.arrow_right_alt),
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image(
                      image: const AssetImage("assets/Images/33.png",),
                      width: MediaQuery.of(context).size.width,
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(pad),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.fromLTRB(0, pad, 0, pad)),
                      Padding(padding: EdgeInsets.all(pad)),
                      const Text(
                        "Every Spending\nCounts. Save it!",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 37,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(1)),
                      const Text("Expensify let's you track\nyour money on the go. Set your\nincome and record your expenses.",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 17,
                        ),),
                      Padding(padding: EdgeInsets.all(pad*4)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.circle),
                          Icon(Icons.circle, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }
}
