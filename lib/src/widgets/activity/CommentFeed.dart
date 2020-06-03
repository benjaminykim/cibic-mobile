import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/resources/cibic_icons.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:cibic_mobile/src/widgets/profile/UserProfileScreen.dart';
import 'package:flutter/material.dart';

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/models/comment_model.dart';
import 'package:cibic_mobile/src/models/reply_model.dart';
import 'package:cibic_mobile/src/widgets/activity/card/UserMetaData.dart';
import 'package:flutter/services.dart';

class CommentFeed extends StatefulWidget {
  final ActivityModel activity;
  final int mode;
  final String jwt;
  final UserModel user;

  CommentFeed(this.activity, this.mode, this.jwt, this.user);

  @override
  _CommentFeedState createState() => _CommentFeedState();
}

class _CommentFeedState extends State<CommentFeed> {
  bool isLoading;

  @override
  initState() {
    super.initState();
    this.isLoading = false;
  }

  final BoxShadow commentShadow = BoxShadow(
    color: Color(0xff000000),
    blurRadius: 0,
    spreadRadius: 0,
    offset: Offset(1, 0.1),
  );

  int maxCommentView = 3;

  onComment(String jwt, int activityId, String content, int mode,
      String firstName, int citizenPoints) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_COMMENT));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');

    final requestBody = {
      "activityId": activityId,
      "comment": {"userId": extractID(jwt), "content": content}
    };
    request.add(utf8.encode(json.encode(requestBody)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    if (response.statusCode == 201) {
      var responseBody =
          jsonDecode(await response.transform(utf8.decoder).join());
      CommentModel comment = CommentModel(
          responseBody['id'],
          {
            'userId': extractID(widget.jwt),
            'firstName': widget.user.firstName,
            'citizenPoints': widget.user.citizenPoints,
          },
          content,
          0,
          [],
          []);
      setState(() {
        widget.activity.comments.insert(0, comment);
      });
    } else {}
  }

  onCommentVote(String jwt, int value, int activityId, CommentModel comment,
      int userId, int mode) async {
    bool newVote = true;
    int voteId;
    if (comment.votes != null) {
      for (int i = 0; i < comment.votes.length; i++) {
        if (userId == comment.votes[i]['userId']) {
          newVote = false;
          voteId = comment.votes[i]['id'];
          if (comment.votes[i]['value'] == value) {
            return;
          }
          break;
        }
      }
    }

    if (newVote) {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient
          .postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_COMMENT_VOTE));
      request.headers.add('content-type', 'application/json');
      request.headers.add('accept', 'application/json');
      request.headers.add('authorization', 'Bearer $jwt');

      final requestBody = {
        "vote": {
          "activityId": activityId,
          "commentId": comment.id,
          "value": value,
          "userId": userId
        }
      };
      request.add(utf8.encode(json.encode(requestBody)));
      HttpClientResponse response = await request.close();
      httpClient.close();

      print("DEBUG: postCommentVote: ${response.statusCode}");
      if (response.statusCode == 201) {
        String responseBody = await response.transform(utf8.decoder).join();
        Map<String, dynamic> vote = jsonDecode(responseBody);
        requestBody['vote']['id'] = vote['id'];
        setState(() {
          widget.activity.comments
              .singleWhere((CommentModel c) => c.id == comment.id)
              .votes
              .insert(0, requestBody['vote']);
          widget.activity.comments
              .singleWhere((CommentModel c) => c.id == comment.id)
              .score += value;
        });
      } else {}
    } else {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient
          .putUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_COMMENT_VOTE));
      request.headers.add('content-type', 'application/json');
      request.headers.add('accept', 'application/json');
      request.headers.add('authorization', 'Bearer $jwt');

      final requestBody = {"voteId": voteId, "value": value};
      request.add(utf8.encode(json.encode(requestBody)));
      HttpClientResponse response = await request.close();
      httpClient.close();

      print("DEBUG: putCommentVote: ${response.statusCode}");
      if (response.statusCode == 200) {
        setState(() {
          widget.activity.comments
              .singleWhere((CommentModel c) => c.id == comment.id)
              .votes
              .singleWhere((dynamic v) => v['id'] == voteId)['value'] = value;
          widget.activity.comments
              .singleWhere((CommentModel c) => c.id == comment.id)
              .score += (value * 2);
        });
      } else {}
    }
  }

  onReply(
      String jwt,
      int activityId,
      int commentId,
      int tagId,
      String tagFirstName,
      String content,
      String firstName,
      int citizenPoints,
      int mode) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REPLY));
    request.headers.add('content-type', 'application/json');
    request.headers.add('accept', 'application/json');
    request.headers.add('authorization', 'Bearer $jwt');

    final requestBody = {
      "reply": {
        "activityId": activityId,
        "commentId": commentId,
        "userId": extractID(jwt),
        "content": content
      }
    };

    if (tagId != 0) {
      requestBody['reply']['taggedUserId'] = tagId;
    }
    request.add(utf8.encode(json.encode(requestBody)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    if (response.statusCode == 201) {
      var responseBody =
          jsonDecode(await response.transform(utf8.decoder).join());
      ReplyModel reply;
      Map<String, dynamic> author = {
        'id': extractID(jwt),
        'firstName': firstName,
        'citizenPoints': citizenPoints,
      };
      if (tagId != 0) {
        Map<String, dynamic> taggedUser = {
          'firstName': tagFirstName,
          'id': tagId,
        };
        reply =
            ReplyModel(responseBody['id'], author, taggedUser, content, 0, []);
      } else {
        reply = ReplyModel(responseBody['id'], author, null, content, 0, []);
      }
      setState(() {
        (widget.activity.comments
                .singleWhere((CommentModel c) => c.id == commentId))
            .replies
            .insert(0, reply);
      });
    } else {
      return false;
    }
  }

  onReplyVote(String jwt, int value, int activityId, int commentId,
      ReplyModel reply, int userId, int mode) async {
    bool newVote = true;
    int voteId;
    if (reply.votes != null) {
      for (int i = 0; i < reply.votes.length; i++) {
        if (userId == reply.votes[i]['userId']) {
          newVote = false;
          voteId = reply.votes[i]['id'];
          if (reply.votes[i]['value'] == value) {
            return;
          }
          break;
        }
      }
    }

    if (newVote) {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient
          .postUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REPLY_VOTE));
      request.headers.add('content-type', 'application/json');
      request.headers.add('accept', 'application/json');
      request.headers.add('authorization', 'Bearer $jwt');

      final requestBody = {
        "vote": {"activityId": activityId, "replyId": reply.id, "value": value}
      };
      request.add(utf8.encode(json.encode(requestBody)));
      HttpClientResponse response = await request.close();
      httpClient.close();

      if (response.statusCode == 201) {
        String responseBody = await response.transform(utf8.decoder).join();
        Map<String, dynamic> vote = jsonDecode(responseBody);
        vote['value'] = value;
        vote['userId'] = userId;
        setState(() {
          widget.activity.comments
              .singleWhere((CommentModel c) => c.id == commentId)
              .replies
              .singleWhere((ReplyModel r) => r.id == reply.id)
              .votes
              .insert(0, vote);
          widget.activity.comments
              .singleWhere((CommentModel c) => c.id == commentId)
              .replies
              .singleWhere((ReplyModel r) => r.id == reply.id)
              .score += value;
        });
      } else {}
    } else {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient
          .putUrl(Uri.parse(API_BASE + ENDPOINT_ACTIVITY_REPLY_VOTE));
      request.headers.add('content-type', 'application/json');
      request.headers.add('accept', 'application/json');
      request.headers.add('authorization', 'Bearer $jwt');

      final requestBody = {"voteId": voteId, "value": value};
      request.add(utf8.encode(json.encode(requestBody)));
      HttpClientResponse response = await request.close();
      httpClient.close();

      print("DEBUG: putReplyVote: ${response.statusCode}");
      if (response.statusCode == 200) {
        setState(() {
          widget.activity.comments
              .singleWhere((CommentModel c) => c.id == commentId)
              .replies
              .singleWhere((ReplyModel r) => r.id == reply.id)
              .votes
              .singleWhere((dynamic v) => v['id'] == voteId)['value'] = value;
          widget.activity.comments
              .singleWhere((CommentModel c) => c.id == commentId)
              .replies
              .singleWhere((ReplyModel r) => r.id == reply.id)
              .score += (2 * value);
        });
      } else {}
    }
  }

  Container reply(ReplyModel r, BuildContext c, int commentId,
      ReplyController commentController) {
    int userId = extractID(widget.jwt);
    Color upVoteColor = Colors.black;
    Color downVoteColor = Colors.black;
    if (r.votes != null) {
      for (int i = 0; i < r.votes.length; i++) {
        if (r.votes[i]['userId'] == userId) {
          if (r.votes[i]['value'] == 1) {
            upVoteColor = COLOR_DEEP_BLUE;
          } else if (r.votes[i]['value'] == -1) {
            downVoteColor = COLOR_DEEP_BLUE;
          }
          break;
        }
      }
    }
    print("tagged user ${r.taggedUser}");
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
                    child: Icon(Icons.keyboard_arrow_up,
                        color: upVoteColor, size: 20),
                    onTap: () {
                      onReplyVote(widget.jwt, 1, widget.activity.id, commentId,
                          r, userId, widget.mode);
                    }),
                Text(
                  r.score.toString(),
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                    child: Icon(Icons.keyboard_arrow_down,
                        color: downVoteColor, size: 20),
                    onTap: () {
                      onReplyVote(widget.jwt, -1, widget.activity.id, commentId,
                          r, userId, widget.mode);
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
                  child: UserMetaData(r.user['firstName'],
                      r.user['citizenPoints'], null, r.user['id'], null, null),
                ),
                // RESPONSE TEXT CONTENT
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  child: ((r.taggedUser != null) &&
                          (r.taggedUser['id'] != null))
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfileScreen(r.taggedUser['id'])));
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "@${r.taggedUser['firstName']} ",
                              style: TextStyle(
                                fontSize: 14,
                                color: COLOR_DEEP_BLUE,
                                fontWeight: FontWeight.w200,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: r.content,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                    )),
                              ],
                            ),
                          ),
                        )
                      : Text(
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
                    child: Icon(Cibic.reply, size: 20),
                  ),
                  onTap: () {
                    commentController.text = "@" + r.user["firstName"] + " ";
                    commentController.selection = TextSelection.fromPosition(
                        TextPosition(offset: commentController.text.length));
                    commentController.setId(r.user['id']);
                    commentController.setTagFirstName(r.user['firstName']);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Container> generateResponseFeed(List<ReplyModel> responses,
      BuildContext context, int commentId, ReplyController commentController) {
    if (responses != null) {
      List<Container> responseCards = [];
      for (int i = 0; i < responses.length && i < this.maxCommentView; i++) {
        responseCards.add(
          reply(responses[i], context, commentId, commentController),
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

  Container comment(CommentModel c, BuildContext context) {
    int userId = extractID(widget.jwt);
    final inputCommentController = ReplyController();
    Color upVoteColor = Colors.black;
    Color downVoteColor = Colors.black;
    if (c.votes != null) {
      for (int i = 0; i < c.votes.length; i++) {
        if (c.votes[i]['userId'] == userId) {
          if (c.votes[i]['value'] == 1) {
            upVoteColor = COLOR_DEEP_BLUE;
          } else {
            downVoteColor = COLOR_DEEP_BLUE;
          }
          break;
        }
      }
    }
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
            child: UserMetaData(c.user['firstName'], c.user['citizenPoints'],
                null, c.user['id'], null, null),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // REACTION SYSTEM
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(children: <Widget>[
                  GestureDetector(
                      child: Icon(Icons.keyboard_arrow_up,
                          color: upVoteColor, size: 20),
                      onTap: () {
                        onCommentVote(widget.jwt, 1, widget.activity.id, c,
                            userId, widget.mode);
                      }),
                  Text(
                    c.score.toString(),
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                      child: Icon(Icons.keyboard_arrow_down,
                          color: downVoteColor, size: 20),
                      onTap: () {
                        onCommentVote(widget.jwt, -1, widget.activity.id, c,
                            userId, widget.mode);
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
          // RESPONSES
          ...generateResponseFeed(
              c.replies, context, c.id, inputCommentController),
          // INPUT RESPONSE
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30, 2, 30, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Color(0xffcccccc),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: new ConstrainedBox(
                          constraints: new BoxConstraints(
                            minHeight: 15,
                            maxHeight: 100.0,
                          ),
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            reverse: true,
                            child: TextField(
                              controller: inputCommentController,
                              scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              maxLines: null,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(500),
                              ],
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                  fontSize: 12),
                              onSubmitted: (String value) {
                                if (inputCommentController.text != "" &&
                                    inputCommentController.text != null &&
                                    this.isLoading == false) {
                                  onReply(
                                      widget.jwt,
                                      widget.activity.id,
                                      c.id,
                                      inputCommentController.getId(),
                                      inputCommentController.getFirstName(),
                                      inputCommentController.getText(),
                                      widget.user.firstName,
                                      widget.user.citizenPoints,
                                      widget.mode);
                                  inputCommentController.clear();
                                }
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "comenta...",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (inputCommentController.text != "" &&
                            inputCommentController.text != null &&
                            this.isLoading == false) {
                          onReply(
                              widget.jwt,
                              widget.activity.id,
                              c.id,
                              inputCommentController.getId(),
                              inputCommentController.getFirstName(),
                              inputCommentController.getText(),
                              widget.user.firstName,
                              widget.user.citizenPoints,
                              widget.mode);
                          inputCommentController.clear();
                        }
                      },
                      child: Icon(Cibic.comment, color: Colors.black, size: 25),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Container> generateCommentFeed(BuildContext context) {
    List<Container> commentCards = [];
    for (int i = 0; i < widget.activity.comments.length; i++) {
      commentCards.add(comment(widget.activity.comments[i], context));
    }
    return commentCards;
  }

  Container generateNewCommentInput(BuildContext context) {
    final inputCommentController = TextEditingController();
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 2),
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: CARD_BACKGROUND,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [commentShadow],
      ),
      child: // INPUT RESPONSE
          Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("Deja un comentario",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              )),
          // INPUT FIELD
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: Color(0xffcccccc),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: new ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: 15,
                        maxHeight: 100.0,
                      ),
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        reverse: true,
                        child: TextField(
                          controller: inputCommentController,
                          scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          maxLines: null,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(500)
                          ],
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                              fontSize: 12),
                          onSubmitted: (String value) {
                            if (inputCommentController.text != "" &&
                                inputCommentController.text != null &&
                                this.isLoading == false) {
                              String commentText = inputCommentController.text;
                              onComment(
                                  widget.jwt,
                                  widget.activity.id,
                                  commentText,
                                  widget.mode,
                                  widget.user.firstName,
                                  widget.user.citizenPoints);
                              inputCommentController.clear();
                            }
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "comenta...",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (inputCommentController.text != "" &&
                        inputCommentController.text != null &&
                        this.isLoading == false) {
                      String commentText = inputCommentController.text;
                      onComment(
                          widget.jwt,
                          widget.activity.id,
                          commentText,
                          widget.mode,
                          widget.user.firstName,
                          widget.user.citizenPoints);
                      inputCommentController.clear();
                    }
                  },
                  child: Icon(Cibic.comment, color: Colors.black, size: 25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      generateNewCommentInput(context),
      ...generateCommentFeed(context),
    ]);
  }
}

class ReplyController extends TextEditingController {
  int id = 0;
  String tagFirstName;
  String content;

  ReplyController() {
    this.id = 0;
    this.tagFirstName = "";
    this.content = "";
  }

  void setId(int id) {
    this.id = id;
  }

  int getId() {
    return this.id;
  }

  void setTagFirstName(String firstName) {
    this.tagFirstName = firstName;
  }

  String getFirstName() {
    return this.tagFirstName;
  }

  String getText() {
    return this.content;
  }

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    List<InlineSpan> children = [];
    if (text.indexOf('@') == 0 && text.length == 1) {
      text = "";
    } else if (text.indexOf('@') == 0 && text.indexOf(' ') != -1) {
      children.add(TextSpan(
          style: TextStyle(
              color: COLOR_DEEP_BLUE,
              fontWeight: FontWeight.w200,
              fontSize: 12),
          text: text.substring(0, text.indexOf(' '))));
      children.add(TextSpan(
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w200, fontSize: 12),
          text: text.substring(text.indexOf(' '))));
      this.content = text.substring(text.indexOf(' '));
    } else if (text.indexOf('@') == 0 && text.indexOf(' ') == -1) {
      text = "";
      this.id = 0;
      this.tagFirstName = "";
    } else {
      this.content = text;
      children.add(TextSpan(
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w200, fontSize: 12),
          text: text));
    }
    return TextSpan(style: style, children: children);
  }
}
