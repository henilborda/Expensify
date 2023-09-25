import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.fromLTRB(25, 20, 10, 30),
              child: Text(
                "Transaction",
                style: TextStyle(
                  fontSize: 25 ,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),),),
              SizedBox(
                width: 380,
                child: FutureBuilder(
                  future: getAccountBalance(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Container(
                          height: 150,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF2a384d),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Text("Account Total Balance",
                                maxLines: 1,
                                style:
                                TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),),
                              Padding(padding: EdgeInsets.all(14)),
                              Text("Loading...",
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
                        height: 130,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF2a384d),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text("Account Total Balance",
                              maxLines: 1,
                              style:
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),),
                            Padding(padding: EdgeInsets.all(10)),
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
              const Align(
                  alignment:Alignment.topLeft,
                  child:
                  Padding(padding:  EdgeInsets.fromLTRB(20,20,10,14),
                    child: Text("Activity",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 19,),
                    ),)
              ),
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
                              padding: EdgeInsets.all(5),
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
