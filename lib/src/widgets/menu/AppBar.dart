import 'package:flutter/material.dart';
import 'package:cibic_mobile/src/widgets/menu/ComposeScreen.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;
  final String jwt;

  BaseAppBar(this.pageName, this.jwt);

  void _startAddNewActivity(BuildContext context, String jwt) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 5,
      backgroundColor: Colors.transparent,
      builder: (bContext) {
        return GestureDetector(
          onTap: () {},
          child: Compose(jwt),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.pageName,
          style: TextStyle(
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
            _startAddNewActivity(context, this.jwt);
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
