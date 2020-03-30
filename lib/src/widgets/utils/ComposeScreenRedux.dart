import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;

import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:redux/redux.dart';

Future<void> addActivity(String title, String intro, String body,
    String cabildos, String tags) async {
  final response = await http.post(URL_LOCALHOST_BASE + ENDPOINT_POST_ACTIVITY);

  if (response.statusCode == 200) {
    print("success");
  } else {
    throw Exception('Failed to load home feed');
  }
}

Future<void> addPollActivity(String title, String cabildos, String tags) async {
  final response = await http.post(URL_LOCALHOST_BASE + ENDPOINT_POST_ACTIVITY);

  if (response.statusCode == 200) {
    print("success");
  } else {
    throw Exception('Failed to load home feed');
  }
}

class ComposeRedux extends StatelessWidget {
  final inputTitleController = TextEditingController();
  final inputIntroController = TextEditingController();
  final inputBodyController = TextEditingController();
  final inputCabildoController = TextEditingController();
  final inputTagController = TextEditingController();

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ComposeView>(
      converter: (Store<AppState> store) => _ComposeView.create(store),
      builder: (BuildContext context, _ComposeView composeView) {
        return _createComposeView(composeView.selectedButton, context);
      });

  Container _createComposeView(int selected, BuildContext context) {
    if (selected == 0) {
      return _createDiscussionCompose(context, selected);
    } else if (selected == 1) {
      return _createPollCompose(context, selected);
    } else if (selected == 2) {
      return _createProposalCompose(context, selected);
    } else {
      return Container();
    }
  }

  List<Widget> createHeader(int selected) {
    return [
      Text(
        "Crea y comparte contenido",
        style: TextStyle(
            color: Colors.black, fontSize: 23, fontWeight: FontWeight.w400),
      ),
      SizedBox(height: 5),
      Text(
        "Que quieres compartir?",
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
      ),
      SizedBox(height: 10),
      Row(children: [
        createActivityButton(ACTIVITY_DISCUSS, 0 == selected),
        createActivityButton(ACTIVITY_POLL, 1 == selected),
        createActivityButton(ACTIVITY_PROPOSAL, 2 == selected)
      ])
    ];
  }

  static Container createActivityButton(String type, bool selected) {
    return Container(
      width: 68,
      height: 17,
      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(5),
        color: (selected) ? Colors.blue : Colors.transparent,
      ),
      child: GestureDetector(
        onTap: () {

          //handleActivityButtonClick(context, type);
        },
        child: Center(
          child: Text(
            labelTextPicker[type],
            style: TextStyle(
              color: (selected) ? Colors.white : Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Container _createDiscussionCompose(BuildContext context, int selected) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height - 100,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: CARD_BACKGROUND,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.blue,
                blurRadius: 3.0,
                spreadRadius: 0,
                offset: Offset(3.0, 3.0))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ...createHeader(selected),
          // title
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputTitleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "De que se trata?",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 15),
              ),
            ),
          ),
          // introduction
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputIntroController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "introduccion...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
              ),
            ),
          ),
          // content body
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputBodyController,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffcccccc),
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                hintText: "cuentanos mas...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
              ),
            ),
          ),
          // cabildo and tags
          Row(
            children: <Widget>[
              Icon(Icons.people, size: 40),
              SizedBox(width: 8),
              Column(
                children: <Widget>[
                  // cabildo
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                    height: 30,
                    width: MediaQuery.of(context).size.width - 108,
                    decoration: BoxDecoration(
                      color: Color(0xffcccccc),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: TextField(
                      controller: inputCabildoController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "comparte en un cabildo",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xffa1a1a1)),
                      ),
                    ),
                  ),
                  // tags
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                    height: 30,
                    width: MediaQuery.of(context).size.width - 108,
                    decoration: BoxDecoration(
                      color: Color(0xffcccccc),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: TextFormField(
                      controller: inputTagController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "#tags",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xffa1a1a1)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          // action buttons
          Row(
            children: <Widget>[
              Spacer(),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }

  Container _createPollCompose(BuildContext context, int selected) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height - 100,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: CARD_BACKGROUND,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.blue,
                blurRadius: 3.0,
                spreadRadius: 0,
                offset: Offset(3.0, 3.0))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ...createHeader(selected),
          // title
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputTitleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "De que se trata?",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 15),
              ),
            ),
          ),
          // introduction
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputIntroController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "introduccion...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
              ),
            ),
          ),
          // content body
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputBodyController,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffcccccc),
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                hintText: "cuentanos mas...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
              ),
            ),
          ),
          // cabildo and tags
          Row(
            children: <Widget>[
              Icon(Icons.people, size: 40),
              SizedBox(width: 8),
              Column(
                children: <Widget>[
                  // cabildo
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                    height: 30,
                    width: MediaQuery.of(context).size.width - 108,
                    decoration: BoxDecoration(
                      color: Color(0xffcccccc),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: TextField(
                      controller: inputCabildoController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "comparte en un cabildo",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xffa1a1a1)),
                      ),
                    ),
                  ),
                  // tags
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                    height: 30,
                    width: MediaQuery.of(context).size.width - 108,
                    decoration: BoxDecoration(
                      color: Color(0xffcccccc),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: TextFormField(
                      controller: inputTagController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "#tags",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xffa1a1a1)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          // action buttons
          Row(
            children: <Widget>[
              Spacer(),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }

  Container _createProposalCompose(BuildContext context, int selected) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height - 100,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: CARD_BACKGROUND,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.blue,
                blurRadius: 3.0,
                spreadRadius: 0,
                offset: Offset(3.0, 3.0))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ...createHeader(selected),
          // title
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputTitleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "De que se trata?",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 15),
              ),
            ),
          ),
          // introduction
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputIntroController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "introduccion...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
              ),
            ),
          ),
          // content body
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputBodyController,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffcccccc),
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                hintText: "cuentanos mas...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
              ),
            ),
          ),
          // cabildo and tags
          Row(
            children: <Widget>[
              Icon(Icons.people, size: 40),
              SizedBox(width: 8),
              Column(
                children: <Widget>[
                  // cabildo
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                    height: 30,
                    width: MediaQuery.of(context).size.width - 108,
                    decoration: BoxDecoration(
                      color: Color(0xffcccccc),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: TextField(
                      controller: inputCabildoController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "comparte en un cabildo",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xffa1a1a1)),
                      ),
                    ),
                  ),
                  // tags
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                    padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                    height: 30,
                    width: MediaQuery.of(context).size.width - 108,
                    decoration: BoxDecoration(
                      color: Color(0xffcccccc),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    child: TextFormField(
                      controller: inputTagController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "#tags",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Color(0xffa1a1a1)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          // action buttons
          Row(
            children: <Widget>[
              Spacer(),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}

class _ComposeView {
  final int selectedButton;

  _ComposeView(this.selectedButton);

  factory _ComposeView.create(Store<AppState> store) {
    return _ComposeView(store.state.selectedComposeButton);
  }
}

/*
class _ComposeState {
  final inputTitleController = TextEditingController();
  final inputIntroController = TextEditingController();
  final inputBodyController = TextEditingController();
  final inputCabildoController = TextEditingController();
  final inputTagController = TextEditingController();
  List<Container> activityButtons;
  List<Widget> header;
  List<Widget> body;
  List<Widget> actionButtons;
  int selectedActivity = 0;



  void createBody(BuildContext context) {
    if (selectedActivity == 0 || selectedActivity == 2) {
      this.body = [
        // title
        Container(
          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
          height: 33,
          decoration: BoxDecoration(
            color: Color(0xffcccccc),
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          child: TextField(
            controller: inputTitleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "De que se trata?",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 15),
            ),
          ),
        ),
        // introduction
        Container(
          margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
          padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
          height: 33,
          decoration: BoxDecoration(
            color: Color(0xffcccccc),
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          child: TextField(
            controller: inputIntroController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "introduccion...",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
            ),
          ),
        ),
        // content body
        Container(
          margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
          padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
          height: 33,
          decoration: BoxDecoration(
            color: Color(0xffcccccc),
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          child: TextField(
            controller: inputBodyController,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffcccccc),
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              hintText: "cuentanos mas...",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
            ),
          ),
        ),
        // cabildo and tags
        Row(
          children: <Widget>[
            Icon(Icons.people, size: 40),
            SizedBox(width: 8),
            Column(
              children: <Widget>[
                // cabildo
                Container(
                  margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                  height: 30,
                  width: MediaQuery.of(context).size.width - 108,
                  decoration: BoxDecoration(
                    color: Color(0xffcccccc),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: TextField(
                    controller: inputCabildoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "comparte en un cabildo",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color(0xffa1a1a1)),
                    ),
                  ),
                ),
                // tags
                Container(
                  margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                  height: 30,
                  width: MediaQuery.of(context).size.width - 108,
                  decoration: BoxDecoration(
                    color: Color(0xffcccccc),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: TextFormField(
                    controller: inputTagController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "#tags",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color(0xffa1a1a1)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ];
    } else if (selectedActivity == 1) {
      this.body = [
        // title
        Container(
          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
          height: 33,
          decoration: BoxDecoration(
            color: Color(0xffcccccc),
            borderRadius: BorderRadius.all(Radius.circular(13)),
          ),
          child: TextField(
            controller: inputTitleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Que quieres preguntar?",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 15),
            ),
          ),
        ),
        // cabildo and tags
        Row(
          children: <Widget>[
            Icon(Icons.people, size: 40),
            SizedBox(width: 8),
            Column(
              children: <Widget>[
                // cabildo
                Container(
                  margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                  height: 30,
                  width: MediaQuery.of(context).size.width - 108,
                  decoration: BoxDecoration(
                    color: Color(0xffcccccc),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: TextField(
                    controller: inputCabildoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "comparte en un cabildo",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color(0xffa1a1a1)),
                    ),
                  ),
                ),
                // tags
                Container(
                  margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                  padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                  height: 30,
                  width: MediaQuery.of(context).size.width - 108,
                  decoration: BoxDecoration(
                    color: Color(0xffcccccc),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: TextFormField(
                    controller: inputTagController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "#tags",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Color(0xffa1a1a1)),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ];
    }
  }
}
*/