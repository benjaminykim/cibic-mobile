import 'package:cibic_mobile/src/redux/middleware/thunk_feed.dart';
import 'package:cibic_mobile/src/redux/middleware/thunk_user.dart';
import 'package:redux/redux.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';

void apiMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is LogInAttempt) {
    await attemptLogin(action.email, action.password, next);
    if (store.state.isLogIn) {
      String jwt = store.state.jwt;
      await fetchFeed(jwt, "default", next);
      await fetchFeed(jwt, "public", next);
      await fetchUserProfile(store.state.jwt, next);
      await fetchUserProfileFeed(store.state.jwt, next);
    }
  } else if (action is FetchFeedAttempt) {
    await fetchFeed(store.state.jwt, action.mode, next);
  } else if (action is FetchUserProfileAttempt) {
    await fetchUserProfile(store.state.jwt, next);
    await fetchUserProfileFeed(store.state.jwt, next);
  }
}
