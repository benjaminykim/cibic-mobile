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

void printFetchRequest(String idUser, String jwt) {
  print("id: $idUser");
  print("jwt: $jwt");
}

Future<String> followUser(String idUserFollow, String jwt) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_FOLLOW_USER));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"idUser": idUserFollow})));
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

Future<String> followCabildo(String idCabildo, String jwt) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_FOLLOW_CABILDO));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"idCabildo": idCabildo})));
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

Future<String> unfollowCabildo(String idCabildo, String jwt) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_UNFOLLOW_CABILDO));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');
  request.add(utf8.encode(json.encode({"idCabildo": idCabildo})));
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

Future<int> commentToActivity(
    String jwt, String content, String idActivity) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_COMMENT));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    "idActivity": idActivity,
    "comment": {"idUser": extractID(jwt), "content": content}
  };
  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: commentToActivity: ${response.statusCode}");
  printFetchRequest(idActivity, jwt);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    print("response body: $responseBody");
    return response.statusCode;
  } else {
    return response.statusCode;
  }
}

Future<int> replyToComment(
    String jwt, String content, String idActivity, String idComment) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REPLY));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    "idActivity": idActivity,
    "idComment": idComment,
    "reply": {"idUser": extractID(jwt), "content": content}
  };
  request.add(utf8.encode(json.encode(requestBody)));
  HttpClientResponse response = await request.close();
  httpClient.close();

  print("DEBUG: replyToComment: ${response.statusCode}");
  printFetchRequest(idActivity, jwt);
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    print("response body: $responseBody");
    return response.statusCode;
  } else {
    return response.statusCode;
  }
}

Future<int> voteToComment(
    String jwt, int value, String idActivity, String idComment) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient
      .postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_COMMENT_VOTE));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    "idActivity": idActivity,
    "idComment": idComment,
    "vote": {"idUser": extractID(jwt), "value": value}
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
    String jwt, int value, String idActivity, String idReply) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient
      .postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REPLY_VOTE));
  request.headers.add('content-type', 'application/json');
  request.headers.add('accept', 'application/json');
  request.headers.add('authorization', 'Bearer $jwt');

  final requestBody = {
    "idActivity": idActivity,
    "idReply": idReply,
    "vote": {"idUser": extractID(jwt), "value": value}
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