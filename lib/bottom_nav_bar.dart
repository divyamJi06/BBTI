import 'package:bbti/views/contacts.dart';
import 'package:bbti/views/home_page.dart';
import 'package:bbti/views/locks_page.dart';
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
  static const List<Widget> _widgetOptions = <Widget>[
    // Text('Home Page',
    //     style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    HomePage(),
    ContactsPage(),
    LockPage(),
    RouterPage(),
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('BelBird BTLock-I'), backgroundColor: Colors.green),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: ('Home'),
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: ('User'),
                backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock_rounded),
              label: ('Locks'),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wifi_outlined),
              label: ('Router'),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: ('Settings'),
              backgroundColor: Colors.blue,
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
