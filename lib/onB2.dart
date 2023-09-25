import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:henil/login.dart';

class onB2 extends StatelessWidget {
  const onB2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double pad = 22;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => login()),
              );
            },
            backgroundColor: const Color.fromARGB(255, 77, 85, 92),
            child: const Icon(Icons.arrow_right_alt),
          ),
        ),
      ),
      body: Container(

        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                 Image(
                   image: AssetImage("assets/Images/GreyBkg.png",),
                   width: MediaQuery.of(context).size.width,
                 ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(pad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, pad, 0, pad)),
                  Text(
                    "Track Budget Daily\nSave More!",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 37,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(1)),
                  Text("Expensify lets you take your money\non the go. Set your income and record\nyour expenses.",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                    ),),
                  Padding(padding: EdgeInsets.all(pad*3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.circle, color: Colors.grey),
                      Icon(Icons.circle),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
