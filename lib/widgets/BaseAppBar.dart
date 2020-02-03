import 'package:flutter/material.dart';

import '../constants.dart';
import './BaseTabBar.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: APP_BAR_BG,
      leading: Icon(Icons.menu, size: 50),
      bottom: BaseTabBar(),
      title: SizedBox(
        height: 40,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(20)),
            ),
            filled: true,
            hintText: 'buscar...',
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(105);
}
