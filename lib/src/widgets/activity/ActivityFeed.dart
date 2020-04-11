import 'package:cibic_mobile/src/widgets/activity/ActivityCard.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/resources/constants.dart';

Future<FeedModel> fetchFeed(String jwt, String mode) async {
  var response;
  Map<String, String> header = getAuthHeader(jwt);
  if (mode == "public") {
    response = await http.get(API_BASE + ENDPOINT_PUBLIC_FEED, headers: header);
  } else {
    // changes to user feed
    // API_BASE + 'home/'
    //response = await http.get(API_BASE + ENDPOINT_DEFAULT_FEED, headers: header);
    response =
        await http.get(API_BASE + ENDPOINT_DEFAULT_FEED, headers: header);
  }

  if (response != null && response.statusCode == 200) {
    print(response.body);
    return FeedModel.fromJson(json.decode('{"feed":' + response.body + '}'));
  } else {
    throw Exception(
        'Failed to load $mode feed, statusCode: ${response.statusCode}');
  }
}

class ActivityFeed extends StatefulWidget {
  final String idUser;
  final String jwt;
  final String mode;

  ActivityFeed(this.idUser, this.jwt, this.mode);

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
      feed = fetchFeed(widget.jwt, widget.mode);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: APP_BACKGROUND,
      child: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: FutureBuilder<FeedModel>(
          future: fetchFeed(widget.jwt, widget.mode),
          builder: (context, feedSnap) {
            if (feedSnap.hasData) {
              if (feedSnap.data.feed.length != 0) {
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                    itemCount: feedSnap.data.feed.length,
                    itemBuilder: (BuildContext context, int index) {
                      ActivityModel activity = feedSnap.data.feed[index];
                      return ActivityCard(activity, widget.jwt);
                    });
              } else {
                return ListView(
                  children: <Widget>[
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(50),
                      alignment: Alignment.center,
                      child: Text(
                        "siga a los usuarios o cabildos para ver el contenido",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }
            } else if (feedSnap.hasError) {
              return ListView(
                  children: <Widget>[
                    Container(
                      height: 200,
                      padding: EdgeInsets.all(50),
                      alignment: Alignment.center,
                      child: Text(
                        "cibic server error",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
