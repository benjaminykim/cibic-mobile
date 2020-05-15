
import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';

void apiMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) async {
	if (action is LogInAttempt) {
    String email = action.email;
    String password = action.password;

    Map requestBody = {
      'email': '$email',
      'password': '$password'
    };
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_LOGIN));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(requestBody)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    if (response.statusCode == 201) {
      final responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jwtResponse = jsonDecode(responseBody);
      String jwt = jwtResponse['access_token'];
      final storage = FlutterSecureStorage();
      storage.write(key: "jwt", value: jwt);
      next(LogInSuccess(jwt));
    } else {
      next(LogInError(response.statusCode));
    }
  }
}
