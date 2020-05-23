import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
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
    if (action.mode == FEED_HOME) {
      newState.homeFeed = action.feed;
      newState.homeFeedError = false;
    } else if (action.mode == FEED_PUBLIC) {
      newState.publicFeed = action.feed;
      newState.publicFeedError = false;
    }
  } else if (action is FetchFeedError) {
    if (action.mode == FEED_HOME) {
      newState.homeFeedError = true;
    } else if (action.mode == FEED_PUBLIC) {
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
    List<FeedModel> feeds = orderFeeds(newState, action.mode);

    for (int i = 0; i < feeds.length; i++) {
      feeds[i] =
          addActivityReaction(action.activityId, action.reaction, feeds[i]);
    }
  } else if (action is PostReactionUpdate) {
    List<FeedModel> feeds = orderFeeds(newState, action.mode);

    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = updateActivityReaction(action.activityId, action.reactionId,
          newState.idUser, action.reactValue, feeds[i]);
    }
  } else if (action is PostReactionError) {
    // String error;
  } else if (action is PostCommentSuccess) {
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] =
          addActivityComment(action.idActivity, action.comment, feeds[i]);
    }
  } else if (action is PostCommentError) {
    // String error;
  } else if (action is PostReplySuccess) {
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = addCommentReply(
          action.idActivity, action.idComment, action.reply, feeds[i]);
    }
  } else if (action is PostReplyError) {
    // String error;
  }
  return newState;
}

FeedModel addActivityReaction(
    String activityId, ReactionModel reaction, FeedModel feed) {
  if (feed == null ||
      feed.feed == null ||
      activityId == null ||
      reaction == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      feed.feed[i].reactions.add(reaction);
      return feed;
    }
  }
  return feed;
}

FeedModel updateActivityReaction(String activityId, String reactionId,
    String userId, int reactValue, FeedModel feed) {
  if (feed == null ||
      feed.feed == null ||
      activityId == null ||
      reactionId == null ||
      userId == null) return feed;
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

FeedModel addActivityComment(
    String activityId, CommentModel comment, FeedModel feed) {
  if (feed == null || feed.feed == null || activityId == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      feed.feed[i].comments.insert(0, comment);
      return feed;
    }
  }
  return feed;
}

FeedModel addCommentReply(
    String activityId, String commentId, ReplyModel reply, FeedModel feed) {
  if (feed == null || feed.feed == null || activityId == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      for (int j = 0; j < feed.feed[i].comments.length; j++) {
        if (feed.feed[i].comments[j].id == commentId) {
          feed.feed[i].comments[j].reply.insert(0, reply);
          return feed;
        }
      }
      return feed;
    }
  }
  return feed;
}

List<FeedModel> orderFeeds(AppState newState, int mode) {
  List<FeedModel> feeds = [
    newState.homeFeed,
    newState.publicFeed,
    newState.userProfileFeed,
    newState.cabildoProfileFeed,
    newState.foreignUserFeed
  ];
  switch (mode) {
    case FEED_PUBLIC:
      feeds.removeAt(FEED_PUBLIC);
      feeds.insert(0, newState.publicFeed);
      break;
    case FEED_USER:
      feeds.removeAt(FEED_USER);
      feeds.insert(0, newState.userProfileFeed);
      break;
    case FEED_CABILDO:
      feeds.removeAt(FEED_CABILDO);
      feeds.insert(0, newState.cabildoProfileFeed);
      break;
    case FEED_FOREIGN:
      feeds.removeAt(FEED_FOREIGN);
      feeds.insert(0, newState.foreignUserFeed);
      break;
  }
  return feeds;
}
