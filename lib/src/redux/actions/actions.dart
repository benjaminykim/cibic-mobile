class AppUser {
  final Map<String, dynamic> payload;
  AppUser(this.payload);
}

class LogInAttempt {
  String email;
  String password;

  LogInAttempt(this.email, this.password);
}

class LogInSuccess {
  String jwt;
  LogInSuccess(this.jwt);
}

class LogInError {
  var payload;
  LogInError(this.payload);
}

class FetchHomeFeed {
  List<dynamic> payload;
  FetchHomeFeed(this.payload);
}

class FetchPublicFeed {
  List<dynamic> payload;
  FetchPublicFeed(this.payload);
}

class FetchUserFeed {
  List<dynamic> payload;
  FetchUserFeed(this.payload);
}