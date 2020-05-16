
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';


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
  }
  return newState;
}