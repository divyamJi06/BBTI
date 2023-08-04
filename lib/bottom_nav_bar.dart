import 'package:bbti/constants.dart';
import 'package:bbti/views/contacts.dart';
import 'package:bbti/views/locks_page.dart';
import 'package:bbti/views/new_home_page.dart';
import 'package:bbti/views/router_page.dart';
import 'package:bbti/views/settings.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    // Text('Home Page',
    //     style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    const NewHomePage(),
    // HomePage(),
    const ContactsPage(),
    LockPage(),
    RouterPage(),
    const SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text('BelBird BTLock-I'), backgroundColor: backGroundColour),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: ('Home'),
                backgroundColor: backGroundColour),
            BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: ('User'),
                backgroundColor: backGroundColour),
            BottomNavigationBarItem(
              icon: const Icon(Icons.lock_rounded),
              label: ('Locks'),
              backgroundColor: backGroundColour,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.wifi_outlined),
              label: ('Router'),
              backgroundColor: backGroundColour,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: ('Settings'),
              backgroundColor: backGroundColour,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
