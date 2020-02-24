import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('INICIO'),
      centerTitle: true,
      titleSpacing: 0.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
          padding: EdgeInsets.all(0),
        ),
        IconButton(
          icon: Icon(Icons.create),
          onPressed: () {},
          padding: EdgeInsets.zero,
        ),
        IconButton(
          icon: Icon(Icons.notifications_none),
          onPressed: () {},
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
