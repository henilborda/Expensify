import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => {Navigator.pop(context)},
        //   child: const Icon(Icons.arrow_back_ios_new),
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Settings",
                  textScaleFactor: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9, //This line says to make the box 80% of device's width
                  height: MediaQuery.of(context).size.width * 0.2 ,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4e5a5d),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset("assets/Images/img.png",height: 50,width: 50, fit: BoxFit.cover,),
                            ),
                            const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("Henil Borda", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),),
                                Text("henil.borda@gmail.com", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () async {
                            if(GoogleSignIn().currentUser != null){
                              await GoogleSignIn().signOut();
                              await FirebaseAuth.instance.signOut();
                            }
                            Navigator.pushAndRemoveUntil(
                                context,CupertinoPageRoute(builder: (context) => login()), (Route<dynamic> route) => false
                            );
                          },
                          icon: const Icon(Icons.power_settings_new, color: Colors.white,),
                        )

                      ]
                  ),
                ),
                SizedBox(height: 30,),

                Column(
                  children: [
                    ButtonTheme(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.contrast_outlined),
                                SizedBox(width: 10,),
                                Text("Theme", style: TextStyle(fontSize: 18),),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 5),)
                              ],
                            ),
                            const Icon(CupertinoIcons.right_chevron),
                          ],
                        ),
                      ),),
                    ButtonTheme(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                children: const [
                                  Icon(Icons.move_to_inbox),
                                  SizedBox(width: 10,),
                                  Text("Invite", style: TextStyle(fontSize: 18),),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 5),)
                                ]),
                            const Icon(CupertinoIcons.right_chevron),
                          ],
                        ),
                      ),),
                    ButtonTheme(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                                children: const [
                                  Icon(Icons.reviews),
                                  SizedBox(width: 10,),
                                  Text("Review App", style: TextStyle(fontSize: 18),),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 5),)
                                ]),
                            const Icon(CupertinoIcons.right_chevron),
                          ],
                        ),
                      ),),
                    ButtonTheme(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: const [
                              Icon(Icons.help_sharp),
                              SizedBox(width: 10,),
                              Text("Help and Feedback", style: TextStyle(fontSize: 18),),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 5),)
                            ]),
                            const Icon(CupertinoIcons.right_chevron),
                          ],
                        ),
                      ),),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}