import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';

class AppState {
  String idUser;
  String jwt;
  String firstName;
  String lastName;
  List<dynamic> followers;
  List<dynamic> following;
  UserModel user;
  FeedModel userProfileFeed;
  FeedModel homeFeed;
  FeedModel publicFeed;
  List<dynamic> cabildos;
  bool isLogIn;
  bool homeFeedError;
  bool publicFeedError;
  bool userProfileError;
  CabildoModel cabildoProfile;
  FeedModel cabildoProfileFeed;
  bool cabildoProfileError;
  bool cabildoProfileIsLoading;

  AppState(this.idUser, this.jwt, this.firstName, this.lastName, this.followers, this.following, this.user, this.userProfileFeed,
  this.homeFeed, this.publicFeed, this.cabildos, this.isLogIn, this.homeFeedError, this.publicFeedError, this.userProfileError,
  this.cabildoProfile, this.cabildoProfileFeed, this.cabildoProfileError, this.cabildoProfileIsLoading);

  AppState.fromAppState(AppState another) {
    idUser = another.idUser;
    jwt = another.jwt;
    firstName = another.firstName;
    lastName = another.lastName;
    followers = another.followers;
    following = another.following;
    user = another.user;
    userProfileFeed = another.userProfileFeed;
    homeFeed = another.homeFeed;
    publicFeed = another.publicFeed;
    cabildos = another.cabildos;
    isLogIn = another.isLogIn;
    homeFeedError = another.homeFeedError;
    publicFeedError = another.publicFeedError;
    userProfileError = another.userProfileError;
    cabildoProfile = another.cabildoProfile;
    cabildoProfileFeed = another.cabildoProfileFeed;
    cabildoProfileError = another.cabildoProfileError;
    cabildoProfileIsLoading = another.cabildoProfileIsLoading;
  }

  factory AppState.initial() => AppState("", "", "", "", [], [], null, null, null, null, [], false, false, false, false, null, null, false, false);
}