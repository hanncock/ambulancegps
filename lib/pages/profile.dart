import 'package:ambulance/pages/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Service.dart';
import 'loader.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var username = Userdata == null ? null :Userdata['username'] ;
  var password = Userdata == null ? null :Userdata['password'];
  var type = Userdata == null ? 'User' : Userdata['type'];
  bool loginPage = true;
  AuthService auth = AuthService();
  bool loading = false;
  var names = Userdata == null ? null : Userdata['names'];
  var email = Userdata == null ? null : Userdata['email'];
  var phone = Userdata == null ? null : Userdata['phone'];

  List users = [];

  getUsers()async{
    var resu = await auth.getMany("/api/ambugps/users/list");
    setState(() {
      users = resu['data'];
    });
  }

  @override
  void initState(){
    super.initState();
    Userdata == null ? null :getUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Userdata == null ? Text('') : Userdata['type'] == 'Admin' ?Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Users',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ),
                    Container(
                      width: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: users.length,
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
                                          child: Icon(Icons.person),
                                        ),
                                      ),
                                      // Text('${users[int]}'),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${users[int]['names']}'),
                                          ),
                                          IntrinsicHeight(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${users[int]['email']}'),
                                                ),
                                                VerticalDivider(thickness: 1,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('${users[int]['phone']}'),
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
                                          "id":users[int]['id']
                                        };
                                        var resu = await auth.saveMany("/api/ambugps/users/del", data);
                                        print(resu);
                                        // getUsers();
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
            ): Text(''),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text('${Userdata}'),
                 Text(' ${Userdata == null ? 'Create Account' : 'Edit Profile'}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),),
                SizedBox(height: 20,),
                CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.person),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 380,
                  child: TextFormField(
                    initialValue: username,
                    onChanged: (val){
                      setState(() {
                        username = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'username',

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 380,
                  child: TextFormField(
                    initialValue: names,
                    onChanged: (val){
                      setState(() {
                        names = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'names',

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 380,
                  child: TextFormField(
                    initialValue: phone,
                    onChanged: (val){
                      setState(() {
                        phone = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'phone No',

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 380,
                  child: TextFormField(
                    initialValue: email,
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',

                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 380,
                  child: TextFormField(
                    initialValue: password,
                    onChanged: (val){
                      setState(() {
                        password = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',

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
                      "id": Userdata == null ? null :Userdata['id'] ,
                      "username":username,
                      "password":password,
                      "email":email,
                      "names":names,
                      "phone":phone,
                      "type":type,
                    };
                    var resu = await auth.saveMany(data, "/api/ambugps/users/add");
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
                      setState(() {
                        Userdata = null;
                      });
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                      setState(() {
                        loginPage = true;
                      });
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
            ),
          ],
        ),
      ),
    );
  }
}
