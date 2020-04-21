import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cibic_mobile/src/resources/constants.dart';

Future<void> addActivity(String title, String intro, String body,
    String cabildos, String tags, String idUser, String idCabildo) async {
  String url = 'http://10.0.2.2:3000/activity';
  Map map = {
    'activity': {
      'idUser': idUser,
      'idCabildo': idCabildo,
      'activityType': 'discussion',
      'title': title,
      'text': body
    }
  };

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(map)));
  HttpClientResponse response = await request.close();
  String reply;
  if (response.statusCode == 201) {
    final responseBody = await response.transform(utf8.decoder).join();
    Map<String, dynamic> activity = jsonDecode(responseBody);
    reply = activity['id'];
  } else {
    throw Exception(
        "HTTP Response error code: " + response.statusCode.toString());
  }
  httpClient.close();
  return reply;
}

Future<void> addPollActivity(String title, String cabildos, String tags) async {
  final response = await http.post(URL_LOCALHOST_BASE + ENDPOINT_ACTIVITY);

  if (response.statusCode == 200) {
    print("success");
  } else {
    throw Exception('Failed to load home feed');
  }
}

class Compose extends StatefulWidget {
  final String idUser;
  final List<dynamic> cabildos;
  final List<String> cabildoNames = [];
  final List<DropdownMenuItem<String>> cabildoMenu = [];

  DropdownMenuItem<String> createMenuItem(String value) {
    return DropdownMenuItem<String> (
      value: value,
      child: Container(
        child: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w200,
                          color: Color(0xffa1a1a1),
          )
        ),
      )
    );
  }

  Compose(this.idUser, this.cabildos) {
    this.cabildoMenu.add(createMenuItem("comparte en un cabildo"));
    this.cabildoMenu.add(createMenuItem("todo"));
    for (int i = 0; i < this.cabildos.length; i++) {
      this.cabildoMenu.add(createMenuItem(this.cabildos[i]['name']));
    }
  }

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
  List<Widget> actionButtons;
  int selectedActivity = 0;
  String dropdownValue = "comparte en un cabildo";

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
          handleActivityButtonClick(context, type);
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

  Container createTitle(String title) {
    return Container(
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
              fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  List<Widget> createBody(BuildContext context) {
    List<Widget> body = [];
    if (selectedActivity == 0 || selectedActivity == 2) {
      body = [
        // title
        createTitle("De que se trata?"),
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
              hintText: "cuentanos mas...",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
            ),
          ),
        ),
      ];
    } else if (selectedActivity == 1) {
      body = [
        // title
        createTitle("Que quieres preguntar?"),
      ];
    }
    // cabildos and tags
    body.add(Row(
      children: <Widget>[
        Icon(Icons.people, size: 40),
        SizedBox(width: 8),
        Column(
          children: <Widget>[
            // cabildo
            Container(
              margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
              padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              height: 30,
              width: MediaQuery.of(context).size.width - 108,
              decoration: BoxDecoration(
                color: Color(0xffcccccc),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: widget.cabildoMenu,
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
                      fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
                ),
              ),
            ),
          ],
        ),
      ],
    ));
    return body;
  }

  void handleActivityButtonClick(BuildContext context, String type) {
    setState(() {
      activityButtons[selectedActivity] =
          createActivityButton(ACTIVITY_TYPES[selectedActivity], 0);
      activityButtons[ACTIVITY_TYPES.indexOf(type)] =
          createActivityButton(type, 1);
      selectedActivity = ACTIVITY_TYPES.indexOf(type);
    });
  }

  void deleteActivity() {
    Navigator.of(context).pop();
  }

  void submitActivity(String idUser, String idCabildo) {
    final enteredTitle = inputTitleController.text;
    final enteredIntro = inputIntroController.text;
    final enteredBody = inputBodyController.text;
    final enteredTag = inputTagController.text;

    for (int i=0; i < widget.cabildos.length; i++) {
      if (widget.cabildos[i]['name'] == idCabildo) {
        idCabildo = widget.cabildos[i]['id'];
        break;
      }
    }

    if (selectedActivity == 0 || selectedActivity == 2) {
      if (enteredTitle.isEmpty ||
          enteredIntro.isEmpty ||
          enteredBody.isEmpty ) {
        return;
      } else {
        addActivity(enteredTitle, enteredIntro, enteredBody, idCabildo,
            enteredTag, idUser, idCabildo);
      }
    } else if (selectedActivity == 1) {
      if (enteredTitle.isEmpty || idCabildo.isEmpty ) {
        return;
      } else {
        addPollActivity(enteredTitle, idCabildo, enteredTag);
      }
    }
    Navigator.of(context).pop();
  }

  List<Widget> createActionButtons(String idUser, String cabildoName) {
    return [
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
            onPressed: () => submitActivity(idUser, cabildoName),
          ),
        ],
      )
    ];
  }

  initState() {
    super.initState();
    this.activityButtons = [
      createActivityButton(ACTIVITY_DISCUSS, 1),
      createActivityButton(ACTIVITY_POLL, 0),
      createActivityButton(ACTIVITY_PROPOSAL, 0)
    ];
  }

  void dispose() {
    super.dispose();
    inputTitleController.dispose();
    inputIntroController.dispose();
    inputBodyController.dispose();
    inputCabildoController.dispose();
    inputTagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    createHeader();
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
                ...this.header,
                ...createBody(context),
                ...createActionButtons(widget.idUser, dropdownValue),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
              ],
            ),
          );
  }
}