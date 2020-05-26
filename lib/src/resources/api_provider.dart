import 'dart:convert';
import 'dart:io';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';

void printDebugResponse(var response) {
  if (response != Null) {
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body.toString()}");
  }
}

void printFetchRequest(int idUser, String jwt) {
  print("id: $idUser");
  print("jwt: $jwt");
}

Future<String> followUser(int idUserFollow, String jwt) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_FOLLOW_USER));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"userId": idUserFollow})));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: followUser");
  printFetchRequest(idUserFollow, jwt);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    return responseBody;
  } else {
    return "error";
  }
}

Future<String> followCabildo(int idCabildo, String jwt) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_FOLLOW_CABILDO));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"cabildoId": idCabildo})));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: followCabildo");
  printFetchRequest(idCabildo, jwt);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    return responseBody;
  } else {
    return "error";
  }
}

Future<String> unfollowCabildo(int idCabildo, String jwt) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_UNFOLLOW_CABILDO));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"cabildoId": idCabildo})));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: unfollowCabildo");
  printFetchRequest(idCabildo, jwt);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    return responseBody;
  } else {
    return "error";
  }
}

Future<int> voteToComment(
    String jwt, int value, int idActivity, int idComment) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient
      .postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_COMMENT_VOTE));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    "activityId": idActivity,
    "commentId": idComment,
    "vote": {"userId": extractID(jwt), "value": value}
  };
  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: voteToComment: ${response.statusCode}");
  printFetchRequest(idActivity, jwt);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    print("response body: $responseBody");
    return response.statusCode;
  } else {
    return response.statusCode;
  }
}

Future<int> voteToReply(
    String jwt, int value, int idActivity, int idReply) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient
      .postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REPLY_VOTE));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    "activityId": idActivity,
    "replyId": idReply,
    "vote": {"userId": extractID(jwt), "value": value}
  };
  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: voteToComment: ${response.statusCode}");
  printFetchRequest(idActivity, jwt);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    print("response body: $responseBody");
    return response.statusCode;
  } else {
    return response.statusCode;
  }
}