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
      store.dispatch(LogInLoading());
      await attemptLogin(action.email, action.password, store, next);
      if (store.state.loginState['isSuccess']) {
        String jwt = store.state.user['jwt'];
        await fetchFeed(jwt, FEED_HOME, 0, next);
        await fetchFeed(jwt, FEED_PUBLIC, 0, next);
        await fetchProfile(jwt, "selfUser", extractID(jwt).toString(), next);
        await fetchProfileFeed(jwt, extractID(jwt).toString(), 0, next);
        Navigator.pushReplacement(action.context,
            MaterialPageRoute(builder: (context) => Home(store)));
      }
    }
  } else if (action is RefreshApp) {
    String jwt;
    if (store.state.user['jwt'] != null &&
        store.state.user['jwt'] != "" &&
        store.state.user['jwt'] != action.jwt) {
      jwt = store.state.user['jwt'];
    } else {
      jwt = action.jwt;
    }
    next(LogInSuccess(jwt));
    await fetchFeed(jwt, FEED_HOME, 0, next);
    await fetchFeed(jwt, FEED_PUBLIC, 0, next);
    await fetchProfile(jwt, "selfUser", extractID(jwt).toString(), next);
    await fetchProfileFeed(jwt, extractID(jwt).toString(), 0, next);
    Navigator.pushReplacement(
        action.context, MaterialPageRoute(builder: (context) => Home(store)));
  } else if (action is PostRegisterAttempt) {
    await attemptRegister(action.email, action.password, action.firstName,
        action.lastName, action.telephone, store, action.context, next);
  } else if (action is FetchFeedAttempt) {
    await fetchFeed(store.state.user['jwt'], action.mode, action.offset, next);
  } else if (action is FetchProfileAttempt) {
    String jwt = store.state.user['jwt'];
    await fetchProfile(jwt, action.type, action.id.toString(), next);
  } else if (action is FetchProfileFeedAttempt) {
    String jwt = store.state.user['jwt'];
    if (action.reset == true) {
      await fetchProfileFeed(jwt, action.id.toString(), 0, next);
    } else {
      int offset = store.state.profileFeed.feed.length;
      if (offset % 20 == 0) {
        await fetchProfileFeed(jwt, action.id.toString(), offset, next);
      }
    }
  } else if (action is SubmitActivityAttempt) {
    await postActivity(action, store.state.user['jwt'], next, store);
  } else if (action is SubmitActivitySuccess) {
    String jwt = store.state.user['jwt'];
    await fetchFeed(jwt, FEED_HOME, 0, next);
    await fetchFeed(jwt, FEED_PUBLIC, 0, next);
    await fetchProfileFeed(jwt, extractID(jwt).toString(), 0, next);
  } else if (action is SubmitCabildoAttempt) {
    await postCabildo(action, store.state.user['jwt'], next, store);
  } else if (action is SubmitCabildoSuccess) {
    String jwt = store.state.user['jwt'];
    await fetchProfile(jwt, "selfUser", extractID(jwt).toString(), next);
  } else if (action is PostPollAttempt) {
    await postPollVote(action.activity, store.state.user['jwt'],
        action.reactValue, store.state.user['id'], action.mode, next);
  } else if (action is PostReactionAttempt) {
    await postReaction(action.activity, store.state.user['jwt'],
        action.reactValue, store.state.user['idUser'], action.mode, next);
  } else if (action is PostSaveAttempt) {
    await postSaveActivity(
        action.activityId, store.state.user['jwt'], action.save, next, store);
  } else if (action is PostSearchAttempt) {
    if (action.reset == true) {
      await postSearchQuery(store.state.user['jwt'], 0, action.query, 0, next);
      await postSearchQuery(store.state.user['jwt'], 0, action.query, 1, next);
      await postSearchQuery(store.state.user['jwt'], 0, action.query, 2, next);
      await postSearchQuery(store.state.user['jwt'], 0, action.query, 3, next);
    }
  } else if (action is PostSearchAppendAttempt) {
    switch (action.mode) {
      case 0:
        await postSearchQuery(store.state.user['jwt'],
            store.state.search['user'].length, action.query, 0, next);
        break;
      case 1:
        await postSearchQuery(store.state.user['jwt'],
            store.state.search['cabildo'].length, action.query, 1, next);
        break;
      case 2:
        await postSearchQuery(store.state.user['jwt'],
            store.state.search['activity'].length, action.query, 2, next);
        break;
      case 3:
        await postSearchQuery(store.state.user['jwt'],
            store.state.search['tag'].length, action.query, 3, next);
        break;
    }
  }
}
