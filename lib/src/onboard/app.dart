import 'dart:async';
import 'package:cibic_mobile/src/onboard/home.dart';
import 'package:cibic_mobile/src/onboard/welcome.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/redux/middleware/thunk.dart';
import 'package:cibic_mobile/src/redux/reducers/reducers.dart';
import 'package:cibic_mobile/src/widgets/menu/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;

final storage = FlutterSecureStorage();

class App extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, apiMiddleware],
  );

  App();

  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null || jwt is List) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: cibicTheme,
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoadingScreen();
            }
            if (snapshot.data != "") {
              var str = snapshot.data;
              var jwt = str.split(".");

              if (jwt.length != 3) {
                return Welcome();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  store.dispatch(RefreshApp(str, context));
                  return Home(store);
                } else {
                  return Welcome();
                }
              }
            } else {
              return Welcome();
            }
          },
        ),
      ),
    );
  }
}
