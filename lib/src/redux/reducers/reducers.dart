import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_feed.dart';
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
    } else if (action.mode == FEED_SAVED) {
      newState.savedFeed = action.feed;
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
    print("comment add success");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] =
          addActivityComment(action.idActivity, action.comment, feeds[i]);
    }
  } else if (action is PostCommentError) {
    // String error;
  } else if (action is PostReplySuccess) {
    print("reply add success");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = addCommentReply(
          action.idActivity, action.idComment, action.reply, feeds[i]);
    }
  } else if (action is PostReplyError) {
    // String error;
  } else if (action is PostCommentVoteSuccess) {
    print("comment vote success");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = addCommentVote(
          action.activityId, action.commentId, action.vote, feeds[i]);
    }
  } else if (action is PostCommentVoteUpdate) {
    print("comment vote update");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = updateCommentVote(action.activityId, action.commentId,
          action.voteId, action.value, feeds[i]);
    }
  } else if (action is PostCommentVoteError) {
  } else if (action is PostReplyVoteSuccess) {
    print("reply vote success");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = addReplyVote(
          action.activityId, action.replyId, action.vote, feeds[i]);
    }
  } else if (action is PostReplyVoteUpdate) {
    print("reply vote update");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = updateReplyVote(action.activityId, action.replyId,
          action.voteId, action.value, feeds[i]);
    }
  } else if (action is PostReplyVoteError) {
  } else if (action is PostCabildoFollowSuccess) {
    // this is where we mutate state
    print("mutate state!");
  } else if (action is PostCabildoFollowError) {
    print("error in following/unfollowing cabildo");
  } else if (action is FireBaseTokenSuccess) {
    newState.firebaseToken = action.token;
    newState.firebaseManager = action.firebase;
  }
  return newState;
}

FeedModel addActivityReaction(
    int activityId, ReactionModel reaction, FeedModel feed) {
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

FeedModel updateActivityReaction(int activityId, int reactionId, int userId,
    int reactValue, FeedModel feed) {
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
    int activityId, CommentModel comment, FeedModel feed) {
  if (feed == null || feed.feed == null || activityId == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      feed.feed[i].comments.insert(0, comment);
      break;
    }
  }
  return feed;
}

FeedModel addCommentReply(
    int activityId, int commentId, ReplyModel reply, FeedModel feed) {
  if (feed == null || feed.feed == null || activityId == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      for (int j = 0; j < feed.feed[i].comments.length; j++) {
        if (feed.feed[i].comments[j].id == commentId) {
          feed.feed[i].comments[j].replies.insert(0, reply);
          break;
        }
      }
      break;
    }
  }
  return feed;
}

FeedModel addCommentVote(
    int activityId, int commentId, Map<String, int> vote, FeedModel feed) {
  if (feed == null ||
      feed.feed == null ||
      activityId == null ||
      commentId == null ||
      vote == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      for (int j = 0; j < feed.feed[i].comments.length; j++) {
        if (feed.feed[i].comments[j].id == commentId) {
          if (feed.feed[i].comments[j].votes == null) {
            feed.feed[i].comments[j].votes = [vote];
          } else {
            feed.feed[i].comments[j].votes.insert(0, vote);
          }
          feed.feed[i].comments[j].score += vote['value'];
          break;
        }
      }
      break;
    }
  }
  return feed;
}

FeedModel updateCommentVote(
    int activityId, int commentId, int voteId, int value, FeedModel feed) {
  if (feed == null ||
      feed.feed == null ||
      activityId == null ||
      commentId == null ||
      voteId == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      for (int j = 0; j < feed.feed[i].comments.length; j++) {
        if (feed.feed[i].comments[j].id == commentId) {
          for (int k = 0; k < feed.feed[i].comments[j].votes.length; k++) {
            if (feed.feed[i].comments[j].votes[k]['id'] == voteId) {
              feed.feed[i].comments[j].score -= feed.feed[i].comments[j].votes[k]['value'];
              feed.feed[i].comments[j].votes[k]['value'] = value;
              feed.feed[i].comments[j].score += value;
              print("found correct vote in comment");
              break;
            }
          }
          break;
        }
      }
      break;
    }
  }
  return feed;
}

FeedModel addReplyVote(
    int activityId, int replyId, Map<String, int> vote, FeedModel feed) {
  if (feed == null ||
      feed.feed == null ||
      activityId == null ||
      replyId == null ||
      vote == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      for (int j = 0; j < feed.feed[i].comments.length; j++) {
        for (int k = 0; k < feed.feed[i].comments[j].replies.length; k++) {
          if (feed.feed[i].comments[j].replies[k].id == replyId) {
            if (feed.feed[i].comments[j].replies[k].votes == null) {
              feed.feed[i].comments[j].replies[k].votes = [vote];
            } else {
              feed.feed[i].comments[j].replies[k].votes.insert(0, vote);
            }
            feed.feed[i].comments[j].replies[k].score += vote['value'];
            return feed;
          }
        }
      }
      break;
    }
  }
  return feed;
}

FeedModel updateReplyVote(
    int activityId, int replyId, int voteId, int value, FeedModel feed) {
  if (feed == null ||
      feed.feed == null ||
      activityId == null ||
      voteId == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      print('found reply activity');
      for (int j = 0; j < feed.feed[i].comments.length; j++) {
          for (int k = 0; k < feed.feed[i].comments[j].replies.length; k++) {
            if (feed.feed[i].comments[j].replies[k].id == replyId) {
              print('found reply comment');
              for (int l = 0; l < feed.feed[i].comments[j].replies[k].votes.length; l++) {
                if (feed.feed[i].comments[j].replies[k].votes[l]['id'] == voteId) {
                  print('found reply votes ');
                  feed.feed[i].comments[j].replies[k].score -= feed.feed[i].comments[j].replies[k].votes[l]['value'];
                  feed.feed[i].comments[j].replies[k].votes[l]['value'] = value;
                  feed.feed[i].comments[j].replies[k].score += value;
                  return feed;
                }
              }
            }
          }
      }
    }
  }
  print("update reply vote");
  return feed;
}

List<FeedModel> orderFeeds(AppState newState, int mode) {
  List<FeedModel> feeds = [
    newState.homeFeed,
    newState.publicFeed,
    newState.userProfileFeed,
    newState.cabildoProfileFeed,
    newState.foreignUserFeed,
    newState.savedFeed
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
    case FEED_SAVED:
      feeds.removeAt(FEED_SAVED);
      feeds.insert(0, newState.savedFeed);
      break;
  }
  return feeds;
}
