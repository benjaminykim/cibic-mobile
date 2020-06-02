import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';
import 'package:cibic_mobile/src/onboard/onboard.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_feed.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:flutter/material.dart';

AppState appReducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is IsLoading) {
    newState.isLoading = true;
  } if (action is VoteLock) {
    newState.feedState['voteLock'] = action.lock;
  } else if (action is LogOut) {
    newState = AppState.initial();
  } else if (action is PostRegisterSuccess) {
    newState.user['firstName'] = action.firstName;
    newState.user['lastName'] = action.lastName;
    newState.registerState['isSuccess'] = true;
    newState.registerState['isError'] = false;
    Navigator.pushReplacement(action.context,
        MaterialPageRoute(builder: (context) => Onboard(action.store)));
  } else if (action is PostRegisterError) {
    newState.registerState['isSuccess'] = false;
    newState.registerState['isError'] = true;
  } else if (action is LogInLoading) {
    newState.loginState['isLoading'] = true;
    newState.loginState['isError'] = false;
    newState.loginState['isSuccess'] = false;
  } else if (action is LogInSuccess) {
    newState.user['jwt'] = action.jwt;
    print("loginsuccess reducer ${action.jwt}");
    newState.user['idUser'] = extractID(action.jwt);
    newState.loginState['isLoading'] = false;
    newState.loginState['isError'] = false;
    newState.loginState['isSuccess'] = true;
  } else if (action is LogInError) {
    newState.loginState['isLoading'] = false;
    newState.loginState['isError'] = true;
    newState.loginState['isSuccess'] = false;
  } else if (action is FetchFeedSuccess) {
    if (action.mode == FEED_HOME) {
      newState.feeds['home'] = action.feed;
      newState.feedState['homeError'] = false;
    } else if (action.mode == FEED_PUBLIC) {
      newState.feeds['public'] = action.feed;
      newState.feedState['publicError'] = false;
    } else if (action.mode == FEED_USER) {
      newState.feeds['selfUser'] = action.feed;
      newState.feedState['selfUserError'] = false;
    } else if (action.mode == FEED_SAVED) {
      newState.feeds['saved'] = action.feed;
      newState.feedState['savedError'] = false;
    }
  } else if (action is FetchFeedError) {
    if (action.mode == FEED_HOME) {
      newState.feedState['homeError'] = true;
    } else if (action.mode == FEED_PUBLIC) {
      newState.feedState['publicError'] = true;
    } else if (action.mode == FEED_USER) {
      newState.feedState['selfUserError'] = true;
    } else if (action.mode == FEED_SAVED) {
      newState.feedState['savedError'] = true;
    }
  } else if (action is FetchProfileSuccess) {
    print("reducer profile type: ${action.type}");
    newState.profile[action.type] = action.profile;
    newState.profileState[action.type + "IsSuccess"] = true;
    newState.profileState[action.type + 'IsLoading'] = false;
    newState.profileState[action.type + 'IsError'] = false;
  } else if (action is FetchProfileError) {
    newState.profileState[action.type + 'IsSuccess'] = false;
    newState.profileState[action.type + 'IsLoading'] = false;
    newState.profileState[action.type + 'IsError'] = true;
  } else if (action is FetchProfileFeedSuccess) {
    print("reducer feed type: ${action.type}");
    newState.feeds[action.type] = action.feed;
    newState.feedState[action.type + "IsLoading"] = false;
    newState.feedState[action.type + "IsSuccess"] = true;
    newState.feedState[action.type + "IsError"] = false;
  } else if (action is FetchProfileFeedError) {
    newState.feedState[action.type + "IsLoading"] = false;
    newState.feedState[action.type + "IsSuccess"] = false;
    newState.feedState[action.type + "IsError"] = true;
  } else if (action is ClearProfile) {
    newState.profile[action.type] = null;
    newState.feeds[action.type] = null;
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
          newState.user['idUser'], action.reactValue, feeds[i]);
    }
  } else if (action is PostReactionError) {
    // String error;
  } else if (action is PostCommentSuccess) {
    print("comment add success");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < 1; i++) {
      feeds[i] =
          addActivityComment(action.idActivity, action.comment, feeds[i]);
    }
  } else if (action is PostCommentError) {
    // String error;
  } else if (action is PostReplySuccess) {
    print("reply add success");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < 1; i++) {
      feeds[i] = addCommentReply(
          action.idActivity, action.idComment, action.reply, feeds[i]);
    }
  } else if (action is PostReplyError) {
    // String error;
  } else if (action is PostCommentVoteSuccess) {
    print("comment vote success");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < 1; i++) {
      feeds[i] = addCommentVote(
          action.activityId, action.commentId, action.vote, feeds[i]);
    }
  } else if (action is PostCommentVoteUpdate) {
    print("comment vote update");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < 1; i++) {
      feeds[i] = updateCommentVote(action.activityId, action.commentId,
          action.voteId, action.value, feeds[i]);
    }
  } else if (action is PostCommentVoteError) {
  } else if (action is PostReplyVoteSuccess) {
    print("reply vote success");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < 1; i++) {
      feeds[i] = addReplyVote(
          action.activityId, action.replyId, action.vote, feeds[i]);
    }
  } else if (action is PostReplyVoteUpdate) {
    print("reply vote update");
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    for (int i = 0; i < 1; i++) {
      feeds[i] = updateReplyVote(action.activityId, action.replyId,
          action.voteId, action.value, feeds[i]);
    }
  } else if (action is PostReplyVoteError) {
  } else if (action is FireBaseTokenSuccess) {
    newState.user['firebaseToken'] = action.token;
    newState.user['firebaseManager'] = action.firebase;
  } else if (action is PostSearchSuccess) {
    switch (action.mode) {
      case 0:
        newState.search['user'] = action.resultUser;
        break;
      case 1:
        newState.search['cabildo'] = action.resultCabildo;
        break;
      case 2:
        newState.search['activity'] = action.resultActivity;
        break;
    }
  } else if (action is PostSearchError) {}
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
          print("insertion comment reply");
          if (feed.feed[i].comments[j].replies == null) {
            feed.feed[i].comments[j].replies = [reply];
          } else {
            feed.feed[i].comments[j].replies.insert(0, reply);
          }
          return feed;
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
              feed.feed[i].comments[j].score -=
                  feed.feed[i].comments[j].votes[k]['value'];
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
    int activityId, int replyId, Map<String, dynamic> vote, FeedModel feed) {
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
  if (feed == null || feed.feed == null || activityId == null || voteId == null)
    return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      print('found reply activity');
      for (int j = 0; j < feed.feed[i].comments.length; j++) {
        for (int k = 0; k < feed.feed[i].comments[j].replies.length; k++) {
          if (feed.feed[i].comments[j].replies[k].id == replyId) {
            print('found reply comment');
            for (int l = 0;
                l < feed.feed[i].comments[j].replies[k].votes.length;
                l++) {
              if (feed.feed[i].comments[j].replies[k].votes[l]['id'] ==
                  voteId) {
                print('found reply votes ');
                print(feed.feed[i].comments[j].replies[k].score);
                print(feed.feed[i].comments[j].replies[k].votes[l]['value']);
                feed.feed[i].comments[j].replies[k].score -=
                    feed.feed[i].comments[j].replies[k].votes[l]['value'];
                feed.feed[i].comments[j].replies[k].votes[l]['value'] = value;
                feed.feed[i].comments[j].replies[k].score += value;
                print(feed.feed[i].comments[j].replies[k].score);
                print(feed.feed[i].comments[j].replies[k].votes[l]['value']);
                return feed;
              }
            }
            return feed;
          }
        }
      }
      return feed;
    }
  }
  print("update reply vote");
  return feed;
}

List<FeedModel> orderFeeds(AppState newState, int mode) {
  List<FeedModel> feeds = [
    newState.feeds['home'],
    newState.feeds['public'],
    newState.feeds['selfUser'],
    newState.feeds['foreignUser'],
    newState.feeds['saved'],
  ];
  feeds.insert(0, feeds.removeAt(mode));
  return feeds;
}
