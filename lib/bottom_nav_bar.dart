import 'constants.dart';
import 'views/contacts.dart';
import 'views/locks_page.dart';
import 'views/new_home_page.dart';
import 'views/router_page.dart';
import 'views/settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controllers/permission.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission(Permission.camera);
    requestPermission(Permission.contacts);
    requestPermission(Permission.location);
  }
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
