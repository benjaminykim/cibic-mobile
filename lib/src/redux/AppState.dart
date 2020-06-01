import 'package:cibic_mobile/src/models/feed_model.dart';

class AppState {
  Map<String, dynamic> user;
  Map<String, FeedModel> feeds;
  Map<String, dynamic> profile;
  Map<String, dynamic> search;
  Map<String, bool> loginState;
  Map<String, bool> registerState;
  Map<String, bool> feedState;
  Map<String, bool> profileState;
  bool isLoading;

  AppState(this.user, this.feeds, this.profile, this.search, this.loginState,
      this.registerState, this.feedState, this.profileState, this.isLoading);

  AppState.fromAppState(AppState another) {
    user = another.user;
    feeds = another.feeds;
    profile = another.profile;
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
      'selfUser': null,
      'foreignUser': null,
      'saved': null,
    };

    Map<String, bool> feedState = {
      'homeIsLoading': false,
      'homeIsSuccess': false,
      'homeIsError': false,
      'publicIsLoading': false,
      'publicIsSuccess': false,
      'publicIsError': false,
      'selfUserIsLoading': false,
      'selfUserIsSuccess': false,
      'selfUserIsError': false,
      'foreignUserIsLoading': false,
      'foreignUserIsSuccess': false,
      'foreignUserIsError': false,
      'savedIsLoading': false,
      'savedIsSuccess': false,
      'savedIsError': false,
    };

    Map<String, dynamic> profile = {
      'foreignUser': null,
      'selfUser': null,
    };

    Map<String, bool> profileState = {
      'foreignUserIsLoading': false,
      'foreignUserIsSuccess': false,
      'foreignUserIsError': false,
      'selfUserIsLoading': false,
      'selfUserIsSuccess': false,
      'selfUserIsError': false,
    };

    Map<String, dynamic> search = {
      'activity': [],
      'cabildo': [],
      'user': [],
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

    return AppState(
        user, feeds, profile, search, loginState, registerState, feedState, profileState, false);
  }
}
