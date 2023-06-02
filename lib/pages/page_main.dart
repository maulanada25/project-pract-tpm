import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Navigator.push(
                //   context, 
                //   MaterialPageRoute(builder: (context) => ViewPage())  
                // );
              },
              icon: Icon(Icons.account_circle),
              label: Text("Agents"))
          ],
        )
      ),
    ));
  }
}