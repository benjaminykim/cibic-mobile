import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:redux/redux.dart';

postActivity(
    dynamic action, String jwt, NextDispatcher next, Store store) async {
  int type = action.type;
  String title = action.title;
  String body = action.body;
  int idCabildo = action.idCabildo;
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  var requestBody;
  if (type == 0 || type == 1) {
    if (idCabildo == -1) {
      requestBody = {
        'activity': {'activityType': type, 'title': title, 'text': body}
      };
    } else {
      requestBody = {
        'activity': {
          'cabildoId': idCabildo,
          'activityType': type,
          'title': title,
          'text': body
        }
      };
    }
  } else {
    if (idCabildo == -1) {
      requestBody = {
        'activity': {'activityType': type, 'title': title, 'text': "none"}
      };
    } else {
      requestBody = {
        'activity': {
          'cabildoId': idCabildo,
          'activityType': type,
          'title': title,
          'text': "none"
        }
      };
    }
  }

  if (action.tags.length > 0) {
    requestBody['tags'] = {'array': action.tags};
  }
  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  printResponse("ACTIVITY", "POST", response.statusCode);
  if (response.statusCode == 201) {
    store.dispatch(SubmitActivitySuccess());
  } else {
    store.dispatch(SubmitActivityError(response.statusCode.toString()));
  }
}

postReaction(ActivityModel activity, String jwt, int reactValue, int idUser,
    int mode, NextDispatcher next) async {
  bool newReaction = true;
  int idReaction;
  for (int i = 0; i < activity.reactions.length; i++) {
    if (idUser == activity.reactions[i].userId) {
      newReaction = false;
      idReaction = activity.reactions[i].id;
      break;
    }
  }

  if (newReaction) {
    var reaction = {
      "reaction": {
        "value": reactValue.toString(),
        "activityId": activity.id,
      }
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REACT));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');
    request.add(utf8.encode(json.encode(reaction)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    printResponse("REACTION", "POST", response.statusCode);
    if (response.statusCode == 201) {
      final responseBody = await response.transform(utf8.decoder).join();
      int id = json.decode(responseBody)['id'];
      ReactionModel newReaction = ReactionModel.fromJson(
          {"id": id, "userId": idUser, "value": reactValue});
      next(PostReactionSuccess(activity.id, newReaction, mode));
    } else {
      next(PostReactionError(response.statusCode.toString()));
    }
  } else {
    var reaction = {
      "activityId": activity.id,
      "reactionId": idReaction,
      "value": reactValue
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.putUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REACT));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');
    request.add(utf8.encode(json.encode(reaction)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    printResponse("REACTION", "PUT", response.statusCode);
    if (response.statusCode == 200) {
      next(PostReactionUpdate(activity.id, idReaction, reactValue, mode));
    } else {
      next(PostReactionError(response.statusCode.toString()));
    }
  }
}

postPollVote(ActivityModel activity, String jwt, int reactValue, int idUser,
    int mode, NextDispatcher next) async {
  bool newReaction = true;
  int idReaction;
  int idUser = extractID(jwt);
  for (int i = 0; i < activity.votes.length; i++) {
    if (idUser == activity.votes[i]['userId']) {
      newReaction = false;
      idReaction = activity.votes[i]['id'];
      break;
    }
  }

  if (newReaction) {
    var reaction = {
      "vote": {
        "value": reactValue.toString(),
        "activityId": activity.id,
      }
    };

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_VOTE));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');
    request.add(utf8.encode(json.encode(reaction)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    printResponse("VOTE", "POST", response.statusCode);
    if (response.statusCode == 201) {
      final responseBody = await response.transform(utf8.decoder).join();
      int id = json.decode(responseBody)['id'];
      Map<String, dynamic> vote = {
        "id": id,
        "userId": extractID(jwt),
        "value": reactValue,
      };
      print(vote);
      next(PostPollSuccess(activity.id, vote, mode));
    } else {
      next(PostPollError(response.statusCode.toString()));
    }
  } else {
    var reaction = {"voteId": idReaction, "value": reactValue};

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.putUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_VOTE));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');
    request.add(utf8.encode(json.encode(reaction)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    printResponse("VOTE", "PUT", response.statusCode);
    print(reaction);
    if (response.statusCode == 200) {
      reaction['userId'] = idUser;
      next(PostPollUpdate(activity.id, idReaction, reactValue, mode));
    } else {
      next(PostPollError(response.statusCode.toString()));
    }
  }
}
