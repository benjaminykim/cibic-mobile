
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';


AppState appReducer(AppState prevState, dynamic action) {
  AppState newState = AppState.fromAppState(prevState);

  if (action is AppUser) {
    print("PAYLOAD");
    print(action.payload);
    print(action.payload['id']);
    newState.idUser = action.payload['id'];
    newState.cabildos = action.payload['cabildos'];
    newState.username = action.payload['username'];
    newState.email = action.payload['email'];
    newState.firstName = action.payload['firstName'];
    newState.middleName = action.payload['middleName'];
    newState.lastName = action.payload['lastName'];
    newState.followers = action.payload['followers'];
    newState.following = action.payload['following'];
    newState.activityFeed = action.payload['activityFeed'];
    print(newState.toString());
  } else if (action is ChangeComposeOption) {
    newState.selectedComposeButton = action.payload;
  } else if (action is GetCabildos) {
    newState.cabildos = action.payload;
  }

  return newState;
}