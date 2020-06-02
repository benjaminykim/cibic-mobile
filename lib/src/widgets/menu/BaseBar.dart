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
              semanticLabel: "Publico",
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Cibic.user,
              color: Colors.black,
              size: 42,
              semanticLabel: "Perfil",
            ),
            activeIcon: Icon(
              Cibic.user,
              color: COLOR_DEEP_BLUE,
              size: 42,
              semanticLabel: "Perfil",
            ),
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
              semanticLabel: "Estadisticas",
            ),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }
}
