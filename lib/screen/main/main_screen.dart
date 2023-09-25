import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:henil/SettingsPage.dart';
import 'package:henil/home_screen.dart';
import '../../accountpage.dart';
import '../../transactionpage.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String radioButtonItem = 'ONE';
  String radioButtonItem2 = 'Approved';
  int id = 1;
  int id2 = 1;
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    const HomeScreen(),
    const AccountPage(),
    const TransactionPage(),
    const SettingsPage(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4e5a5d),
        child: const Icon(Icons.add),
        onPressed: () {
          expenseBottomSheet();
        },

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF2a384d),
        shape: const CircularNotchedRectangle(),
        notchMargin: 0,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 100,
                    onPressed: () {
                      setState(() {
                        currentScreen = screens[0]; // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home_filled,
                          color: currentTab == 0 ? Colors.white : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = screens[1];  // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_balance,
                          color: currentTab == 1 ? Colors.white : Colors.grey,
                        ),
                        Text(
                          'Accounts',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 110,
                    onPressed: () {
                      setState(() {
                        currentScreen  = screens[2];  // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: currentTab == 2 ? Colors.white : Colors.grey,
                        ),
                        Text(
                          'Transaction',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = screens[3];  // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: currentTab == 3 ? Colors.white : Colors.grey,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.white : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }


  expenseBottomSheet(){
    String dropdownvalue = 'Select category';
    TextEditingController money1 = TextEditingController();
    TextEditingController memo1 = TextEditingController();
    TextEditingController date1 = TextEditingController();


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModelState) {
              return Padding(
              padding: EdgeInsets.only(
              bottom:
              MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 20, 10, 30),
                      child: Text(
                        "Add Transaction",
                        style: TextStyle(
                          fontSize: 20 ,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.attach_money, size: 30,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            controller: money1,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Money',
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 15, 10, 10),
                      child: Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 20 ,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),),),
                    Row(
                      children:  [
                        const SizedBox(width: 10,),
                        const Icon(size: 30, Icons.wallet_rounded,),
                        const SizedBox(width: 20,),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton<String>(
                              focusColor:Colors.white,
                              value: dropdownvalue,
                              elevation: 0,
                              style: const TextStyle(color: Colors.white),
                              iconEnabledColor:Colors.black,
                              items: <String>[
                                'Select category',
                                'Medical',
                                'Stationary',
                                'Food',
                                'Material',
                                'Xerox',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style:const TextStyle(color:Colors.black),),
                                );
                              }).toList(),
                              hint:const Text(
                                "Please choose a Category",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (String? value) {
                                setModelState(() {
                                  dropdownvalue = value!;
                                });
                                setState(() {});
                              },
                            ),
                          ],
                        ),

                        const SizedBox(width: 10,)

                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 50,),
                        Expanded(
                          child: TextField(
                            controller: memo1,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Add Memo',
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 40,),
                            Radio(
                              value: 1,
                              groupValue: id2,
                              onChanged: (val) {
                                setModelState(() {
                                  radioButtonItem2 = 'Approved';
                                  id2 = 1;
                                });
                                setState(() {});
                              },
                            ),
                            const Text(
                              'Approved',
                              style: TextStyle(fontSize: 17.0),
                            ),

                            Radio(
                              value: 2,
                              groupValue: id2,
                              onChanged: (val) {
                                setModelState(() {
                                  radioButtonItem2 = 'Pending';
                                  id2 = 2;
                                });
                                setState(() {});
                              },
                            ),
                            const Text(
                              'Pending',
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        InkWell(onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );
                          if(pickedDate != null) {
                            date1.text = '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                          }

                        },child:const Icon(Icons.calendar_month, size: 30,) ,)
                        ,
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            obscureText: false,
                            controller: date1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Date',
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
                          Navigator.of(context).pop();
                          User? user = FirebaseAuth.instance.currentUser;
                          await FirebaseFirestore.instance
                              .collection('Transaction')
                              .add({
                            'price': money1.text,
                            'memo': memo1.text,
                            'date' : date1.text,
                            'category' : dropdownvalue,
                            'type' : radioButtonItem2,
                            'flow' : radioButtonItem,
                            'userId': user!.uid,
                            'createdAt': DateTime.now()
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          elevation: 2,
                          backgroundColor: const Color(0xFF2D3A39),
                        ),
                        child: const Text(
                          "save",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ]),
              );
            });
      },
    );
  }
}
