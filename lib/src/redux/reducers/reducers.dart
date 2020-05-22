import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/utils.dart';

AppState appReducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is LogInSuccess) {
    newState.jwt = action.jwt;
    newState.isLogIn = true;
    newState.idUser = extractID(action.jwt);
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
  } else if (action is FetchCabildoProfileClear) {
    newState.cabildoProfileError = false;
    newState.cabildoProfile = null;
    newState.cabildoProfileFeed = null;
  } else if (action is FetchForeignUserProfileClear) {
    newState.foreignUserError = false;
    newState.foreignUser = null;
    newState.foreignUserFeed = null;
  } else if (action is PostReactionSuccess) {
    newState.homeFeed = addActivityReaction(action.activityId, action.reaction, newState.homeFeed);
    newState.publicFeed = addActivityReaction(action.activityId, action.reaction, newState.publicFeed);
  } else if (action is PostReactionUpdate) {
    newState.homeFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.homeFeed);
    newState.publicFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.publicFeed);
  } else if (action is PostReactionError) {
    // String error;
  }
  return newState;
}

FeedModel addActivityReaction(String activityId, ReactionModel reaction, FeedModel feed) {
  print("add reaction");
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      feed.feed[i].reactions.add(reaction);
      return feed;
    }
  }
  return feed;
}

FeedModel updateActivityReaction(String activityId, String reactionId, String userId, int reactValue, FeedModel feed) {
  print("update reaction");
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      for (int j = 0; j < feed.feed[i].reactions.length; j++) {
        if (feed.feed[i].reactions[j].id == reactionId) {
          feed.feed[i].reactions[j].value = reactValue;
          return feed;
        }
      }
      feed.feed[i].reactions.add(ReactionModel(reactionId, userId, reactValue));
      return feed;
    }
  }
  return feed;
}