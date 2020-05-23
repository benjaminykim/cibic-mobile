import 'package:cibic_mobile/src/resources/cibic_icons.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseBar extends StatelessWidget {
  final int selectedIndex;
  final Function onItemTapped;

  BaseBar(this.selectedIndex, this.onItemTapped);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.all(0),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
      child: CupertinoTabBar(
        border: Border(top: BorderSide.none),
        // activeColor: COLOR_DEEP_BLUE,
        // iconSize: 50,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Cibic.home,
              color: Colors.black,
              size: 42,
              semanticLabel: "Inicio",
            ),
            activeIcon: Icon(
              Cibic.home,
              color: COLOR_DEEP_BLUE,
              size: 42,
              semanticLabel: "Inicio",
            ),
            // title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Cibic.public,
              color: Colors.black,
              size: 42,
              semanticLabel: "Publico",
            ),
            activeIcon: Icon(
              Cibic.public,
              color: COLOR_DEEP_BLUE,
              size: 42,
              semanticLabel: "Inicio",
            ),
            // title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Cibic.user_2,
              color: Colors.black,
              size: 42,
              semanticLabel: "Perfil",
            ),
            activeIcon: Icon(
              Cibic.user_2,
              color: COLOR_DEEP_BLUE,
              size: 42,
              semanticLabel: "Inicio",
            ),
            // title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Cibic.results,
              color: Colors.black,
              size: 42,
              semanticLabel: "Estadisticas",
            ),
            activeIcon: Icon(
              Cibic.results,
              color: COLOR_DEEP_BLUE,
              size: 42,
              semanticLabel: "Inicio",
            ),
            // title: Text(
            //   "*",
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 20,
            //   ),
            // ),
          ),
        ],
        // type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        // showSelectedLabels: true,
        // showUnselectedLabels: false,
        backgroundColor: Colors.white,
      ),
    );
  }
}
