import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Login.dart';
import 'loader.dart';

class Ambulances extends StatefulWidget {
  const Ambulances({super.key});

  @override
  State<Ambulances> createState() => _AmbulancesState();
}

class _AmbulancesState extends State<Ambulances> {
  
  List ambulances = [];
  bool loading = false;


  var id;
  var name;
  var plate;
  var pricing;
  var ambulocation;
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
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Ambulances'),
                  Container(
                    width: 400,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: ambulances.length,
                        itemBuilder: (context,int){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.only(left: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius:20,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.car_rental),
                                        ),
                                      ),
                                      // Text('${ambulances[int]}'),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${ambulances[int]['name']}'),
                                          ),
                                          IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${ambulances[int]['plate']}'),
                                                ),
                                                VerticalDivider(thickness: 1,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${ambulances[int]['pricing']}'),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                  Userdata == null ? Text('') : Userdata['type'] == 'Admin' ?
                                  IconButton(
                                      onPressed:()async{
                                        Map data  = {
                                          "id":ambulances[int]['id']
                                        };
                                        var resu = await auth.saveMany("/api/ambugps/ambulances/del", data);
                                        print(resu);
                                        // getambulances();
                                      },
                                      icon:Icon(Icons.delete,color: Colors.redAccent,)
                                  ):Text(''),

                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              )
            ],
          ),
          Userdata == null ? Text('') : Userdata['type'] == 'Admin' ?Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text('${Userdata}'),
              SizedBox(height: 20,),
              Container(
                width: 380,
                child: TextFormField(
                  initialValue: name,
                  onChanged: (val){
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ambulance Name',

                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 380,
                child: TextFormField(
                  initialValue: plate,
                  onChanged: (val){
                    setState(() {
                      plate = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ambulance Plate No',

                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 380,
                child: TextFormField(
                  initialValue: pricing,
                  onChanged: (val){
                    setState(() {
                      pricing = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pricing',

                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 380,
                child: TextFormField(
                  initialValue: ambulocation,
                  onChanged: (val){
                    setState(() {
                      ambulocation = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',

                  ),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: ()async{
                  setState(() {
                    loading = true;
                  });
                  loading ? showDialog(
                      context: context, builder: (_) => const LoadingSpinCircle()
                  ): null;
                  Map data = {
                    "id":id,
                    "name":name,
                    "plate":plate,
                    "pricing":pricing,
                    "location":ambulocation,
                  };
                  var resu = await auth.saveMany(data, "/api/ambugps/ambulance/add");
                  if(resu == 'success'){
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "success",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    getAmbulances();
                  }else{
                    Fluttertoast.showToast(
                        msg: "${resu}",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 80),
                    child: Text('Save',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ):SizedBox(),
        ],
      ),
    );
  }
}
