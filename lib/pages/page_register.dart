import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:finalproject1/model/model_login.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'page_login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late Box<loginData> _datalogin;

  bool check = false;

  Future <void> _register() async{
    String username = usernameController.text;
    String password = passwordController.text;

    final hashedPass = sha256.convert(utf8.encode(password)).toString();
    _datalogin.add(loginData(username: username, password: hashedPass));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()),);
  }

  void initState() {
    super.initState();
    awokwok();
  }

  void awokwok() async{
    _datalogin = await Hive.openBox('LoginModel');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('Register Page', style: TextStyle(fontSize: 40)),
                      SizedBox(height: 5),
                      Text('Please register to login'),
                    ],
                  ),
                ],
              ),
            ),
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
            SizedBox(height: 10),
            SizedBox(height: 10),
            Container(
                width: double.infinity,
                height: 40,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _register();
                      }, child: Text('Register'),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    ));
  }
}