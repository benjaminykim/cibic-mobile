import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';


AppState appReducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is LogInSuccess) {
    newState.jwt = action.jwt;
    newState.isLogIn = true;
  } else if (action is LogInError) {
    newState.isLogIn = false;
  } else if (action is FetchFeedSuccess) {
    if (action.mode == "default") {
      newState.homeFeed = action.feed;
      newState.homeFeedError = false;
    } else if (action.mode == "public") {
      newState.publicFeed = action.feed;
      newState.publicFeedError = false;
    }
  } else if (action is FetchFeedError) {
    if (action.mode == "default") {
      newState.homeFeedError = true;
    } else if (action.mode == "public") {
      newState.publicFeedError = true;
    }
  } else if (action is FetchUserProfileSuccess) {
    newState.user = action.user;
    newState.userProfileError = false;
  } else if (action is FetchUserProfileError) {
    newState.userProfileError = true;
  } else if (action is FetchUserProfileFeedSuccess) {
    newState.userProfileFeed = action.feed;
    newState.userProfileError = false;
  } else if (action is FetchUserProfileFeedError) {
    newState.userProfileError = true;
  } else if (action is FetchForeignUserProfileSuccess) {
    newState.foreignUser = action.user;
    newState.foreignUserError = false;
  } else if (action is FetchForeignUserProfileError) {
    newState.foreignUserError = true;
  } else if (action is FetchForeignUserProfileFeedSuccess) {
    newState.foreignUserFeed = action.feed;
    newState.foreignUserError = false;
  } else if (action is FetchForeignUserProfileFeedError) {
    newState.foreignUserError = true;
  } else if (action is FetchCabildoProfileSuccess) {
    newState.cabildoProfile = action.cabildo;
    newState.cabildoProfileFeed = action.feed;
    newState.cabildoProfileError = false;
  } else if (action is FetchCabildoProfileError) {
    newState.cabildoProfileError = true;
  }  else if (action is FetchCabildoProfileClear) {
    newState.cabildoProfileError = false;
    newState.cabildoProfile = null;
    newState.cabildoProfileFeed = null;
  }
  return newState;
}