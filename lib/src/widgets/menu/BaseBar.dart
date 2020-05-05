import 'package:flutter/material.dart';

class BaseBar extends StatelessWidget {
  final int selectedIndex;
  final Function onItemTapped;

  BaseBar(this.selectedIndex, this.onItemTapped);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black, size: 30),
              title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.public, color: Colors.black, size: 30),
              title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Colors.black, size: 30),
              title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart, color: Colors.black, size: 30),
              title: Text("")),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
      ),
    );
  }
}
