class AppState {
  String idUser;
  String jwt;
  String firstName;
  String lastName;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> userProfileFeed;
  List<dynamic> homeFeed;
  List<dynamic> publicFeed;
  List<dynamic> cabildos;
  bool isLogIn;

  AppState(this.idUser, this.jwt, this.firstName, this.lastName, this.followers, this.following, this.userProfileFeed,
  this.homeFeed, this.publicFeed, this.cabildos, this.isLogIn);

  AppState.fromAppState(AppState another) {
    idUser = another.idUser;
    jwt = another.jwt;
    firstName = another.firstName;
    lastName = another.lastName;
    followers = another.followers;
    following = another.following;
    userProfileFeed = another.userProfileFeed;
    homeFeed = another.homeFeed;
    publicFeed = another.publicFeed;
    cabildos = another.cabildos;
    isLogIn = another.isLogIn;
  }

  factory AppState.initial() => AppState("", "", "", "", [], [], [], [], [], [], false);
}