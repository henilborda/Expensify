import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(157, 40, 0, 10)),
                const Text("Accounts",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,),
                ),const Spacer(),
                IconButton(onPressed: (){
                  TextEditingController name1controller =
                  TextEditingController();
                  TextEditingController balancecontroller =
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
                              padding: EdgeInsets.fromLTRB(25, 20, 10, 30),
                              child: Text(
                                "Add Account",
                                style: TextStyle(
                                  fontSize: 20 ,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Row(
                              children:  [
                                SizedBox(width: 10,),
                                Icon(Icons.drive_file_rename_outline, size: 30,),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    controller: name1controller,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Account Name',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            Row(
                              children: [
                                const SizedBox(width: 10,),
                                Icon(Icons.money, size: 30,),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    controller: balancecontroller,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Account Balance',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.all(10)),
                            SizedBox(
                              width: 440,
                              child :
                              TextButton(
                                onPressed: () async {
                                  User? user = FirebaseAuth.instance.currentUser;
                                  await FirebaseFirestore.instance
                                      .collection('Account')
                                      .add({
                                    'name': name1controller.text,
                                    'balance': balancecontroller.text,
                                    'userId': user!.uid,
                                    'createdAt':DateTime.now()
                                  });
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  backgroundColor: const Color(0xFF2D3A39),
                                ),
                                child: const Text(
                                  "Add Account",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                          ])
                      );
                    },
                  );
                }, icon: const Icon(Icons.add,size: 33,)),
              ],
            ),
            Container(
              height: 270,
              width: 420,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                color: Color(0xFF2a384d),
              ),
              child: Column(
                children: const [
                  Padding(padding: EdgeInsets.all(22),
                    child: Text("Statistics",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),),)
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(10),
              child: Text("Active Accounts",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),),
            SizedBox(
              width: 170,
              child: FutureBuilder(
                future: getAccountBalance(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                        height: 100,
                        width: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF2a384d),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Text("Loading",
                              maxLines: 1,
                              style:
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),),
                            Text("Loading",
                              maxLines: 1,
                              style:
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,

                            ),)
                          ],
                        )
                    );
                  }
                  if(snapshot.data!.isEmpty){
                    return Container(
                        height: 100,
                        width: 260,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF2a384d),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Text("Loading",
                              maxLines: 1,
                              style:
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),),
                            Text("Loading",
                              maxLines: 1,
                              style:
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,

                              ),)
                          ],
                        )
                    );
                  }
                  return Container(
                      height: 100,
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF2a384d),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Kotak",
                            maxLines: 1,
                            style:
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),),
                          Padding(padding: EdgeInsets.all(5)),
                          Text(snapshot.data!,
                            maxLines: 1,
                            style:
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),)
                        ],
                      )
                  );

                },
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Transaction').where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy("createdAt",descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text("Data not found."),);
                    }

                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          return Container(
                            width: 300,
                            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                            color: Colors.white,
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Amount : ${doc["price"].toString()}", style: const TextStyle(fontSize: 18, color: Colors.black)),
                                Text("Category : ${doc["category"].toString()}", style: const TextStyle(fontSize: 18, color: Colors.black)),
                                Text("Memo : ${doc["memo"].toString()}", style: const TextStyle(fontSize: 18, color: Colors.black)),
                                Text("Type : ${doc["type"].toString()}", style: const TextStyle(fontSize: 18, color: Colors.black)),
                                Text("Date : ${doc["date"].toString()}", style: const TextStyle(fontSize: 18, color: Colors.black)),

                              ],
                            ),
                          );
                        });
                  }),

            ),

          ],
        ),
      ),
    );
  }

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
}
