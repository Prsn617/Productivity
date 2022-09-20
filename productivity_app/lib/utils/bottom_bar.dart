import 'package:flutter/material.dart';
import 'package:productivity_app/screens/home.dart';
import 'package:productivity_app/screens/more.dart';
import 'package:productivity_app/screens/notes.dart';
import 'package:productivity_app/screens/pomodoro.dart';
import 'package:productivity_app/utils/styles.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _navIndex = 0;
  int profInd = 0;
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const Home(),
      const Notes(),
      const Pomo(),
      const More(),
    ];
  }

  void onItemTapped(int indexer) {
    setState(() {
      _navIndex = indexer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_navIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 7,
          onTap: onItemTapped,
          currentIndex: _navIndex,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Styles.mainColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "To-Do"),
            BottomNavigationBarItem(icon: Icon(Icons.note), label: "Notes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.lock_clock), label: "PomoDoro"),
            BottomNavigationBarItem(icon: Icon(Icons.more), label: "More"),
          ]),
    );
  }
}
