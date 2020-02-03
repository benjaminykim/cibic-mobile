import 'package:flutter/material.dart';

import '../../constants.dart';

class BaseTabBar extends Container implements PreferredSizeWidget {
  BaseTabBar();

  final Color color = APP_BAR_BOTTOM;
  final TabBar tabBar = TabBar(
        indicator: BoxDecoration(color: APP_BAR_SELECTED),
        tabs: [
          Tab(icon: Icon(Icons.public, size: 30)),
          Tab(icon: Icon(Icons.people_outline, size: 30)),
          Tab(icon: Icon(Icons.person_outline, size: 30)),
          Tab(icon: Icon(Icons.poll, size: 30)),
        ],
      );

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
    color: color,
    child: tabBar,
  );
}