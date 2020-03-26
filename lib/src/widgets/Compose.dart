import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

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

class Compose extends StatefulWidget {
  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
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

  void dispose() {
    super.dispose();
    inputTitleController.dispose();
    inputIntroController.dispose();
    inputBodyController.dispose();
    inputCabildoController.dispose();
    inputTagController.dispose();
  }

  void deleteActivity() {
    Navigator.of(context).pop();
  }

  void submitActivity() {
    final enteredTitle = inputTitleController.text;
    final enteredIntro = inputIntroController.text;
    final enteredBody = inputBodyController.text;
    final enteredCabildo = inputCabildoController.text;
    final enteredTag = inputTagController.text;

    if (selectedActivity == 0 || selectedActivity == 2) {
      if (enteredTitle.isEmpty ||
          enteredIntro.isEmpty ||
          enteredBody.isEmpty ||
          enteredCabildo.isEmpty) {
        return;
      } else {
        addActivity(enteredTitle, enteredIntro, enteredBody, enteredCabildo,
            enteredTag);
      }
    } else if (selectedActivity == 1) {
      if (enteredTitle.isEmpty || enteredCabildo.isEmpty) {
        return;
      } else {
        addPollActivity(enteredTitle, enteredCabildo, enteredTag);
      }
    }
    Navigator.of(context).pop();
  }

  Container createActivityButton(String type, int selected) {
    return Container(
      width: 68,
      height: 17,
      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(5),
        color: (selected == 1) ? Colors.blue : Colors.transparent,
      ),
      child: GestureDetector(
        onTap: () {
          handleButtonClick(context, type);
        },
        child: Center(
          child: Text(
            labelTextPicker[type],
            style: TextStyle(
              color: (selected == 1) ? Colors.white : Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  void createHeader() {
    this.header = [
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
      Row(children: activityButtons)
    ];
  }

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
            )
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

  void handleButtonClick(BuildContext context, String type) {
    setState(() {
      activityButtons[selectedActivity] =
          createActivityButton(ACTIVITY_TYPES[selectedActivity], 0);
      activityButtons[ACTIVITY_TYPES.indexOf(type)] =
          createActivityButton(type, 1);
      selectedActivity = ACTIVITY_TYPES.indexOf(type);
    });
  }

  initState() {
    super.initState();
    this.activityButtons = [
      createActivityButton(ACTIVITY_DISCUSS, 1),
      createActivityButton(ACTIVITY_POLL, 0),
      createActivityButton(ACTIVITY_PROPOSAL, 0)
    ];
    this.actionButtons = [
      Spacer(),
      Row(
        children: <Widget>[
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteActivity,
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: submitActivity,
          ),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    createHeader();
    createBody(context);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      width: MediaQuery.of(context).size.width - 20,
      height: MediaQuery.of(context).size.height / 2 + 100,
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
        children: <Widget>[
          ...this.header,
          ...this.body,
          ...this.actionButtons,
        ],
      ),
    );
  }
}
