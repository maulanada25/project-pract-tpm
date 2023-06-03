import 'package:finalproject1/pages/page_login.dart';
import 'package:finalproject1/view/view_agents.dart';
import 'package:finalproject1/view/view_profile.dart';
import 'package:finalproject1/view/view_weapons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> title = ['Group Member', 'Agents List', 'Weapons List'];
  int _selected = 0;
  static List<Widget> _pageOpt = <Widget>[
    ProfilePage(),
    AgentsView(),
    WeaponsView()
  ];
  Future<void> _checkprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _checkprofile();
      Hive.close();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    } else {
      setState(() {
        _selected = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(title[_selected]),
      ),
      body: _pageOpt.elementAt(_selected),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            title: Text('Home'),
            // label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_rounded),
            title: Text('Agents'),
            // label: 'Agents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_rounded),
            title: Text('Weapons'),
            // label: 'Weapons',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            // title: Text("Logout", style: TextStyle(color: Colors.red),)
            // label: 'Logout',
            // backgroundColor: Colors.red
          ),
        ],
        currentIndex: _selected,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black54,
        onTap: _onItemTapped,
      ),
    );
  }
}
