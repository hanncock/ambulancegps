import 'package:ambulance/pages/Login.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {

  List booking = [];
  List ambulances = [];
  var selAmbu;
  var selAmbuId;
  var selAmbuPlate;
  var pricing;
  var pickLoc;
  var destination;
  var description;

  var id;
  var payselAmnt;
  var amnt2Pay;


  List drops = ['Payment Completed','Dispatched','Trip Complete'];
  var type;
  bool payment = false;

  getBookings()async{
    var resu;
    Userdata['type'] == 'Admin'? resu = await auth.getMany("/api/ambugps/booking/list"):
    resu = await auth.getMany("/api/ambugps/booking/list?userId=${Userdata['id']}");
    // resu = await auth.getMany("/api/ambugps/booking/list");
    setState(() {
      booking = resu['data'];
    });
  }
  
  getAmbulances()async{
    var resu = await auth.getMany("/api/ambugps/ambulance/list");
    setState(() {
      ambulances = resu['data'];
    });
  }

  @override
  void initState(){
    super.initState();
    getAmbulances();
    getBookings();
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1,color: Colors.black12)
                ),
                child: Center(child: Text('Map')),
              ),
              Card(
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
      
                            Column(
                              children: [
                                Container(
                                  width: 200,
                                  child: TextFormField(
                                    onChanged: (val){
                                      setState(() {
                                        pickLoc = val;
                                      });
      
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Pick Up Location',
      
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  width: 200,
                                  child: TextFormField(
                                    onChanged: (val){
                                      setState(() {
                                        destination = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Destination',
      
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Container(
                              width: 200,
                              child: TextFormField(
                                maxLines: 5,
                                minLines: 5,
                                onChanged: (val){
                                  setState(() {
                                    description = val;
      
                                  });
      
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Extra Details',
      
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.black12)
                      ),
                      width: 150,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
      
                          isExpanded: true,
                          // value: selCat == null ? '---' : selCat,
                          hint: Text('${selAmbu ?? ''}  ',
                            style: TextStyle(fontSize: 12,),
                            softWrap: true,
                          ),
                          items: ambulances.map(
                                (list) {
                              return DropdownMenuItem(
                                child: Text('${list['name'].toString() } \t,${list['pricing'].toString() }',
                                    style: TextStyle(fontSize: 12)
                                ),
                                value: [list],
                              );
                            },
                          ).toList(),
                          onChanged: (value) => setState(() {
                            var cats = value as List;
                            setState(() {
                              selAmbuId = cats[0]['id'];
                              selAmbu = cats[0]['name'];
                              selAmbuPlate = cats[0]['plate'];
                              pricing = cats[0]['pricing'];
                              pricing = cats[0]['pricing'];
                            });
                          }),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            // maxHeight: height * 0.6,
                          ),
      
                          barrierColor: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
              selAmbuId == null ? Text(''):
                  GestureDetector(
                      onTap: ()async{
                        Map data = {
                          "id":null,
                          "userId":Userdata['id'],
                          "userName":Userdata['names'],
                          "ambulanceId":selAmbuId,
                          "ambulanceName":selAmbu,
                          "ambulancePlate":selAmbuPlate,
                          "pricing":pricing,
                          "pickUpLocation":pickLoc,
                          "destination":destination,
                          "description": "${description}"
                        };
                        print(data);
                        var resu = await auth.saveMany(data, "/api/ambugps/booking/add");
                        print(resu);
                        if(resu == 'success'){
                          setState(() {
                            payment = true;
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
                          child: Text('Book Ambulance',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                  )
            ],
          ),
          payment? Column(
            children: [
              Text('Payment & Status',style: TextStyle(fontWeight: FontWeight.bold),),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1,color: Colors.green)
                  // color: Colors.green.withOpacity(0.5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('Amount to Pay \t'),Text( '${amnt2Pay}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                              ],
                            ),
                          ),
                          Container(
                            width: 200,
                            child: TextFormField(
                              onChanged: (val){
                                setState(() {
                                  payselAmnt = val;
                                  if(payselAmnt == amnt2Pay){
                                    type = "Payment Completed";
                                  }else{
                                    type = null;
                                  }
                                });
      
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Payment Amount',
      
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 50,),
                      Userdata['type'] == 'Admin'? Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
      
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Ambulance Status'),
                          ),
                          Container(
                            width: 200,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width:1)
                            ),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: type,
                                  items: drops.map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${type ==null ? e : type}',style: TextStyle(fontSize: 12),),
                                      ))).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      type = value;
                                    });
      
                                  },
                                )),
                          ),
                        ],
                      ):SizedBox(),
                      SizedBox(width: 20,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: ()async{
                              Map data = {
                                "id":id,
                                "userId":Userdata['id'],
                                "userName":Userdata['names'],
                                "ambulanceId":selAmbuId,
                                "ambulanceName":selAmbu,
                                "ambulancePlate":selAmbuPlate,
                                "pricing":pricing,
                                "amountPaid":payselAmnt,
                                "status":type
                              };
                              print(data);
                              var resu = await auth.saveMany(data, "/api/ambugps/booking/add");
                              print(resu);
                              if(resu == 'success'){
                                getBookings();
                                // setState(() {
                                //   payment = true;
                                // });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
                                child: Text('Save',style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      
            ],
          ): Text(''),
          Column(
            children: [
              Text('My Bookings',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
              Container(
                // height: 600,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width <  800 ?  800 : MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.5)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width:150,
                                      child: Text('User')),
                                  SizedBox(
                                      width: 150,
                                      child: Text('Ambulance')),
                                  SizedBox(
                                      width: 150,
                                      child: Text('Pricing')),
                                  SizedBox(
                                      width: 150,
                                      child: Text('Payment')),
                                  SizedBox(
                                      width: 150,
                                      child: Text('Status')),
                                  SizedBox(
                                      width: 150,
                                      child: Text('Pick Up Loc')),
                                  SizedBox(
                                      width: 150,
                                      child: Text('Destination')),
                                  SizedBox(
                                      width: 200,
                                      child: Text('Details')),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 400,
                            width: MediaQuery.of(context).size.width <  800 ?  800 : MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                                itemCount: booking.length,
                                itemBuilder: (context,index){
                                  return GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        payment = true;
                                        amnt2Pay = booking[index]['pricing'];
                                        id = booking[index]['id'];
                                        selAmbuId = booking[index]['ambulanceId'];
                                        selAmbu = booking[index]['ambulanceName'];
                                        selAmbuPlate = booking[index]['ambulancePlate'];
                                        pricing = booking[index]['pricing'];
                                        payselAmnt = booking[index]['amountPaid'];
                                        description = booking[index]['description'];
                                        destination = booking[index]['destination'];
                                        pickLoc = booking[index]['pickUpLocation'];

                                          // Map data = {
                                          //   "id":null,
                                          //   "userId":Userdata['id'],
                                          //   "userName":Userdata['names'],
                                          //   "ambulanceId":selAmbuId,
                                          //   "ambulanceName":selAmbu,
                                          //   "ambulancePlate":selAmbuPlate,
                                          //   "pricing":pricing
                                          // };


                                      });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width <  800 ?  800 : MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: index.isOdd ? Colors.black12 : Colors.transparent
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: 150,
                                                child: Text("${booking[index]['userName']}")),
                                            SizedBox(
                                              width: 150,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${booking[index]['ambulanceName']}"),
                                                  Text("${booking[index]['ambulancePlate']}"),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                width: 150,
                                                child: Text("${booking[index]['pricing']}")),
                                            SizedBox(
                                                width: 150,
                                                child: Text("${booking[index]['amountPaid']}")),
                                            SizedBox(
                                                width: 150,
                                              child: Text("${booking[index]['status']}")
                                            ),
                                            SizedBox(
                                                width: 150,
                                                child: Text("${booking[index]['pickUpLocation']}")
                                            ),
                                            SizedBox(
                                                width: 200,
                                                child: Text("${booking[index]['destination']}")
                                            ),
                                            SizedBox(
                                                width: 200,
                                                height: 100,
                                                child: SingleChildScrollView(
                                                    scrollDirection: Axis.vertical,
                                                    child: Text("${booking[index]['description']}"))
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
