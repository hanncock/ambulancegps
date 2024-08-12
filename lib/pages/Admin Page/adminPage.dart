import 'package:ambulance/pages/Login.dart';
import 'package:ambulance/pages/bookings.dart';
import 'package:ambulance/pages/menus.dart';
import 'package:ambulance/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import '../ambulances.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {


  List menus = [
    Menus(
      title: "Profile",
        Screen: Profile(),
        Icona: Icon(Icons.person)
    ),
    Menus(
        title: "Ambulances",
        Screen: Ambulances(),
        Icona: Icon(Icons.car_repair_rounded)
    ),
    Menus(
        title: "Bookings",
        Screen: Bookings(),
        Icona: Icon(Icons.local_shipping)
    ),
  ];

  var currentScreent;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('${menus[currentScreent].title == null ? '' :menus[currentScreent].title}'),
      ),
      drawer: Card(
        child: SizedBox(
          width: 200,
          child: Container(
        
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: menus.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  currentScreent = index;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 180,
                                // height: 100,
                                decoration:BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 0.1,color: Colors.black12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      menus[index].Icona,
                                      SizedBox(width: 10,),
                                      Text('${menus[index].title}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
        
                  // Column(
                  //   children: [
                  //     Container(
                  //       width: 200,
                  //       decoration:BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(width: 0.1,color: Colors.black12),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             spreadRadius: 5,
                  //             blurRadius: 7,
                  //             offset: Offset(0, 3), // changes position of shadow
                  //           ),
                  //         ],
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.person),
                  //             SizedBox(width: 10,),
                  //             Text('My Profile'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(height: 20,),
                  //     Container(
                  //       width: 200,
                  //       decoration:BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(width: 0.1,color: Colors.black12),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             spreadRadius: 5,
                  //             blurRadius: 7,
                  //             offset: Offset(0, 3), // changes position of shadow
                  //           ),
                  //         ],
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.car_rental_rounded),
                  //             SizedBox(width: 10,),
                  //             Text('Ambulances'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(height: 20,),
                  //     Container(
                  //       width: 200,
                  //       decoration:BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(width: 0.1,color: Colors.black12),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             spreadRadius: 5,
                  //             blurRadius: 7,
                  //             offset: Offset(0, 3), // changes position of shadow
                  //           ),
                  //         ],
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.car_repair_outlined),
                  //             SizedBox(width: 10,),
                  //             Text('Dispatches'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(height: 20,),
                  //     Container(
                  //       width: 200,
                  //       decoration:BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(width: 0.1,color: Colors.black12),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             spreadRadius: 5,
                  //             blurRadius: 7,
                  //             offset: Offset(0, 3), // changes position of shadow
                  //           ),
                  //         ],
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.people),
                  //             SizedBox(width: 10,),
                  //             Text('Users'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(height: 20,),
                  //     Container(
                  //       width: 200,
                  //       decoration:BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(width: 0.1,color: Colors.black12),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             spreadRadius: 5,
                  //             blurRadius: 7,
                  //             offset: Offset(0, 3), // changes position of shadow
                  //           ),
                  //         ],
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(10.0),
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.monetization_on_sharp),
                  //             SizedBox(width: 10,),
                  //             Text('Payments'),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        Userdata = null;
                      });
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Container(
                      width: 200,
                      decoration:BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.1,color: Colors.black12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(Icons.car_repair_outlined),
                            SizedBox(width: 10,),
                            Text('Log Out'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: currentScreent == null ? Text('') :Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            menus[currentScreent].Screen
          ],
        ),
      ),
    );
  }
}
