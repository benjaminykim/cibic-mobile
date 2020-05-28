import 'dart:convert';
import 'dart:io';
import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';

attemptLogin(String email, String password, NextDispatcher next) async {
  Map requestBody = {'email': '$email', 'password': '$password'};
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

postCabildoFollow(String jwt, int cabildoId, NextDispatcher next) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_FOLLOW_CABILDO));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"cabildoId": cabildoId})));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: followCabildo ${response.statusCode.toString()}");
  if (response.statusCode == 201) {
    next(PostCabildoFollowSuccess(1, cabildoId));
  } else {
    next(PostCabildoFollowError(response.statusCode.toString()));
  }
}

postCabildoUnfollow(String jwt, int cabildoId, NextDispatcher next) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_UNFOLLOW_CABILDO));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"cabildoId": cabildoId})));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: unFollowCabildo ${response.statusCode.toString()}");
  if (response.statusCode == 201) {
    next(PostCabildoFollowSuccess(-1, cabildoId));
  } else {
    next(PostCabildoFollowError(response.statusCode.toString()));
  }
}

getFirebaseToken(String jwt, NextDispatcher next) async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );
  // _firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(
  //         sound: true, badge: true, alert: true, provisional: true));
  // _firebaseMessaging.onIosSettingsRegistered
  //     .listen((IosNotificationSettings settings) {
  //   print("Settings registered: $settings");
  // });
  await _firebaseMessaging.getToken().then((String token) async {
    assert(token != null);
    print(token);
     HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_FIREBASE));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.add(utf8.encode(json.encode({"device_id": token})));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: send firebase token ${response.statusCode.toString()}");
  if (response.statusCode == 201) {
    next(FireBaseTokenSuccess(token, _firebaseMessaging));
  } else {
    next(FireBaseTokenError(response.statusCode.toString()));
  }
  });
}
