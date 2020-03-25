import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class Compose extends StatefulWidget {
  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  final inputController = TextEditingController();

  Future<void> addActivity(String title, String amount) async {

    final response = await http.post(URL_LOCALHOST_BASE + ENDPOINT_POST_ACTIVITY);

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

    addActivity(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: inputController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: inputController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text('crear actividad'),
              textColor: Theme.of(context).primaryColor,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
