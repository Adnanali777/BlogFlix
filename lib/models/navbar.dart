import 'package:blogflix/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:blogflix/screens/create_blog.dart';
import 'package:blogflix/screens/profile.dart';

class MyNavbar extends StatefulWidget {
  @override
  _MyNavbarState createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar> {
  int currentindex = 0;
  List<Widget> children = [
    Home(),
    CreatePost(),
  ];
  void onTapped(index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[currentindex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
            color: Colors.grey[200],
            width: 1,
          )),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentindex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.orange[600],
          onTap: onTapped,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Create',
            ),
          ],
        ),
      ),
    );
  }
}
