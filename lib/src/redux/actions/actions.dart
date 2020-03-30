import 'package:cibic_mobile/src/models/cabildo_model.dart';

class AppUser {
  final String payload;
  AppUser(this.payload);
}

class ChangeComposeOption {
  final int payload;
  ChangeComposeOption(this.payload);
}

class GET_CABILDOS {
  final List<dynamic> payload;
  GET_CABILDOS(this.payload);
}