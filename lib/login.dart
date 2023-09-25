import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:henil/home_screen.dart';
import 'package:henil/screen/main/main_screen.dart';

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double pad = 90;
    return Scaffold(
      backgroundColor: Colors.white,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset("assets/Images/grey.png"),
                  Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, pad * 0.25, 0, pad * 0.25)),
                      Image.asset("assets/Images/loginLady.png"),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(pad * 0.25)),
              Image.asset("assets/Images/loginRangoli.png"),
              // Padding(padding: EdgeInsets.all(pad*0.3)),
              Spacer(),

              const Text(
                "Expensify",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                ),
              ),

              const Text(
                "Take control of your money\nwherever you go",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 30,),
              // Padding(padding: EdgeInsets.all(pad*0.3)),
              SizedBox(
                width: 300,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.white)
                          )
                      )
                  ),
                  onPressed: () async {

                    if(FirebaseAuth.instance.currentUser != null){
                      GoogleSignIn().signOut();
                      FirebaseAuth.instance.signOut();
                    }

                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final GoogleSignIn googleSignIn = GoogleSignIn();
                    try {
                      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
                      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
                      final AuthCredential credential = GoogleAuthProvider.credential(
                        accessToken: googleSignInAuthentication.accessToken,
                        idToken: googleSignInAuthentication.idToken,
                      );
                      await auth.signInWithCredential(credential);

                      if(auth.currentUser != null){
                        // log(_auth.currentUser!.email!.toString());
                        // log(_auth.currentUser!.uid.toString());

                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => const MainScreen()),
                        );
                      }else{
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong.")));
                      }
                    } catch (e) {
                      print("ABC: $e");
                    }

                    // FirebaseAuth.instance.signOut();

                    // FirebaseAuth.instance.createUserWithEmailAndPassword(
                    //     email: "henilborda124@gmail.com", password: "123456789");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/Images/icons8-google-480.png",
                        // height: double.maxFinite,
                        height: 25,
                      ),
                      const Text(
                        "Sign in with Google",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),

            ]));
  }
}
