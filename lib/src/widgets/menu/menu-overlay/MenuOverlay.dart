import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/About.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/Configuration.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/MyCabildos.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/Saved.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/Unete.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';

final storage = FlutterSecureStorage();

class MenuOverlay extends StatelessWidget {
  final Function onPerfilTap;
  final String jwt;
  final Store store;

  MenuOverlay(this.jwt, this.onPerfilTap, this.store);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(70), topRight: Radius.circular(70)),
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(color: COLOR_DEEP_BLUE),
            child: Column(
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
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    this.onPerfilTap(2);
                  },
                ),
                ListTile(
                    contentPadding: EdgeInsets.only(left: 20),
                    title: Text(
                      'Cabildos',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyCabildos()));
                    }),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Guardados',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Saved()));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Configuración',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Configuration(this.jwt)));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Acerca de Cibic',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => About()));
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Cerrar la Sesión',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Cerrar Sesion",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          content: Text("Quieres cerrar tu sesion?"),
                          actions: <Widget>[
                                  FlatButton(
                                    child: new Text("Si"),
                                    onPressed: () {
                                      this.store.dispatch(LogOut());
                                      storage.delete(key: "jwt");
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil('/',
                                              (Route<dynamic> route) => false);
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
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    'Únete!',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Unete()));
                  },
                ),
                Spacer(),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Text(
                    '\u00a9 cibic 2020',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}