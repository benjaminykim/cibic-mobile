import 'dart:convert';

import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/widgets/activity/card/CardMetaData.dart';
import 'package:cibic_mobile/src/widgets/activity/card/CardView.dart';
import 'package:cibic_mobile/src/widgets/activity/card/UserMetaData.dart';
import 'package:cibic_mobile/src/widgets/menu/loading.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/widgets/activity/CommentFeed.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

class ActivityScreen extends StatefulWidget {
  final int activityId;
  final Function onReact;
  final Function onSave;
  final int mode;

  ActivityScreen(this.activityId, this.onReact, this.onSave, this.mode);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  Future<ActivityModel> activity;

  @override
  initState() {
    super.initState();
  }

  Future<ActivityModel> fetchActivity(String jwt, int id) async {
    var url = API_BASE + ENDPOINT_ACTIVITY + id.toString();
    print("URL $url");
    Map<String, String> header = getAuthHeader(jwt);
    var response = await http.get(url, headers: header);
    if (response != null && response.statusCode == 200) {
      return ActivityModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _UserViewModel>(
      converter: (Store<AppState> store) {
        this.activity =
            fetchActivity(store.state.user['jwt'], widget.activityId);
            return _UserViewModel(store.state.user['jwt'], store.state.profile['selfUser']);
      },
      builder: (BuildContext context, _UserViewModel vm) {
        return FutureBuilder<ActivityModel>(
          future: activity,
          builder:
              (BuildContext context, AsyncSnapshot<ActivityModel> snapshot) {
            if (snapshot.hasData) {
              ActivityModel activity = snapshot.data;
              return Scaffold(
                appBar: AppBar(),
                body: Container(
                  color: APP_BACKGROUND,
                  child: ListView(
                    children: <Widget>[
                      UserMetaData.fromActivity(activity),
                      CardView(activity, CARD_SCREEN, widget.onReact,
                          widget.onSave, widget.mode),
                      CardMetaData(activity.ping, activity.commentNumber,
                          activity.publishDate),
                      CommentFeed(activity, widget.mode, vm.jwt, vm.user),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(),
                body: Container(
                  color: APP_BACKGROUND,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Text(
                      "Profile could not be reached, Cibic server is down",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(),
                body: Container(
                  color: APP_BACKGROUND,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: LoadingPiece(),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class _UserViewModel {
  String jwt;
  UserModel user;
  _UserViewModel(this.jwt, this.user);
}
