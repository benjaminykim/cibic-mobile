

import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/models/reaction_model.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:redux/redux.dart';

postActivity(dynamic action, String jwt, NextDispatcher next, Store store) async {
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
        'activity': {
          'activityType': type,
          'title': title,
          'text': body
        }
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
        'activity': {
          'activityType': type,
          'title': title,
          'text': "none"
        }
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

  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  if (response.statusCode == 201) {
    //final responseBody = await response.transform(utf8.decoder).join();
    //Map<String, dynamic> activity = jsonDecode(responseBody);
    store.dispatch(SubmitActivitySuccess());
  } else {
    store.dispatch(SubmitActivityError(response.statusCode.toString()));
  }
}

postReaction(ActivityModel activity, String jwt, int reactValue, int idUser, int mode, NextDispatcher next) async {
  print("API REACTION");
  bool newReaction = true;
  int idReaction;
  for (int i = 0; i < activity.reactions.length; i++) {
    if (idUser == activity.reactions[i].userId) {
      newReaction = false;
      idReaction = activity.reactions[i].id;
      activity.reactions[i].value = reactValue;
      break;
    }
  }

  if (newReaction) {
  print("NEW REACTION");
    var reaction = {
      "activityId": activity.id,
      "userId": idUser,
      "reaction": {"value": reactValue.toString()}
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

    print(response.statusCode);
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
  print("UPDATE REACTION");
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

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("PUT RESPONSE BODY: ${response.statusCode}");
      next(PostReactionUpdate(activity.id, idReaction, reactValue, mode));
    } else {
      next(PostReactionError(response.statusCode.toString()));
    }
  }
}

postComment(int idActivity, String jwt, String content, int mode, int citizenPoints, String firstName, NextDispatcher next) async {
    HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_COMMENT));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    "activityId": idActivity,
    "comment": {"userId": extractID(jwt), "content": content}
  };
  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: commentToActivity: ${response.statusCode}");
  if (response.statusCode == 201) {
    var responseBody = jsonDecode(await response.transform(utf8.decoder).join());
    next(PostCommentSuccess(idActivity, CommentModel(responseBody['id'], {'userId': extractID(jwt), 'firstName': firstName, 'citizenPoints': citizenPoints}, content, 0, []), mode));
  } else {
    next(PostCommentError(response.statusCode.toString()));
  }
}

postReply(int idActivity, int idComment, String content, String jwt, String firstName, int citizenPoints, int mode, NextDispatcher next) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REPLY));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    "activityId": idActivity,
    "commentId": idComment,
    "reply": {"userId": extractID(jwt), "content": content}
  };
  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: replyToComment: ${response.statusCode}");
  if (response.statusCode == 201) {
    var responseBody = jsonDecode(await response.transform(utf8.decoder).join());
    next(PostReplySuccess(idActivity, idComment, ReplyModel(responseBody['id'], {'userId': extractID(jwt), 'firstName': firstName, 'citizenPoints': citizenPoints}, content, 0), mode));
  } else {
    next(PostReplyError(response.statusCode.toString()));
  }
}
