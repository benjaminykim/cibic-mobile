import 'package:flutter/material.dart';

import '../../constants.dart';

class MenuOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50)),
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
                      height: 130,
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
                    'Perfil',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Crear cabildo',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Guardados',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Configuracion',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'About @cibic',
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
      ),
    );
  }
}
