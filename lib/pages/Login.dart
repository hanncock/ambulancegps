import 'package:ambulance/pages/Admin%20Page/adminPage.dart';
import 'package:ambulance/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Service.dart';
import 'loader.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

var Userdata ;
AuthService auth = AuthService();
class _LoginState extends State<Login> {



  var username;
  var password;
  var type = 'Admin';

  var names;
  var email;
  var phone;

  bool loginPage = true;

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginPage ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              SizedBox(height: 40,),
              Container(
                width: 380,
                child: TextFormField(
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
              SizedBox(height: 20,),
              Container(
                width: 380,
                child: TextFormField(
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'password',

                  ),
                ),
              ),

              SizedBox(height: 30,),
              GestureDetector(
                onTap: ()async{
                  loading ? showDialog(
                      context: context, builder: (_) => const LoadingSpinCircle()
                  ): null;
                  // var resu = await auth.login(username, password);
                  var resu = await auth.getMany("/api/ambugps/users/list?username=${username}&password=${password}");
                  print(resu);
                  setState(() {
                    Userdata =  resu['data'][0];
                    loading = false;
                  });
                  // print("here is the data${resu['data'][0]['type']}");
                  // if(resu['data'][0]['type'] == 'Admin'){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminHome()));
                  // }

                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 80),
                    child: Text('Login',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),

              Row(
                children: [
                  TextButton(
                      onPressed: ()async{
                        setState(() {
                          loginPage = false;
                        });
                      },
                      child: Text('Create Account')
                  ),
                ],
              ),
              SizedBox(height: 30,),

            ]
          ),
        ],
      ):
          Profile()
    );
  }
}
