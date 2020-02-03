import 'package:flutter/material.dart';

import '../../constants.dart';

class MenuOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Drawer(
      child: Container(
        color: APP_BAR_BG,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'cibic',
                style: Theme.of(context).textTheme.title,
              ),
              decoration: BoxDecoration(),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Cabildos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Saved'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
