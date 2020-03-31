import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/widgets/utils/ComposeScreen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;

  BaseAppBar(this.pageName);

  void _startAddNewActivity(BuildContext context, String idUser, List<dynamic> cabildos) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 5,
      backgroundColor: Colors.transparent,
      builder: (bContext) {
        return GestureDetector(
          onTap: () {},
          child: Compose(idUser, cabildos),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
      converter: (Store<AppState> store) => User.create(store),
      builder: (BuildContext context, User user) {
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
                _startAddNewActivity(context, user.idUser, user.cabildos);
              },
              padding: EdgeInsets.zero,
            ),
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class User {
  final String idUser;
  final int selectedComposeButton;
  final List<dynamic> cabildos;

  User(this.idUser, this.selectedComposeButton, this.cabildos);

  factory User.create(Store<AppState> store) {
    return User(store.state.idUser, store.state.selectedComposeButton,
        store.state.cabildos);
  }
}
