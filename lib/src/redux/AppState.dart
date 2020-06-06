import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';

enum Status { isLoading, isSuccess, isError, none }

class AppState {
  Map<String, dynamic> user;
  Map<String, FeedModel> feeds;
  UserModel profile;
  FeedModel profileFeed;
  Map<String, dynamic> search;
  Map<String, bool> loginState;
  Map<String, bool> registerState;
  Map<String, bool> feedState;
  // Map<String, bool> profileState;
  Status profileState;
  bool isLoading;

  AppState(
      this.user,
      this.feeds,
      this.profile,
      this.profileFeed,
      this.search,
      this.loginState,
      this.registerState,
      this.feedState,
      this.profileState,
      this.isLoading);

  AppState.fromAppState(AppState another) {
    user = another.user;
    feeds = another.feeds;
    profile = another.profile;
    profileFeed = another.profileFeed;
    search = another.search;
    loginState = another.loginState;
    registerState = another.registerState;
    feedState = another.feedState;
    profileState = another.profileState;
    isLoading = another.isLoading;
  }

  factory AppState.initial() {
    Map<String, dynamic> user = {
      'user': null,
      'idUser': 0,
      'jwt': "",
      'firebaseToken': "",
      'firebaseManager': null,
      'firstName': "",
      'lastName': "",
      'followers': [],
      'following': [],
      'cabildos': [],
    };

    Map<String, FeedModel> feeds = {
      'home': null,
      'public': null,
      'saved': null,
    };

    Map<String, bool> feedState = {
      'homeIsLoading': false,
      'homeIsSuccess': false,
      'homeIsError': false,
      'publicIsLoading': false,
      'publicIsSuccess': false,
      'publicIsError': false,
      'savedIsLoading': false,
      'savedIsSuccess': false,
      'savedIsError': false,
      'voteLock': false,
    };

    UserModel profile = UserModel.initial();
    FeedModel profileFeed = FeedModel.initial();
    Status profileState = Status.none;

/*
    Map<String, bool> profileState = {
      'selfUserIsLoading': false,
      'selfUserIsSuccess': false,
      'selfUserIsError': false,
    };
    */

    Map<String, dynamic> search = {
      'activity': List<ActivityModel>(),
      'cabildo': List<CabildoModel>(),
      'user': List<UserModel>(),
      'tag': List<Map<String, dynamic>>(),
      'isLoading': false,
      'isSuccess': false,
      'isError': false,
    };

    Map<String, bool> loginState = {
      'isSuccess': false,
      'isError': false,
      'isLoading': false,
    };

    Map<String, bool> registerState = {
      'isSuccess': false,
      'isError': false,
      'isLoading': false
    };

    return AppState(user, feeds, profile, profileFeed, search, loginState,
        registerState, feedState, profileState, false);
  }
}
