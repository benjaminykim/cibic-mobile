import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/redux/actions/actions_feed.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:redux/redux.dart';

fetchFeed(String jwt, int mode, NextDispatcher next) async {
  String url;
  if (mode == FEED_PUBLIC) {
    url = API_BASE + ENDPOINT_PUBLIC_FEED;
  } else if (mode == FEED_SAVED) {
    url = API_BASE + ENDPOINT_ACTIVITY_SAVE_FEED;
  } else {
    url = API_BASE + ENDPOINT_DEFAULT_FEED;
  }
  Map<String, String> header = getAuthHeader(jwt);
  var response = await http.get(url, headers: header);
  print("$mode ${response.statusCode}");
  if (response != null && response.statusCode == 200) {
    FeedModel feed =
        FeedModel.fromJson(json.decode('{"feed":' + response.body + '}'));
    next(FetchFeedSuccess(mode, feed));
  } else {
    print("error jwt: $jwt");
    next(FetchFeedError(mode, response.statusCode.toString()));
  }
}
