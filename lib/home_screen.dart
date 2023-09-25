import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:henil/SettingsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> budgets = [];

  Future<dynamic> getAccountBalance() async {
    final totalSnapshots = await FirebaseFirestore.instance
        .collection('Account')
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("createdAt")
        .limit(1)
        .get();
    double totalBalance = double.tryParse((totalSnapshots.docs.first.data()['balance']).toString().replaceAll(",", "")) ?? 0;
    print(totalBalance);
    final allTransactionSnapshot = await FirebaseFirestore.instance
        .collection('Transaction')
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("createdAt", descending: true)
        .get();
    allTransactionSnapshot.docs.forEach((element) {
      Map<String,dynamic> data = element.data();
      if(data.isNotEmpty && data.containsKey("price")){
        final price = double.tryParse(data['price'].toString().replaceAll(",", "")) ?? 0;
        totalBalance -= price;
      }
    });
    return totalBalance.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Color(0xFF4e5a5d), // status bar color
    ));

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        budgets = prefs.getStringList("budget") ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: const Color(0xFF4e5a5d),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  children: [
                    const ClipRRect(
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 55,
                        color: CupertinoColors.systemGrey4,
                      )
                    ),

                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good ${greeting()}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        const Text(
                          "Henil Borda",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 17)),
              SizedBox(
                width: 380,
                child: FutureBuilder(
                  future: getAccountBalance(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Container(
                          height: 100,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF2a384d),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Text(
                                "Account Total Balance",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(14)),
                              Text(
                                "Loading...",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ));
                    }
                    return Container(
                        height: 150,
                        width: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF2a384d),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              "Account Total Balance",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(10)),
                            Text(
                              snapshot.data,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ));
                  },
                ),
              ),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(20, 40, 0, 10)),
                  const Text(
                    "Budgets",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        TextEditingController nameController =
                            TextEditingController();
                        TextEditingController budgetController =
                            TextEditingController();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(25, 20, 10, 30),
                                      child: Text(
                                        "Add Budget",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.drive_file_rename_outline,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: nameController,
                                            obscureText: false,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Name',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    const Padding(padding: EdgeInsets.all(10)),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.money,
                                          size: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: budgetController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Budget Amount',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    const Padding(padding: EdgeInsets.all(10)),
                                    SizedBox(
                                      width: 440,
                                      child: TextButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          User? user =
                                              FirebaseAuth.instance.currentUser;
                                          await FirebaseFirestore.instance
                                              .collection('Budget')
                                              .add({
                                            'name': nameController.text,
                                            'budget': budgetController.text,
                                            'userId': user!.uid,
                                            'createdAt': DateTime.now()
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          elevation: 2,
                                          backgroundColor:
                                              const Color(0xFF2D3A39),
                                        ),
                                        child: const Text(
                                          "Add",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ),
                                    ),
                                  ]),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 33,
                      )),
                ],
              ),
              SizedBox(
                height: 125,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Budget')
                        .where("userId",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .orderBy("createdAt", descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Data not found."),
                        );
                      }
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return Container(
                              width: 300,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              color: Colors.grey,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Budget: ${doc["name"].toString()}",
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    Text("Amount: ${doc["budget"].toString()}",
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
              ),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 10, 12),
                    child: Text(
                      "Recent Transaction",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                      ),
                    ),
                  )),
              Flexible(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Transaction')
                        .where("userId",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .orderBy("createdAt", descending: true)
                        .limit(3)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Data not found."),
                        );
                      }

                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return Container(
                              width: 300,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Amount : ${doc["price"].toString()}",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                  Text(
                                      "Category : ${doc["category"].toString()}",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                ],
                              ),
                            );
                          });
                    }),
              ),
              const Padding(padding: EdgeInsets.all(7)),
            ],
          ),
        ),
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
