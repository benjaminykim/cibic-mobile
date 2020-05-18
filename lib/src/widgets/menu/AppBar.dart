import 'package:cibic_mobile/src/models/cibic_icons.dart';
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
          child: Compose(),
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
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: IconButton(
            icon: Icon(
              Cibic.search,
              size: 38,
            ),
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 9),
          child: IconButton(
            icon: Icon(
              Cibic.create_post,
              size: 35,
            ),
            onPressed: () {
              _startAddNewActivity(context, this.jwt);
            },
            padding: EdgeInsets.zero,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: IconButton(
            icon: Icon(
              Cibic.notification,
              size: 30,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
