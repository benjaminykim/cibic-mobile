import 'package:flutter/material.dart';

import '../../constants.dart';

class MenuOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
      child: (Drawer(
        child: Container(
          decoration: BoxDecoration(color: APP_BAR_BG),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 90,
                    child: DrawerHeader(
                      child: Text(
                        'cibic',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(thickness: 3, color: Color(0xff828282),),
                  ),
                ],
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
      )),
    );
  }
}
