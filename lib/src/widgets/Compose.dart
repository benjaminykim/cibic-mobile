import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class Compose extends StatefulWidget {
  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  final inputController = TextEditingController();
  List<Container> activityButtons;
  int selectedActivity = 0;

  Future<void> addActivity(String title, String amount) async {
    final response =
        await http.post(URL_LOCALHOST_BASE + ENDPOINT_POST_ACTIVITY);

    if (response.statusCode == 200) {
      print("success");
    } else {
      throw Exception('Failed to load home feed');
    }
  }

  void submitData() {
    final enteredTitle = inputController.text;
    final enteredAmount = inputController.text;

    if (enteredTitle.isEmpty || enteredAmount.isEmpty) {
      return;
    }
    //addActivity(enteredTitle, enteredAmount);
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
    activityButtons = [
      createActivityButton(ACTIVITY_DISCUSS, 1),
      createActivityButton(ACTIVITY_POLL, 0),
      createActivityButton(ACTIVITY_PROPOSAL, 0)
    ];
  }

  @override
  Widget build(BuildContext context) {
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
          Text(
            "Crea y comparte contenido",
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 5),
          Text(
            "Que quieres compartir?",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10),
          Row(children: activityButtons),
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: Text(
              "De que se trata?",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputController,
              decoration: InputDecoration(

                hintText: "introduccion",
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w200, color: Colors.white70),
              ),
            ),
          ),
          FlatButton(
            child: Text('crear actividad'),
            textColor: Colors.black,
            onPressed: submitData,
          )
        ],
      ),
    );
  }
}
