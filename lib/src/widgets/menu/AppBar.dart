import 'package:cibic_mobile/src/resources/cibic_icons.dart';
import 'package:cibic_mobile/src/widgets/menu/Search.dart';
import 'package:flutter/material.dart';
import 'package:cibic_mobile/src/widgets/menu/ComposeScreen.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;

  BaseAppBar(this.pageName);

  void _startAddNewActivity(BuildContext context) {
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

  void _startSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 6,
      backgroundColor: Colors.transparent,
      builder: (bContext) {
        return GestureDetector(
          onTap: () {},
          child: Search(),
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
            onPressed: () {
              _startSearch(context);
            },
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
              _startAddNewActivity(context);
            },
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
