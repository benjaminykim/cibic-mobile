import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityFeed.dart';
import 'package:cibic_mobile/src/widgets/menu/AppBar.dart';
import 'package:cibic_mobile/src/widgets/menu/BaseBar.dart';
import 'package:cibic_mobile/src/widgets/menu/MenuOverlay.dart';

Future<String> createFakeUser() async {
  String url = 'http://10.0.2.2:3000/users';
  Map map = {
    'user': {
      'username': 'ben',
      'password': 'fakepassword',
      'email': 'fakeEmail@gmail.com',
      'firstName': 'ben',
      'middleName': 'yo',
      'lastName': 'kim',
      'maidenName': 'hong',
      'phone': 6266924012,
      'rut': "123456790",
      'cabildos': [],
      'files': "none",
      'followers': [],
      'following': [],
      'activityFeed': []
    }
  };

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(map)));
  HttpClientResponse response = await request.close();
  String reply;
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    Map<String, dynamic> user = jsonDecode(responseBody);
    reply = user['id'];
  } else {
    throw Exception(
        "HTTP Response error code: " + response.statusCode.toString());
  }
  httpClient.close();
  return reply;
}

class App extends StatefulWidget {
  final Client client;

  App(this.client);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
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

  void onActivityTapped(ActivityScreen activityScreen, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => activityScreen));
  }

  @override
  void initState() {
    super.initState();
    createFakeUser().then((value) {
      print(value);
    });
    _widgetOptions = [
      ActivityFeed("home", onActivityTapped),
      Container(),
      ActivityFeed("home", onActivityTapped),
      ActivityFeed("home", onActivityTapped),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: cibicTheme,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
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
