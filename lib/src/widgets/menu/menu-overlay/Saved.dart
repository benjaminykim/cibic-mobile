import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_feed.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/widgets/activity/ActivityView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:redux/redux.dart';

class Saved extends StatelessWidget {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  Widget generateFeed(BuildContext context, FeedViewModel vm) {
    if (vm.feedError == true) {
      return ListView(
        children: <Widget>[
          Container(
            height: 200,
            padding: EdgeInsets.all(50),
            alignment: Alignment.center,
            child: Text(
              "Cibic server error",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else if (vm.feed == null || vm.feed.feed.length == 0) {
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
    } else {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: vm.feed.feed.length,
        itemBuilder: (BuildContext context, int index) {
          ActivityModel activity = vm.feed.feed[index];
          return ActivityView(
              activity, vm.jwt, vm.onReact, vm.onSave, FEED_SAVED);
        },
      );
    }
  }

  FeedViewModel generateFeedViewModel(Store<AppState> store) {
    Function refreshFeed = () => store.dispatch(FetchFeedAttempt(FEED_SAVED));
    Function onReact = (ActivityModel activity, int reactValue) =>
        store.dispatch(PostReactionAttempt(activity, reactValue, FEED_SAVED));
    Function onSave = (int activityId) => store.dispatch(PostSaveAttempt(activityId, false));
    FeedModel feed;
    bool feedError;
    feed = store.state.savedFeed;
    if (store.state.savedFeed == null) {
      store.dispatch(FetchFeedAttempt(FEED_SAVED));
    }
    return FeedViewModel(
        feed, store.state.jwt, refreshFeed, onReact, onSave, feedError);
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
            body: generateFeed(context, vm),
          ),
        );
      },
    );
  }
}

class FeedViewModel {
  FeedModel feed;
  String jwt;
  final Function refreshList;
  final Function onReact;
  final Function onSave;
  bool feedError;

  FeedViewModel(this.feed, this.jwt, this.refreshList, this.onReact, this.onSave,
      this.feedError);
}
