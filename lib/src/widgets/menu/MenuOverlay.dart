import 'package:cibic_mobile/src/onboard/app.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class MenuOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(70), topRight: Radius.circular(70)),
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
                        child: Image(
                            image: AssetImage('assets/images/cibic_logo.png')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Divider(
                        thickness: 0.7,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Perfil',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Crear cabildo',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "OpenSans",
                      color: APP_BACKGROUND,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Guardados',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Configuracion',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'About @cibic',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Cerrar Sesion',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onTap: () {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: new Text("Cerrar Sesion"),
                          content: new Text("Quierers cerrar tu sesion?"),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Si"),
                              onPressed: () {
                                storage.delete(key: "jwt");
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            App()));
                              },
                            ),
                            new FlatButton(
                              child: new Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
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
