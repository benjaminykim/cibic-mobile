import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/redux/middleware/thunk_activity.dart';
import 'package:cibic_mobile/src/redux/middleware/thunk_feed.dart';
import 'package:cibic_mobile/src/redux/middleware/thunk_menu_overlay.dart';
import 'package:cibic_mobile/src/redux/middleware/thunk_profile.dart';
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
  } else if (action is FetchForeignUserProfileAttempt) {
    await fetchForeignUserProfile(store.state.jwt, next, action.idUser);
    await fetchForeignUserProfileFeed(store.state.jwt, next, action.idUser);
  } else if (action is SubmitActivityAttempt) {
    await postActivity(action, store.state.jwt, next, store);
  } else if (action is SubmitActivitySuccess) {
    await fetchUserProfile(store.state.jwt, next);
    await fetchUserProfileFeed(store.state.jwt, next);
  } else if (action is SubmitCabildoAttempt) {
    await postCabildo(action, store.state.jwt, next, store);
  } else if (action is SubmitCabildoSuccess) {
    await fetchUserProfile(store.state.jwt, next);
  } else if (action is FetchCabildoProfileAttempt) {
    await fetchCabildoProfile(store.state.jwt, action.idCabildo, next);
  } else if (action is PostReactionAttempt) {
    await postReaction(action.activity, store.state.jwt, action.reactValue, store.state.idUser, action.mode, next);
  } else if (action is PostCommentAttempt) {
    await postComment(action.idActivity, store.state.jwt, action.content, action.mode, next);
  }
}