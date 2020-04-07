import 'dart:convert';
import 'package:cibic_mobile/src/widgets/profile/SelfProfileScreen.dart';

import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/reducers/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:cibic_mobile/src/widgets/activity/ActivityFeed.dart';
import 'package:cibic_mobile/src/widgets/menu/AppBar.dart';
import 'package:cibic_mobile/src/widgets/menu/BaseBar.dart';
import 'package:cibic_mobile/src/widgets/menu/MenuOverlay.dart';
import 'package:redux_thunk/redux_thunk.dart';

class Home extends StatefulWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  );
  final storage;
  final String jwt;
  final Map<String, dynamic> payload;
  final String idUser;

  factory Home.fromBase64(storage, String jwt, String idUser) => Home(
      storage,
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))),
      idUser
          );

  Home(this.storage, this.jwt, this.payload, this.idUser);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Home> {
  int selectedBarIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<dynamic> feed;
  List<Widget> _widgetOptions;
  String appBarTitle = "INICIO";
  List<String> _feedNames = ["INICIO", "PUBLICO", "USARIO", "ESTADISTICAS"];

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
      ActivityFeed(widget.idUser, widget.jwt),
      Container(),
      SelfProfileScreen(widget.idUser, widget.jwt),
      ActivityFeed(widget.idUser, widget.jwt),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: BaseAppBar(this.appBarTitle),
          body: Center(
            child: _widgetOptions.elementAt(selectedBarIndex),
          ),
          drawer: MenuOverlay(),
          bottomNavigationBar:
              BaseBar(this.selectedBarIndex, this.onBarButtonTapped),
        ),
      ),
    );
  }
}
