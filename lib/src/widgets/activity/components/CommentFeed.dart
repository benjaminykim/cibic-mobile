import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';
import 'package:cibic_mobile/src/widgets/activity/components/card/UserMetaData.dart';

class CommentFeed extends StatefulWidget {
  final List<CommentModel> comments;

  CommentFeed(this.comments);

  @override
  _CommentFeedState createState() => _CommentFeedState();
}

class _CommentFeedState extends State<CommentFeed> {
  final inputCommentController = TextEditingController();

  final BoxShadow commentShadow = BoxShadow(
    color: Color(0xff000000),
    blurRadius: 0,
    spreadRadius: 0,
    offset: Offset(1, 0.1),
  );

  int maxCommentView = 3;

  Container comment(CommentModel c, BuildContext context) {
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
            child: UserMetaData(c.idUser['username'], 1, null, c.idUser['id']),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // REACTION SYSTEM
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(children: <Widget>[
                  Icon(Icons.keyboard_arrow_up, size: 20),
                  Text(
                    c.score.toString(),
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.black,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 20),
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
                suffixIcon: Icon(Icons.send, color: Colors.black),
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
                Icon(Icons.keyboard_arrow_up, size: 20),
                Text(
                  r.score.toString(),
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, size: 20),
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
                  child: UserMetaData(r.idUser['username'], 1, null, r.idUser['id']),
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
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.reply, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Container> generateCommentFeed(BuildContext context) {
    List<Container> commentCards = [];
    for (int i = 0; i < widget.comments.length; i++) {
      commentCards.add(comment(widget.comments[i], context));
    }
    return commentCards;
  }

  Container generateNewCommentInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 2),
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
                suffixIcon: Icon(Icons.send, color: Colors.black),
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
              child: Text(
                "ver mas...",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )
              )
            ),
          )
        );
      }
      return responseCards;
    }
    return [Container()];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        generateNewCommentInput(context),
        ...generateCommentFeed(context),
      ],
    );
  }
}
