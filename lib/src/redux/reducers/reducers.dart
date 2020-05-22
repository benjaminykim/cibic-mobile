import 'package:cibic_mobile/src/models/comment_model.dart';
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
    switch (action.mode) {
      case 0:
        newState.homeFeed = addActivityReaction(action.activityId, action.reaction, newState.homeFeed);
        newState.publicFeed = addActivityReaction(action.activityId, action.reaction, newState.publicFeed);
        newState.userProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.userProfileFeed);
        newState.cabildoProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.cabildoProfileFeed);
        newState.foreignUserFeed = addActivityReaction(action.activityId, action.reaction, newState.foreignUserFeed);
        break;
      case 1:
        newState.publicFeed = addActivityReaction(action.activityId, action.reaction, newState.publicFeed);
        newState.homeFeed = addActivityReaction(action.activityId, action.reaction, newState.homeFeed);
        newState.userProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.userProfileFeed);
        newState.cabildoProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.cabildoProfileFeed);
        newState.foreignUserFeed = addActivityReaction(action.activityId, action.reaction, newState.foreignUserFeed);
        break;
      case 2:
        newState.userProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.userProfileFeed);
        newState.homeFeed = addActivityReaction(action.activityId, action.reaction, newState.homeFeed);
        newState.publicFeed = addActivityReaction(action.activityId, action.reaction, newState.publicFeed);
        newState.cabildoProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.cabildoProfileFeed);
        newState.foreignUserFeed = addActivityReaction(action.activityId, action.reaction, newState.foreignUserFeed);
        break;
      case 3:
        newState.cabildoProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.cabildoProfileFeed);
        newState.homeFeed = addActivityReaction(action.activityId, action.reaction, newState.homeFeed);
        newState.publicFeed = addActivityReaction(action.activityId, action.reaction, newState.publicFeed);
        newState.userProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.userProfileFeed);
        newState.foreignUserFeed = addActivityReaction(action.activityId, action.reaction, newState.foreignUserFeed);
        break;
      case 4:
        newState.foreignUserFeed = addActivityReaction(action.activityId, action.reaction, newState.foreignUserFeed);
        newState.homeFeed = addActivityReaction(action.activityId, action.reaction, newState.homeFeed);
        newState.publicFeed = addActivityReaction(action.activityId, action.reaction, newState.publicFeed);
        newState.userProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.userProfileFeed);
        newState.cabildoProfileFeed = addActivityReaction(action.activityId, action.reaction, newState.cabildoProfileFeed);
        break;
    }
  } else if (action is PostReactionUpdate) {
    switch (action.mode) {
      case 0:
        newState.homeFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.homeFeed);
        newState.publicFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.publicFeed);
        newState.userProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.userProfileFeed);
        newState.cabildoProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.cabildoProfileFeed);
        newState.foreignUserFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.foreignUserFeed);
        break;
      case 1:
        newState.publicFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.publicFeed);
        newState.homeFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.homeFeed);
        newState.userProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.userProfileFeed);
        newState.cabildoProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.cabildoProfileFeed);
        newState.foreignUserFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.foreignUserFeed);
        break;
      case 2:
        newState.userProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.userProfileFeed);
        newState.homeFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.homeFeed);
        newState.publicFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.publicFeed);
        newState.cabildoProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.cabildoProfileFeed);
        newState.foreignUserFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.foreignUserFeed);
        break;
      case 3:
        newState.cabildoProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.cabildoProfileFeed);
        newState.homeFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.homeFeed);
        newState.publicFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.publicFeed);
        newState.userProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.userProfileFeed);
        newState.foreignUserFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.foreignUserFeed);
        break;
      case 4:
        newState.foreignUserFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.foreignUserFeed);
        newState.homeFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.homeFeed);
        newState.publicFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.publicFeed);
        newState.userProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.userProfileFeed);
        newState.cabildoProfileFeed = updateActivityReaction(action.activityId, action.reactionId, newState.idUser, action.reactValue, newState.cabildoProfileFeed);
        break;
    }
  } else if (action is PostReactionError) {
    // String error;
  } else if (action is PostCommentSuccess) {
      switch (action.mode) {
        case 1:
          newState.homeFeed = addActivityComment(action.idActivity, action.comment, newState.homeFeed);
          newState.publicFeed = addActivityComment(action.idActivity, action.comment, newState.publicFeed);
          newState.userProfileFeed = addActivityComment(action.idActivity, action.comment, newState.userProfileFeed);
          newState.cabildoProfileFeed = addActivityComment(action.idActivity, action.comment, newState.cabildoProfileFeed);
          newState.foreignUserFeed = addActivityComment(action.idActivity, action.comment, newState.foreignUserFeed);
          break;
        case 2:
          newState.publicFeed = addActivityComment(action.idActivity, action.comment, newState.publicFeed);
          newState.homeFeed = addActivityComment(action.idActivity, action.comment, newState.homeFeed);
          newState.userProfileFeed = addActivityComment(action.idActivity, action.comment, newState.userProfileFeed);
          newState.cabildoProfileFeed = addActivityComment(action.idActivity, action.comment, newState.cabildoProfileFeed);
          newState.foreignUserFeed = addActivityComment(action.idActivity, action.comment, newState.foreignUserFeed);
          break;
        case 3:
          newState.userProfileFeed = addActivityComment(action.idActivity, action.comment, newState.userProfileFeed);
          newState.homeFeed = addActivityComment(action.idActivity, action.comment, newState.homeFeed);
          newState.publicFeed = addActivityComment(action.idActivity, action.comment, newState.publicFeed);
          newState.cabildoProfileFeed = addActivityComment(action.idActivity, action.comment, newState.cabildoProfileFeed);
          newState.foreignUserFeed = addActivityComment(action.idActivity, action.comment, newState.foreignUserFeed);
          break;
        case 4:
          newState.cabildoProfileFeed = addActivityComment(action.idActivity, action.comment, newState.cabildoProfileFeed);
          newState.homeFeed = addActivityComment(action.idActivity, action.comment, newState.homeFeed);
          newState.publicFeed = addActivityComment(action.idActivity, action.comment, newState.publicFeed);
          newState.userProfileFeed = addActivityComment(action.idActivity, action.comment, newState.userProfileFeed);
          newState.foreignUserFeed = addActivityComment(action.idActivity, action.comment, newState.foreignUserFeed);
          break;
        case 5:
          newState.foreignUserFeed = addActivityComment(action.idActivity, action.comment, newState.foreignUserFeed);
          newState.homeFeed = addActivityComment(action.idActivity, action.comment, newState.homeFeed);
          newState.publicFeed = addActivityComment(action.idActivity, action.comment, newState.publicFeed);
          newState.userProfileFeed = addActivityComment(action.idActivity, action.comment, newState.userProfileFeed);
          newState.cabildoProfileFeed = addActivityComment(action.idActivity, action.comment, newState.cabildoProfileFeed);
          break;
      }
  } else if (action is PostCommentError) {
    // String error;
  }
  return newState;
}

FeedModel addActivityReaction(String activityId, ReactionModel reaction, FeedModel feed) {
  if (feed == null || feed.feed == null || activityId == null || reaction == null)
    return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      feed.feed[i].reactions.add(reaction);
      return feed;
    }
  }
  return feed;
}

FeedModel updateActivityReaction(String activityId, String reactionId, String userId, int reactValue, FeedModel feed) {
  if (feed == null || feed.feed == null || activityId == null || reactionId == null || userId == null)
    return feed;
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


FeedModel addActivityComment(String activityId, CommentModel comment, FeedModel feed) {
  if (feed == null || feed.feed == null || activityId == null)
    return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      feed.feed[i].comments.insert(0, comment);
      return feed;
    }
  }
  return feed;
}