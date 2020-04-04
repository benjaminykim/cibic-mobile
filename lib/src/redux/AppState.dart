
class AppState {
  String idUser;
  String username;
  String email;
  String firstName;
  String middleName;
  String lastName;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> activityFeed;
  int selectedIndex;
  int selectedComposeButton;
  List<dynamic> cabildos;

  AppState(this.idUser, this.username, this.email, this.firstName, this.middleName,
  this.lastName, this.followers, this.following, this.activityFeed, this.selectedIndex,
  this.selectedComposeButton, this.cabildos);

  AppState.fromAppState(AppState another) {
    idUser = another.idUser;
    username = another.username;
    email = another.email;
    firstName = another.firstName;
    middleName = another.middleName;
    lastName = another.lastName;
    followers = another.followers;
    following = another.following;
    activityFeed = another.activityFeed;
    selectedIndex = another.selectedIndex;
    selectedComposeButton = another.selectedComposeButton;
    cabildos = another.cabildos;
  }

  factory AppState.initial() => AppState("", "", "", "", "", "", [], [], [], 0, 0, []);
}