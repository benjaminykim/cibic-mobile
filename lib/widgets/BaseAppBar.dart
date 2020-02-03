import 'package:flutter/material.dart';

import '../constants.dart';
import './BaseTabBar.dart';
import './BaseSearchBar.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: APP_BAR_BG,
      bottom: BaseTabBar(),
      title: Search(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(105);
}
