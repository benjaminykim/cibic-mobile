import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/profile/CabildoProfileScreen.dart';
import 'package:flutter/material.dart';

class Configuration extends StatefulWidget {
  final String jwt;

  Configuration(this.jwt);

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  bool showNotificationSettings = false;
  bool notificationsOn = false;
  bool soundsOn = false;

  Widget cabildoItem(CabildoModel cabildo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CabildoProfileScreen(cabildo.id)));
      },
      child: Container(
        height: 65,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
              decoration: new BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              cabildo.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Divider divider = Divider(color: Colors.black, indent: 50, endIndent: 20);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: cibicTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("CONFIGURACIÓN",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                )),
            centerTitle: true,
            titleSpacing: 0.0,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: Container(
            color: APP_BACKGROUND,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Icon(Icons.clear, size: 30),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            'Eliminar usuario',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                divider,
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Icon(Icons.lock_outline, size: 30),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            'Politíca de privacidad',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                divider,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      this.showNotificationSettings =
                          !this.showNotificationSettings;
                    });
                  },
                  child: Container(
                    height: 50,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Icon(Icons.notifications_none, size: 30),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              'Preferencia de notificaciones',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                (this.showNotificationSettings)
                    ? Padding(
                          padding: const EdgeInsets.fromLTRB(35, 0, 30, 0),
                      child: SwitchListTile(
                          title: const Text('Notificación en pantalla'),
                          value: this.notificationsOn,
                          onChanged: (bool value) {
                            setState(() {
                              this.notificationsOn = value;
                            });
                          }),
                    )
                    : Container(),
                (this.showNotificationSettings)
                    ? Padding(
                          padding: const EdgeInsets.fromLTRB(35, 0, 30, 0),
                      child: SwitchListTile(
                          title: const Text('Sonidos'),
                          value: this.soundsOn,
                          onChanged: (bool value) {
                            setState(() {
                              this.soundsOn = value;
                            });
                          }),
                    )
                    : Container(),
                divider,
              ],
            ),
          )),
    );
  }
}
