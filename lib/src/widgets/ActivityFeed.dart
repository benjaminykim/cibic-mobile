import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import './activity_card/ActivityCard.dart';
import '../models/feed_model.dart';
import '../models/activity_model.dart';
import '../resources/api_provider.dart';

Future<FeedModel> fetchHomeFeed() async {
  //final response = await testClient.get('https://cibic.io/api/user_id/feed_home');
  final response = await http.get('http://10.0.2.2:3000/activity');

  if (response.statusCode == 200) {
    return FeedModel.fromJson(json.decode('{"feed":' + response.body +'}'));
  } else {
    throw Exception('Failed to load home feed');
  }
}

Future<FeedModel> fetchPublicFeed() async {
  final response = await testClient.get('https://cibic.io/api/user_id/feed_home');

  if (response.statusCode == 200) {
    return FeedModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load public feed');
  }
}

class ActivityFeed extends StatefulWidget {
  final String mode;

  ActivityFeed(this.mode);

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  Future<FeedModel> feed;

  @override
  void initState() {
    super.initState();
    //feed = fetchHomeFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff2f2f2),
      child: FutureBuilder<FeedModel>(
        future: fetchHomeFeed(),
        builder: (context, feedSnap) {
          if (feedSnap.hasData) {
          return ListView.builder(
            itemCount: feedSnap.data.feed.length,
            itemBuilder: (BuildContext context, int index) {
              ActivityModel activity = feedSnap.data.feed[index];
              return ActivityCard(activity);
            }
          );
          } else if (feedSnap.hasError) {
            return Text("an error has occurred");
          } else {
            return CircularProgressIndicator();
          }
        },
      )
    );
  }
}