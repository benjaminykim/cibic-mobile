
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';


AppState appReducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is AppUser) {
    newState.idUser = action.payload;
  } else if (action is ChangeComposeOption) {
    newState.selectedComposeButton = action.payload;
  } else if (action is GET_CABILDOS) {
    newState.cabildos = action.payload;
  }

  return newState;
}