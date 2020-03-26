import 'package:cibic_mobile/src/constants.dart';
import 'package:cibic_mobile/src/widgets/ActivityScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import './activity_card/ActivityCard.dart';
import '../models/feed_model.dart';
import '../models/activity_model.dart';
import '../resources/api_provider.dart';

Future<FeedModel> fetchHomeFeed() async {
  //final response = await http.get(URL_AWS_BASE + ENDPOINT_ACTIVITY);
  final response = await http.get(URL_LOCALHOST_BASE + ENDPOINT_ACTIVITY);

  if (response.statusCode == 200) {
    return FeedModel.fromJson(json.decode('{"feed":' + response.body + '}'));
  } else {
    throw Exception('Failed to load home feed');
  }
}

Future<FeedModel> fetchPublicFeed() async {
  final response =
      await testClient.get('https://cibic.io/api/user_id/feed_home');

  if (response.statusCode == 200) {
    return FeedModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load public feed');
  }
}

class ActivityFeed extends StatefulWidget {
  final String mode;
  final Function(ActivityScreen, BuildContext) onActivityTapped;

  ActivityFeed(this.mode, this.onActivityTapped);

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  Future<FeedModel> feed;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      feed = fetchHomeFeed();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xfff2f2f2),
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshList,
          child: FutureBuilder<FeedModel>(
            future: fetchHomeFeed(),
            builder: (context, feedSnap) {
              if (feedSnap.hasData) {
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                    itemCount: feedSnap.data.feed.length,
                    itemBuilder: (BuildContext context, int index) {
                      ActivityModel activity = feedSnap.data.feed[index];
                      return ActivityCard(activity, widget.onActivityTapped);
                    });
              } else if (feedSnap.hasError) {
                return Text("error: cibic servers are down",
                    style: TextStyle(color: Colors.black));
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}
