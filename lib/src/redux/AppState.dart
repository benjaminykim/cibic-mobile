import 'package:cibic_mobile/src/models/cabildo_model.dart';

class AppState {
  String idUser;
  int selectedIndex;
  int selectedComposeButton;
  List<dynamic> cabildos;

  AppState(this.idUser, this.selectedIndex, this.selectedComposeButton);

  AppState.fromAppState(AppState another) {
    idUser = another.idUser;
    selectedIndex = another.selectedIndex;
    selectedComposeButton = another.selectedComposeButton;
    cabildos = another.cabildos;
  }

  factory AppState.initial() => AppState("invalid", 0, 0);
}