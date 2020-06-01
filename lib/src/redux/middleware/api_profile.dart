import 'dart:convert';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

fetchProfile(String jwt, String type, String id, NextDispatcher next) async {
  String url = API_BASE;
  if (type == "cabildo") {
    url += ENDPOINT_CABILDO_PROFILE + id;
  } else if (type == "selfUser" || type == "foreignUser") {
    url += ENDPOINT_USER + id;
  }

  final response = await http.get(url, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });

  print("fetchProfile: ${response.statusCode}");
  print(" type: $type     id: $id");
  if (response.statusCode == 200) {
    if (type == "cabildo") {
      CabildoModel cabildo = CabildoModel.fromJson(json.decode(response.body));
      next(FetchProfileSuccess(type, cabildo));
    } else {
      UserModel user = UserModel.fromJson(json.decode(response.body));
      next(FetchProfileSuccess(type, user));
    }
  } else {
    next(FetchProfileSuccess(type, response.statusCode.toString()));
  }
}

fetchProfileFeed(
    String jwt, String type, String id, NextDispatcher next) async {
  String url = API_BASE;
  if (type == "cabildo") {
    url += ENDPOINT_CABILDO_FEED + id;
  } else if (type == "selfUser" || type == "foreignUser") {
    url += ENDPOINT_USER_FEED + id;
  }

  final response = await http.get(url, headers: {
    'content-type': 'application/json',
    'accept': 'application/json',
    'authorization': "Bearer $jwt"
  });
  if (response.statusCode == 200) {
    FeedModel feed =
        FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
    next(FetchProfileFeedSuccess(type, feed));
  } else {
    next(FetchProfileFeedError(type, response.statusCode.toString()));
  }
}
// fetchCabildoProfile(String jwt, int idCabildo, NextDispatcher next) async {
//   final profileResponse =
//       await http.get(API_BASE + ENDPOINT_CABILDO_PROFILE + idCabildo.toString(), headers: {
//     'content-type': 'application/json',
//     'accept': 'application/json',
//     'authorization': "Bearer $jwt"
//   });

//   final feedResponse =
//       await http.get(API_BASE + ENDPOINT_CABILDO_FEED + idCabildo.toString(), headers: {
//     'content-type': 'application/json',
//     'accept': 'application/json',
//     'authorization': "Bearer $jwt"
//   });

//   if (profileResponse.statusCode == 200 && feedResponse.statusCode == 200) {
//     print("CABILDO PROFILE RESPONSE: ${profileResponse.body}");
//     CabildoModel cabildo = CabildoModel.fromJson(json.decode(profileResponse.body));
//     FeedModel feed =
//         FeedModel.fromJson(json.decode('{"feed": ' + feedResponse.body + '}'));
//     next(FetchCabildoProfileSuccess(cabildo, feed));
//   } else {
//     next(FetchCabildoProfileError(profileResponse.statusCode.toString() + " " + feedResponse.statusCode.toString()));
//   }
// }

// fetchUserProfile(String jwt, NextDispatcher next) async {
//   String idUser = extractID(jwt).toString();
//   final response = await http.get(API_BASE + ENDPOINT_USER + idUser, headers: {
//     'content-type': 'application/json',
//     'accept': 'application/json',
//     'authorization': "Bearer $jwt"
//   });
//   print("fetchUserProfile: ${response.statusCode}");
//   if (response.statusCode == 200) {
//     UserModel user = UserModel.fromJson(json.decode(response.body));
//     next(FetchProfileSuccess('selfUser', user));
//   } else {
//     next(FetchProfileSuccess('selfUser', response.statusCode.toString()));
//   }
// }

// fetchUserProfileFeed(String jwt, NextDispatcher next) async {
//   String idUser = extractID(jwt).toString();
//   final response =
//       await http.get(API_BASE + ENDPOINT_USER_FEED + idUser, headers: {
//     'content-type': 'application/json',
//     'accept': 'application/json',
//     'authorization': "Bearer $jwt"
//   });
//   if (response.statusCode == 200) {
//     FeedModel feed =
//         FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
//     next(FetchProfileFeedSuccess('selfUser', feed));
//   } else {
//     next(FetchProfileFeedError('selfUser', response.statusCode.toString()));
//   }
// }

// fetchCabildoProfile(String jwt, int idCabildo, NextDispatcher next) async {
//   final profileResponse =
//       await http.get(API_BASE + ENDPOINT_CABILDO_PROFILE + idCabildo.toString(), headers: {
//     'content-type': 'application/json',
//     'accept': 'application/json',
//     'authorization': "Bearer $jwt"
//   });

//   final feedResponse =
//       await http.get(API_BASE + ENDPOINT_CABILDO_FEED + idCabildo.toString(), headers: {
//     'content-type': 'application/json',
//     'accept': 'application/json',
//     'authorization': "Bearer $jwt"
//   });

//   if (profileResponse.statusCode == 200 && feedResponse.statusCode == 200) {
//     print("CABILDO PROFILE RESPONSE: ${profileResponse.body}");
//     CabildoModel cabildo = CabildoModel.fromJson(json.decode(profileResponse.body));
//     FeedModel feed =
//         FeedModel.fromJson(json.decode('{"feed": ' + feedResponse.body + '}'));
//     next(FetchCabildoProfileSuccess(cabildo, feed));
//   } else {
//     next(FetchCabildoProfileError(profileResponse.statusCode.toString() + " " + feedResponse.statusCode.toString()));
//   }
// }

// fetchForeignUserProfile(String jwt, NextDispatcher next, int idUser) async {
//   final response = await http.get(API_BASE + ENDPOINT_USER + idUser.toString(), headers: {
//     'content-type': 'application/json',
//     'accept': 'application/json',
//     'authorization': "Bearer $jwt"
//   });
//   print("fetchUserProfile: ${response.statusCode}");
//   if (response.statusCode == 200) {
//     UserModel user = UserModel.fromJson(json.decode(response.body));
//     next(FetchForeignUserProfileSuccess(user));
//   } else {
//     next(FetchForeignUserProfileError(response.statusCode.toString()));
//   }
// }

// fetchForeignUserProfileFeed(String jwt, NextDispatcher next, int idUser) async {
//   final response =
//       await http.get(API_BASE + ENDPOINT_USER_FEED + idUser.toString(), headers: {
//     'content-type': 'application/json',
//     'accept': 'application/json',
//     'authorization': "Bearer $jwt"
//   });
//   print("fetchUserProfileFeed: ${response.statusCode}");
//   if (response.statusCode == 200) {
//     FeedModel feed =
//         FeedModel.fromJson(json.decode('{"feed": ' + response.body + '}'));
//     next(FetchForeignUserProfileFeedSuccess(feed));
//   } else {
//     next(FetchForeignUserProfileFeedError(response.statusCode.toString()));
//   }
// }
