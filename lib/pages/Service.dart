import 'dart:convert';
import 'package:http/http.dart' as http;


class AuthService{

  // String url ="http://0.0.0.0:3000";
  String url ="https://d528-197-248-34-79.ngrok-free.app";

  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };


  login(username,password)async{
    Map data = {
      "username": username,
      "password": password
    };
    print(data);
    // String all = '$url/qv/api/auth/login';
    String all = '$url/api/ambugps/users?';
    var send = jsonEncode(data);
    var resp = await http.post(Uri.parse(all), body: send, headers: headers);
    print(resp.body);
    return jsonDecode(resp.body);
  }

  getMany(endoint)async{
    var all = url.toString()+'$endoint';
    print(all);
    var resu = await http.get(Uri.parse(all));
    return jsonDecode(resu.body);
  }


  saveMany(val,endpoint)async{
    var all = '${url}${endpoint}';
    var send = jsonEncode(val);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    print(response.body);
    var responseData = jsonDecode(response.body);
    return responseData;
  }

  delete(endpoint,id)async{
    var all = await url+endpoint;
    return (all);
  }

}