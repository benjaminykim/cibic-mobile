import 'package:cibic_mobile/src/onboard/welcome.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:cibic_mobile/src/widgets/profile/SelfProfileScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityFeed.dart';
import 'package:cibic_mobile/src/widgets/menu/AppBar.dart';
import 'package:cibic_mobile/src/widgets/menu/BaseBar.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/MenuOverlay.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';

class Home extends StatefulWidget {
  final Store store;

  Home(this.store);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _widgetOptions;
  int selectedBarIndex = 0;
  String appBarTitle = "INICIO";
  List<String> _feedNames = ["INICIO", "PÚBLICO", "USUARIO", "ESTADÍSTICAS"];
  FlutterSecureStorage storage = FlutterSecureStorage();

  void onBarButtonTapped(int index) {
    setState(() {
      selectedBarIndex = index;
      appBarTitle = _feedNames[selectedBarIndex];
    });
  }

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      ActivityFeed(FEED_HOME),
      ActivityFeed(FEED_PUBLIC),
      SelfProfileScreen(),
      Container(),
    ];
  }

  Future<String> get _jwt async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null || jwt is List) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _jwt, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == "") {
              return Welcome();
            } else {
              return DefaultTabController(
                length: 4,
                child: Scaffold(
                  appBar: BaseAppBar(this.appBarTitle),
                  body: Center(
                    child: _widgetOptions.elementAt(selectedBarIndex),
                  ),
                  drawer: MenuOverlay(snapshot.data, this.onBarButtonTapped, widget.store),
                  bottomNavigationBar:
                      BaseBar(this.selectedBarIndex, this.onBarButtonTapped),
                ),
              );
            }
          } else {
            return Container(
              color: COLOR_DEEP_BLUE,
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                  ),
                  width: 60,
                  height: 60,
                ),
              ),
            );
          }
        });
  }
}
