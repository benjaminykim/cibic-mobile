
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';


AppState appReducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is AppUser) {
    newState.idUser = action.payload['id'];
    newState.jwt = action.payload['jwt'];
    newState.firstName = action.payload['firstName'];
    newState.lastName = action.payload['lastName'];
    newState.followers = action.payload['followers'];
    newState.following = action.payload['following'];
    newState.cabildos = action.payload['cabildos'];
  } else if (action is LogInSuccess) {
    newState.jwt = action.jwt;
    newState.isLogIn = true;
  } else if (action is LogInError) {
    newState.isLogIn = false;
  } else if (action is FetchHomeFeed) {
    newState.homeFeed = action.payload;
  } else if (action is FetchPublicFeed) {
    newState.publicFeed = action.payload;
  } else if (action is FetchUserFeed) {
    newState.userProfileFeed = action.payload;
  }
  return newState;
}