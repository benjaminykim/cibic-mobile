import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/redux/reducers/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityScreen.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityFeed.dart';
import 'package:cibic_mobile/src/widgets/menu/AppBar.dart';
import 'package:cibic_mobile/src/widgets/menu/BaseBar.dart';
import 'package:cibic_mobile/src/widgets/menu/MenuOverlay.dart';
import 'package:redux_thunk/redux_thunk.dart';

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

Future<List<dynamic>> getCabildos() async {
  final response = await http.get(URL_LOCALHOST_BASE + ENDPOINT_CABILDOS);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load home feed');
  }
}

class App extends StatefulWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  );

  App();

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

    // TESTING
    createFakeUser().then((value) {
      print("create fake user: " + value);
      widget.store.dispatch(AppUser(value));
      return value;
    }).then((value) {
      getCabildos().then((value) {
        print("follow cabildos: ");
        print(value[0]);
        widget.store.dispatch(GetCabildos(value));
      });
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
    return StoreProvider(
      store: widget.store,
          child: MaterialApp(
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
      ),
    );
  }
}
