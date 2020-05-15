
import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class AppUser {
  final Map<String, dynamic> payload;
  AppUser(this.payload);
}

ThunkAction<String> attemptLogin(String email, String password) {
   return (Store<String> store) async {
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
    print("REDUX THUNK WORKS");

    if (response.statusCode == 201) {
      final responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jwtResponse = jsonDecode(responseBody);
      String jwt = jwtResponse['access_token'];
      final storage = FlutterSecureStorage();
      storage.write(key: "jwt", value: jwt);
      return (LogInSuccess(jwt));
    } else {
      store.dispatch(LogInError(response.statusCode));
      return (LogInError(response.statusCode.toString()));
    }
   };
 }

class LogInAttempt {
  String email;
  String password;

  String getEmail() {
    return this.email;
  }

  String getPassword() {
    return this.password;
  }

  LogInAttempt(this.email, this.password);
}

class LogInSuccess {
  String jwt;
  LogInSuccess(this.jwt);
}

class LogInError {
  var payload;
  LogInError(this.payload);
}

class FetchHomeFeed {
  List<dynamic> payload;
  FetchHomeFeed(this.payload);
}

class FetchPublicFeed {
  List<dynamic> payload;
  FetchPublicFeed(this.payload);
}

class FetchUserFeed {
  List<dynamic> payload;
  FetchUserFeed(this.payload);
}