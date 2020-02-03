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
            ClipRect(
              child: DrawerHeader(
                child: Text(
                  'cibic',
                  style: Theme.of(context).textTheme.title,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight:Radius.circular(50)),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Cabildos',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Saved',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'About',
                style: Theme.of(context).textTheme.body1,
              ),
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
