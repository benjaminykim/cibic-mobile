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

class ActivityFeed extends StatefulWidget {
  // 0 -> HOME, 1 -> PUBLIC
  final int mode;

  ActivityFeed(this.mode);

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

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
          print(activity.user.toString());
          return ActivityView(
              activity, vm.onReact, vm.onSave, widget.mode);
        },
      );
    }
  }

  FeedViewModel generateFeedViewModel(Store<AppState> store) {
    Function refreshFeed = () => store.dispatch(FetchFeedAttempt(widget.mode));
    Function onReact = (ActivityModel activity, int reactValue) =>
        store.dispatch(PostReactionAttempt(activity, reactValue, widget.mode));
    Function onSave = (int activityId) => store.dispatch(PostSaveAttempt(activityId, true));
    FeedModel feed;
    bool feedError;
    if (widget.mode == FEED_HOME) {
      feed = store.state.homeFeed;
      feedError = store.state.homeFeedError;
    } else {
      feed = store.state.publicFeed;
      feedError = store.state.publicFeedError;
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
        return (Container(
          color: APP_BACKGROUND,
          child: RefreshIndicator(
            key: refreshKey,
            onRefresh: () async {
              refreshKey.currentState?.show(atTop: false);
              await vm.refreshList();
              return null;
            },
            child: generateFeed(context, vm),
          ),
        ));
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
