import 'dart:convert';

import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityView.dart';
import 'package:cibic_mobile/src/widgets/menu/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<FeedModel> savedFeed;
  FeedModel loadedFeed;
  bool isLoaded;
  ScrollController controller;

  @override
  initState() {
    super.initState();
    this.isLoaded = false;
    this.loadedFeed = FeedModel.initial();
  }

  refresh(String jwt) async {
    this.loadedFeed = FeedModel.initial();
    this.savedFeed = fetchSavedFeed(jwt, 0);
    return null;
  }

  Future<FeedModel> fetchSavedFeed(String jwt, int offset) async {
    var url = API_BASE + ENDPOINT_ACTIVITY_SAVE_FEED + "/" + offset.toString();
    Map<String, String> header = getAuthHeader(jwt);

    var response = await http.get(url, headers: header);
    printResponse("SAVED FEED", "GET", response.statusCode);
    if (response != null && response.statusCode == 200) {
      if (offset != 0) {
        FeedModel feed =
            FeedModel.fromJson(json.decode('{"feed":' + response.body + '}'));
        setState(() {
          this.loadedFeed.feed.addAll(feed.feed);
        });
      } else {
        FeedModel feed =
            FeedModel.fromJson(json.decode('{"feed":' + response.body + '}'));
        setState(() {
          this.loadedFeed = feed;
        });
      }
      return this.loadedFeed;
    } else {
      throw Exception("Could Not Fetch Saved Feed");
    }
  }

  FeedViewModel generateFeedViewModel(Store<AppState> store) {
    String jwt = store.state.user['jwt'];
    Function onReact = (ActivityModel activity, int reactValue) =>
        store.dispatch(PostReactionAttempt(activity, reactValue, 4));
    Function onSave =
        (int activityId) => store.dispatch(PostSaveAttempt(activityId, false));
    if (this.isLoaded == false) {
      this.savedFeed = fetchSavedFeed(jwt, 0);
      this.isLoaded = true;
    }

    void _scrollListener() async {
      if (controller.position.maxScrollExtent == controller.offset) {
        this.savedFeed = fetchSavedFeed(jwt, this.loadedFeed.feed.length);
      }
    }

    controller = new ScrollController()..addListener(_scrollListener);
    return FeedViewModel(
      jwt,
      onReact,
      onSave,
      controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FeedViewModel>(
      converter: (Store<AppState> store) {
        return generateFeedViewModel(store);
      },
      builder: (BuildContext context, FeedViewModel vm) {
        return MaterialApp(
          theme: cibicTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Text("GUARDADOS",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  )),
              centerTitle: true,
              titleSpacing: 0.0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: FutureBuilder<FeedModel>(
              future: savedFeed,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    onRefresh: () {
                      return refresh(vm.jwt);
                    },
                    child: ListView.separated(
                      controller: vm.controller,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                      itemCount: snapshot.data.feed.length,
                      itemBuilder: (BuildContext context, int index) {
                        ActivityModel activity = snapshot.data.feed[index];
                        return ActivityView(activity, vm.onReact, vm.onSave, 4);
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  return LoadingPiece();
                }
              },
            ),
          ),
        );
      },
    );
  }
}

class FeedViewModel {
  String jwt;
  final Function onReact;
  final Function onSave;
  ScrollController controller;

  FeedViewModel(this.jwt, this.onReact, this.onSave, this.controller);
}
