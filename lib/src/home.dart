import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:cibic_mobile/src/widgets/profile/SelfProfileScreen.dart';
import 'package:http/http.dart' as http;

import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/redux/reducers/reducers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityFeed.dart';
import 'package:cibic_mobile/src/widgets/menu/AppBar.dart';
import 'package:cibic_mobile/src/widgets/menu/BaseBar.dart';
import 'package:cibic_mobile/src/widgets/menu/MenuOverlay.dart';
import 'package:redux_thunk/redux_thunk.dart';

Future<String> createFakeUser(Store<AppState> store) async {
  String url = 'http://10.0.2.2:3000/users';
  Map<String, dynamic> userProfile = {
      'username': 'benkim9611',
      'password': 'fakepassword',
      'email': 'fakeEmai111l@gmail.com',
      'firstName': 'Benjamin',
      'middleName': 'Young-min',
      'lastName': 'Kim',
      'maidenName': 'none',
      'phone': 626692401232,
      'rut': "1234567900",
      'cabildos': [],
      'files': "none",
      'followers': [],
      'following': [],
      'activityFeed': []
    };
  Map map = {
    'user': userProfile
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
    userProfile['id'] = user['id'];
    print(userProfile);
    store.dispatch(AppUser(userProfile));
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

class Home extends StatefulWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware],
  );
  final storage;
  final String jwt;
  final Map<String, dynamic> payload;

   factory Home.fromBase64(storage, String jwt) =>
    Home(
      storage,
      jwt,
      json.decode(
        ascii.decode(
          base64.decode(base64.normalize(jwt.split(".")[1]))
        )
      )
    );

  Home(this.storage, this.jwt, this.payload);

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

    // TESTING
    createFakeUser(widget.store).then((value) {
      print("create fake user: " + value);
      return value;
    }).then((value) {
      getCabildos().then((value) {
        widget.store.dispatch(GetCabildos(value));
      });
    });

    _widgetOptions = [
      ActivityFeed("home"),
      Container(),
      SelfProfileScreen("5e87da07ce5ed1002a2df152"),
      ActivityFeed("home"),
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
