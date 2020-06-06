import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
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
  }
  if (action is VoteLock) {
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
    }
  } else if (action is FetchFeedAppend) {
    if (action.mode == FEED_HOME) {
      newState.feeds['home'].feed.addAll(action.feed.feed);
      newState.feedState['homeError'] = false;
    } else if (action.mode == FEED_PUBLIC) {
      newState.feeds['public'].feed.addAll(action.feed.feed);
      newState.feedState['publicError'] = false;
    } else if (action.mode == FEED_USER) {
      newState.feeds['selfUser'].feed.addAll(action.feed.feed);
      newState.feedState['selfUserError'] = false;
    }
  } else if (action is FetchFeedError) {
    if (action.mode == FEED_HOME) {
      newState.feedState['homeError'] = true;
    } else if (action.mode == FEED_PUBLIC) {
      newState.feedState['publicError'] = true;
    } else if (action.mode == FEED_USER) {
      newState.feedState['selfUserError'] = true;
    }
  } else if (action is FetchProfileSuccess) {
    newState.profile = action.profile;
    newState.profileState = Status.isSuccess;
  } else if (action is FetchProfileError) {
    newState.profileState = Status.isError;
  } else if (action is FetchProfileFeedSuccess) {
    newState.profileFeed = action.feed;
    newState.profileState = Status.isSuccess;
  } else if (action is FetchProfileFeedAppend) {
    newState.profileFeed.feed.addAll(action.feed.feed);
    newState.profileState = Status.isSuccess;
  } else if (action is FetchProfileFeedError) {
    newState.profileState = Status.isError;
  } else if (action is SubmitActivitySuccess) {
  } else if (action is PostReactionSuccess) {
    List<FeedModel> feeds = orderFeeds(newState, action.mode);

    if (action.mode == -1) {
      if (action.activityId == null || action.reaction == null) {
      } else {
        for (int i = 0; i < newState.search['activity'].length; i++) {
          if (newState.search['activity'][i].id == action.activityId) {
            if (newState.search['activity'][i].reactions == null) {
              newState.search['activity'][i].reactions = [action.reaction];
            } else {
              newState.search['activity'][i].reactions.add(action.reaction);
            }
          }
          break;
        }
      }
    }
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] =
          addActivityReaction(action.activityId, action.reaction, feeds[i]);
    }
  } else if (action is PostReactionUpdate) {
    List<FeedModel> feeds = orderFeeds(newState, action.mode);

    if (action.mode == -1) {
      if (action.activityId == null) {
      } else {
        for (int i = 0; i < newState.search['activity'].length; i++) {
          if (newState.search['activity'][i].id == action.activityId) {
            for (int j = 0;
                j < newState.search['activity'][i].reactions.length;
                j++) {
              if (action.reactionId ==
                  newState.search['activity'][i].reactions[j].id) {
                newState.search['activity'][i].reactions[j].value =
                    action.reactValue;
              }
              break;
            }
          }
          break;
        }
      }
    }
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = updateActivityReaction(action.activityId, action.reactionId,
          newState.user['idUser'], action.reactValue, feeds[i]);
    }
  } else if (action is PostReactionError) {
  } else if (action is PostPollSuccess) {
    List<FeedModel> feeds = orderFeeds(newState, action.mode);

    if (action.mode == -1) {
      if (action.activityId == null || action.vote == null) {
      } else {
        for (int i = 0; i < newState.search['activity'].length; i++) {
          if (newState.search['activity'][i].id == action.activityId) {
            if (newState.search['activity'][i].votes == null) {
              newState.search['activity'][i].votes = [action.vote];
            } else {
              newState.search['activity'][i].votes.add(action.vote);
            }
          }
          break;
        }
      }
    }
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = addPollVote(action.activityId, action.vote, feeds[i]);
    }
  } else if (action is PostPollUpdate) {
    List<FeedModel> feeds = orderFeeds(newState, action.mode);
    int idUser = extractID(newState.user['jwt']);
    if (action.mode == -1) {
      if (action.activityId == null) {
      } else {
        for (int i = 0; i < newState.search['activity'].length; i++) {
          if (newState.search['activity'][i].id == action.activityId) {
            for (int j = 0;
                j < newState.search['activity'][i].votes.length;
                j++) {
              if (action.voteId ==
                  newState.search['activity'][i].votes[j]['id']) {
                newState.search['activity'][i].votes[j]['value'] =
                    action.reactValue;
              }
              break;
            }
          }
          break;
        }
      }
    }
    for (int i = 0; i < feeds.length; i++) {
      feeds[i] = updatePollVote(action.activityId, action.voteId, idUser,
          action.reactValue, feeds[i]);
    }
  } else if (action is PostPollError) {
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
      case 3:
        newState.search['tag'] = action.resultTag;
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

FeedModel addPollVote(
    int activityId, Map<String, dynamic> vote, FeedModel feed) {
  if (feed == null || feed.feed == null || activityId == null || vote == null)
    return feed;
  print("activityID: $activityId");
  for (int i = 0; i < feed.feed.length; i++) {
    print("${feed.feed[i].id}");
    if (feed.feed[i].id == activityId) {
      print(vote);
      feed.feed[i].votes.add(vote);
      return feed;
    }
  }
  return feed;
}

FeedModel updatePollVote(
    int activityId, int voteId, int userId, int reactValue, FeedModel feed) {
  if (feed == null ||
      feed.feed == null ||
      activityId == null ||
      voteId == null ||
      userId == null) return feed;
  for (int i = 0; i < feed.feed.length; i++) {
    if (feed.feed[i].id == activityId) {
      for (int j = 0; j < feed.feed[i].votes.length; j++) {
        if (feed.feed[i].votes[j]['id'] == voteId &&
            feed.feed[i].votes[j]['userId'] == userId) {
          feed.feed[i].votes[j]['value'] = reactValue;
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
    newState.feeds['home'],
    newState.feeds['public'],
    newState.profileFeed,
  ];
  return feeds;
}
