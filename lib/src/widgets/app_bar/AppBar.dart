import 'package:flutter/material.dart';

import '../Compose.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;

  BaseAppBar(this.pageName);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.pageName, style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      )),
      centerTitle: true,
      titleSpacing: 0.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.create),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Compose()),
            );
          },
          padding: EdgeInsets.zero,
        ),
        IconButton(
          icon: Icon(Icons.notifications_none),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
