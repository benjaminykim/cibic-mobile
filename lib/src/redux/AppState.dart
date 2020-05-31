import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AppState {
  int idUser;
  String jwt;
  String firstName;
  String lastName;
  List<dynamic> followers;
  List<dynamic> following;
  UserModel user;
  FeedModel userProfileFeed;
  FeedModel homeFeed;
  FeedModel publicFeed;
  FeedModel savedFeed;
  List<dynamic> cabildos;
  bool isLogIn;
  bool homeFeedError;
  bool publicFeedError;
  bool userProfileError;
  CabildoModel cabildoProfile;
  FeedModel cabildoProfileFeed;
  bool cabildoProfileError;
  bool cabildoProfileIsLoading;
  UserModel foreignUser;
  FeedModel foreignUserFeed;
  bool foreignUserError;
  String firebaseToken;
  FirebaseMessaging firebaseManager;
  List<ActivityModel> searchActivity;
  List<CabildoModel> searchCabildo;
  List<UserModel> searchUser;
  bool registerError;
  bool registerSuccess;

  AppState(this.idUser, this.jwt, this.firstName, this.lastName, this.followers, this.following, this.user, this.userProfileFeed,
  this.homeFeed, this.publicFeed, this.savedFeed, this.cabildos, this.isLogIn, this.homeFeedError, this.publicFeedError, this.userProfileError,
  this.cabildoProfile, this.cabildoProfileFeed, this.cabildoProfileError, this.cabildoProfileIsLoading, this.foreignUser, this.foreignUserFeed, this.foreignUserError,
  this.firebaseToken, this.firebaseManager, this.searchActivity, this.searchCabildo, this.searchUser, this.registerError, this.registerSuccess);

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
    savedFeed = another.savedFeed;
    cabildos = another.cabildos;
    isLogIn = another.isLogIn;
    homeFeedError = another.homeFeedError;
    publicFeedError = another.publicFeedError;
    userProfileError = another.userProfileError;
    cabildoProfile = another.cabildoProfile;
    cabildoProfileFeed = another.cabildoProfileFeed;
    cabildoProfileError = another.cabildoProfileError;
    cabildoProfileIsLoading = another.cabildoProfileIsLoading;
    foreignUser = another.foreignUser;
    foreignUserFeed = another.foreignUserFeed;
    foreignUserError = another.foreignUserError;
    firebaseToken = another.firebaseToken;
    firebaseManager = another.firebaseManager;
    searchActivity = another.searchActivity;
    searchCabildo = another.searchCabildo;
    searchUser = another.searchUser;
    registerError = another.registerError;
    registerSuccess = another.registerSuccess;
  }

  factory AppState.initial() => AppState(-1, "", "", "", [], [], null, null, null, null, null, [], false, false, false, false, null, null, false, false, null, null, false, "", null, [], [], [], false, false);
}