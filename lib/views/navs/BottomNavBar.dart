import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:gic_call_center/views/contacts/index.dart';
import 'package:gic_call_center/views/events/index.dart';
import 'package:gic_call_center/views/home/index.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined, color: Colors.white),
            label: 'Home',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.call, color: Colors.white),
            label: 'Contacts',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.calendar_month , color: Colors.white),
            label: 'Events',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],
        color: Colors.blue,
        buttonBackgroundColor: Colors.blue,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      //display the body depending on the index
      body: _page == 0
          ? const HomePage()
          : _page == 1
              ? const Contacts()
              : const EventsPage(),
    );
  }
}
