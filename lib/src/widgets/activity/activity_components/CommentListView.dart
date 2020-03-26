import 'package:cibic_mobile/src/constants.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/widgets/IconTag.dart';
import 'package:flutter/material.dart';

class CommentListView extends StatelessWidget {
  final List<CommentModel> comments;
  final inputCommentController = TextEditingController();

  CommentListView(this.comments);

  Container comment(CommentModel c, BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 2),
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: CARD_BACKGROUND,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Color(0xff000000),
                blurRadius: 3.0,
                spreadRadius: 0,
                offset: Offset(3.0, 3.0))
          ]),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // user metadata
            Container(
              height: 20,
              margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                children: <Widget>[
                  IconTag(Icon(Icons.person, size: 20), c.idUser),
                  Spacer(),
                  IconTag(Icon(Icons.offline_bolt, size: 20), "1.1k"),
                ],
              ),
            ),
            // comment data and reaction system
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(children: <Widget>[
                    Icon(Icons.thumb_up, size: 20),
                    Text(
                      c.score.toString(),
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.thumb_down, size: 20),
                  ]),
                ),
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
            // input response
            Container(),
            // responses
            Container()
          ],
        ),
      ),
    );
  }

  List<Container> generateComments(BuildContext context) {
    List<Container> commentCards = [];
    for (var i = 0; i < comments.length; i++) {
      commentCards.add(comment(comments[i], context));
    }
    return commentCards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 2),
          width: MediaQuery.of(context).size.width - 20,
          height: 75,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              color: CARD_BACKGROUND,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff000000),
                    blurRadius: 3.0,
                    spreadRadius: 0,
                    offset: Offset(3.0, 3.0))
              ]),
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
        ),
        ...generateComments(context),
      ],
    );
  }
}
