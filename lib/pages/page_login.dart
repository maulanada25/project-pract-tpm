import 'package:finalproject1/pages/page_home.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:finalproject1/model/model_login.dart';
import 'page_register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late Box<loginData> _datalogin;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var error = '';
  bool login = false;

  void initState() {
    super.initState();
    awokwok();
  }

  void awokwok() async {
    _datalogin = await Hive.openBox('LoginModel');
  }

  void _showSnackbar(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _login() async{
    bool found = false;
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    final hashedPass = sha256.convert(utf8.encode(password)).toString();
    found = checkLogin(username, hashedPass);

    if(!found){
      _showSnackbar('Username or Password false');
    }else{
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage())
        , (route) => false);
      _showSnackbar("Login Succes");
    }
  }

  int getLength() {
    return _datalogin.length;
  }

  bool checkLogin(String username, String password) {
    bool found = false;
    for (int i = 0; i < getLength(); i++) {
      if (username == _datalogin.getAt(i)!.username &&
          password == _datalogin.getAt(i)!.password) {
        ("Login Success");
        found = true;
        break;
      } else {
        found = false;
      }
    }

    return found;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Login Page', style: TextStyle(fontSize: 40)),
                          SizedBox(height: 5),
                          Text('Please login to continue'),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          label: Text('Username'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text('Password'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Text("Don't have account yet ?"),
                          TextButton(onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => RegisterPage()));
                          }, child: Text('Register here'))
                        ],
                      ),
                    ],
                  ),
                ),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 12)),
                Container(
                    width: double.infinity,
                    height: 100,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed:() {
                            _login();
                          },
                          child: Text('Login'),
                        ),
                        SizedBox(height: 20,),
                      ],
                    )
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}