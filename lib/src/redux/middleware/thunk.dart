import 'package:cibic_mobile/src/onboard/home.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/redux/middleware/api_activity.dart';
import 'package:cibic_mobile/src/redux/middleware/api_feed.dart';
import 'package:cibic_mobile/src/redux/middleware/api_menu_overlay.dart';
import 'package:cibic_mobile/src/redux/middleware/api_profile.dart';
import 'package:cibic_mobile/src/redux/middleware/api_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_feed.dart';

void apiMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is LogInAttempt) {
    if (store.state.loginState['isLoading'] == false &&
        store.state.loginState['isSuccess'] == false) {
      print("LOGIN ATTEMPT");
      await store.dispatch(LogInLoading());
      await attemptLogin(action.email, action.password, store, next);
      if (store.state.loginState['isSuccess']) {
        print("LOGIN SUCCESS");
        String jwt = store.state.user['jwt'];
        await fetchFeed(jwt, FEED_HOME, next);
        await fetchFeed(jwt, FEED_PUBLIC, next);
        await fetchProfile(jwt, "selfUser", extractID(jwt).toString(), next);
        await fetchProfileFeed(
            jwt, "selfUser", extractID(jwt).toString(), next);
        print("LOGIN STATE LOAD FINISH");
        Navigator.pushReplacement(action.context,
            MaterialPageRoute(builder: (context) => Home(store)));
      }
    }
  } else if (action is RefreshApp) {
    print("App Refreshed");
    print("action's jwt: ${action.jwt}");
    print("store's jwt: ${store.state.user['jwt']}");
    String jwt;
    if (store.state.user['jwt'] != null &&
        store.state.user['jwt'] != "" &&
        store.state.user['jwt'] != action.jwt) {
      jwt = store.state.user['jwt'];
    } else {
      jwt = action.jwt;
    }
    print("calling log in success");
    next(LogInSuccess(jwt));
    store.dispatch(LogInSuccess(jwt));
    await fetchFeed(jwt, FEED_HOME, next);
    await fetchFeed(jwt, FEED_PUBLIC, next);
    await fetchProfile(jwt, "selfUser", extractID(jwt).toString(), next);
    await fetchProfileFeed(jwt, "selfUser", extractID(jwt).toString(), next);
    Navigator.pushReplacement(
        action.context, MaterialPageRoute(builder: (context) => Home(store)));
  } else if (action is PostRegisterAttempt) {
    await attemptRegister(action.email, action.password, action.firstName,
        action.lastName, action.telephone, store, action.context, next);
  } else if (action is FetchFeedAttempt) {
    await fetchFeed(store.state.user['jwt'], action.mode, next);
  } else if (action is FetchProfileAttempt) {
    String jwt = store.state.user['jwt'];
    await fetchProfile(jwt, action.type, action.id.toString(), next);
  } else if (action is FetchProfileFeedAttempt) {
    String jwt = store.state.user['jwt'];
    await fetchProfileFeed(jwt, action.type, action.id.toString(), next);
  } else if (action is SubmitActivityAttempt) {
    await postActivity(action, store.state.user['jwt'], next, store);
  } else if (action is SubmitActivitySuccess) {
    String jwt = store.state.user['jwt'];
    await fetchFeed(jwt, FEED_HOME, next);
    await fetchFeed(jwt, FEED_PUBLIC, next);
    await fetchProfileFeed(jwt, "selfUser", extractID(jwt).toString(), next);
  } else if (action is SubmitCabildoAttempt) {
    await postCabildo(action, store.state.user['jwt'], next, store);
  } else if (action is SubmitCabildoSuccess) {
    String jwt = store.state.user['jwt'];
    await fetchProfile(jwt, "selfUser", extractID(jwt).toString(), next);
  } else if (action is PostReactionAttempt) {
    await postReaction(action.activity, store.state.user['jwt'],
        action.reactValue, store.state.user['idUser'], action.mode, next);
  } else if (action is PostSaveAttempt) {
    await postSaveActivity(
        action.activityId, store.state.user['jwt'], action.save, next, store);
  } else if (action is FireBaseTokenAttempt) {
    //await getFirebaseToken(store.state.user['jwt'], next);
  } else if (action is PostSearchAttempt) {
    await postSearchQuery(store.state.user['jwt'], action.query, 0, next);
    await postSearchQuery(store.state.user['jwt'], action.query, 1, next);
    await postSearchQuery(store.state.user['jwt'], action.query, 2, next);
    await postSearchQuery(store.state.user['jwt'], action.query, 3, next);
  }
}
