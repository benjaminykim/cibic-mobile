import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/feed_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';
import 'package:cibic_mobile/src/widgets/activity/card/UserMetaData.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CommentFeed extends StatefulWidget {
  final ActivityModel activity;
  final String jwt;
  final int mode;

  CommentFeed(this.activity, this.jwt, this.mode);

  @override
  _CommentFeedState createState() => _CommentFeedState();
}

class _CommentFeedState extends State<CommentFeed> {
  final BoxShadow commentShadow = BoxShadow(
    color: Color(0xff000000),
    blurRadius: 0,
    spreadRadius: 0,
    offset: Offset(1, 0.1),
  );

  int maxCommentView = 3;

  Container comment(CommentModel c, BuildContext context, Function onReply) {
    final inputCommentController = TextEditingController();
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 2),
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: CARD_BACKGROUND,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [commentShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // USER META DATA
          Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 0, 5),
            child: UserMetaData(c.idUser['username'], c.idUser['citizenPoints'],
                null, c.idUser['id'], null, null),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // REACTION SYSTEM
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(children: <Widget>[
                  GestureDetector(
                      child: Icon(Icons.keyboard_arrow_up, size: 20),
                      onTap: () {
                        voteToComment(widget.jwt, 1, widget.activity.id, c.id);
                      }),
                  Text(
                    c.score.toString(),
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                      child: Icon(Icons.keyboard_arrow_down, size: 20),
                      onTap: () {
                        voteToComment(widget.jwt, -1, widget.activity.id, c.id);
                      }),
                ]),
              ),
              // COMMENT CONTENTS
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 30, 10),
                width: MediaQuery.of(context).size.width - 80,
                child: Text(
                  c.content,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          // INPUT RESPONSE
          Container(
            margin: EdgeInsets.fromLTRB(30, 2, 30, 10),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: TextField(
              controller: inputCommentController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Colors.black),
                  onPressed: () {
                    onReply(widget.activity.id, c.id, inputCommentController.text, widget.mode);
                  },
                ),
                border: InputBorder.none,
                hintText: "comenta...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    fontSize: 14),
              ),
            ),
          ),
          // RESPONSES
          ...generateResponseFeed(c.reply, context),
        ],
      ),
    );
  }

  Container reply(ReplyModel r, BuildContext c) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
      decoration: BoxDecoration(
        color: Color(0xffcccccc),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // REACT SYSTEM
          Container(
            padding: const EdgeInsets.fromLTRB(5, 15, 0, 10),
            width: 25,
            height: 80,
            child: Column(
              children: <Widget>[
                GestureDetector(
                    child: Icon(Icons.keyboard_arrow_up, size: 20),
                    onTap: () {
                      voteToReply(widget.jwt, 1, widget.activity.id, r.id);
                    }),
                Text(
                  r.score.toString(),
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                    child: Icon(Icons.keyboard_arrow_down, size: 20),
                    onTap: () {
                      voteToReply(widget.jwt, -1, widget.activity.id, r.id);
                    }),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 105,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // RESPONSE USER METADATA
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: UserMetaData(r.idUser['username'], r.idUser['citizenPoints'], null,
                      r.idUser['idUser'], null, null),
                ),
                // RESPONSE TEXT CONTENT
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: Text(
                    r.content,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                // RESPONSE ICON
                GestureDetector(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.reply, size: 20),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        elevation: 5,
                        backgroundColor: Colors.transparent,
                        builder: (bContext) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 10,
                              color: Colors.black,
                            ),
                            behavior: HitTestBehavior.opaque,
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Container> generateCommentFeed(
      BuildContext context, _CommentFeedViewModel vm) {
    List<Container> commentCards = [];
    for (int i = 0; i < vm.comments.length; i++) {
      commentCards.add(comment(vm.comments[i], context, vm.onReply));
    }
    return commentCards;
  }

  Container generateNewCommentInput(
      BuildContext context, _CommentFeedViewModel vm) {
    final inputCommentController = TextEditingController();
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 2),
      width: MediaQuery.of(context).size.width - 20,
      height: 75,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: CARD_BACKGROUND,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [commentShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Deja un comentario",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              )),
          Container(
            margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: TextField(
              controller: inputCommentController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Icon(Icons.send),
                  ),
                  color: Colors.black,
                  onPressed: () {
                    String commentText = inputCommentController.text;
                    vm.commentToActivity(
                        widget.activity.id, commentText, widget.mode);
                    //commentToActivity(widget.jwt, commentText, widget.idActivity);
                  },
                ),
                border: InputBorder.none,
                hintText: "comenta...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Container> generateResponseFeed(
      List<ReplyModel> responses, BuildContext context) {
    if (responses != null) {
      List<Container> responseCards = [];
      for (int i = 0;
          i < responses.length && i < this.maxCommentView - 1;
          i++) {
        responseCards.add(
          reply(responses[i], context),
        );
      }
      if (responses.length > this.maxCommentView) {
        responseCards.add(
            // SEE MORE COMMENTS BUTTON
            Container(
          margin: EdgeInsets.fromLTRB(0, 0, 30, 5),
          alignment: Alignment.bottomRight,
          child: GestureDetector(
              onTap: () => {
                    setState(() {
                      this.maxCommentView += 2;
                    })
                  },
              child: Text("ver mas...",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ))),
        ));
      }
      return responseCards;
    }
    return [Container()];
  }

  _CommentFeedViewModel generateViewModel(Store<AppState> store) {
    Function commentToActivity =
        (String idActivity, String content, int mode) =>
            store.dispatch(PostCommentAttempt(idActivity, content, mode));
    Function onReply = (String idActivity, String idComment, String content, int mode) =>
            store.dispatch(PostReplyAttempt(idActivity, idComment, content, mode));
    List<CommentModel> comments;
    FeedModel searchFeed;
    switch (widget.mode) {
      case FEED_PUBLIC:
        searchFeed = store.state.publicFeed;
        break;
      case FEED_HOME:
        searchFeed = store.state.homeFeed;
        break;
      case FEED_USER:
        searchFeed = store.state.userProfileFeed;
        break;
      case FEED_CABILDO:
        searchFeed = store.state.cabildoProfileFeed;
        break;
      case FEED_FOREIGN:
        searchFeed = store.state.foreignUserFeed;
        break;
    }
    for (int i = 0; i < searchFeed.feed.length; i++) {
      if (searchFeed.feed[i].id == widget.activity.id) {
        comments = searchFeed.feed[i].comments;
      }
    }
    return _CommentFeedViewModel(commentToActivity, onReply, comments);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CommentFeedViewModel>(
        converter: (Store<AppState> store) {
      return generateViewModel(store);
    }, builder: (BuildContext context, _CommentFeedViewModel vm) {
      return Column(children: [
        generateNewCommentInput(context, vm),
        ...generateCommentFeed(context, vm),
      ]);
    });
  }
}

class _CommentFeedViewModel {
  Function commentToActivity;
  Function onReply;
  List<CommentModel> comments;
  _CommentFeedViewModel(this.commentToActivity, this.onReply, this.comments);
}
