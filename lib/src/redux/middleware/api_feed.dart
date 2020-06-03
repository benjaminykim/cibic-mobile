import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_feed.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:redux/redux.dart';

fetchFeed(String jwt, int mode, int offset, NextDispatcher next) async {
  String url;
  if (mode == FEED_PUBLIC) {
    url = API_BASE + ENDPOINT_PUBLIC_FEED + offset.toString();
  } else {
    url = API_BASE + ENDPOINT_DEFAULT_FEED + offset.toString();
  }
  Map<String, String> header = getAuthHeader(jwt);
  var response = await http.get(url, headers: header);
  printResponse("FEED", "GET", response.statusCode);
  if (response != null && response.statusCode == 200) {
    FeedModel feed =
        FeedModel.fromJson(json.decode('{"feed":' + response.body + '}'));
    if (offset != 0) {
      next(FetchFeedAppend(mode, feed));
    } else {
      next(FetchFeedSuccess(mode, feed));
    }
  } else {
    next(FetchFeedError(mode, response.statusCode.toString()));
  }
}
