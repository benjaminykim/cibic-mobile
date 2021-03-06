import 'package:cibic_mobile/src/redux/actions/actions_cabildo.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class CreateCabildo extends StatefulWidget {
  final Store store;

  CreateCabildo(this.store);

  @override
  _CreateCabildoState createState() => _CreateCabildoState();
}

class _CreateCabildoState extends State<CreateCabildo> {
  final inputNameController = TextEditingController();
  final inputDescController = TextEditingController();
  final inputLocationController = TextEditingController();

  void dispose() {
    inputNameController.dispose();
    inputDescController.dispose();
    inputLocationController.dispose();
    super.dispose();
  }

  void submitCabildo() {
    final enteredName = inputNameController.text;
    final enteredDesc = inputDescController.text;
    final enteredLocation = inputLocationController.text;

    if (enteredName.isEmpty || enteredDesc.isEmpty || enteredLocation.isEmpty) {
      return;
    } else {
      widget.store.dispatch(SubmitCabildoAttempt(
          enteredName, enteredDesc, enteredLocation, "", context));
    }
  }

  List<Widget> createActionButtons() {
    return [
      Spacer(),
      Row(
        children: <Widget>[
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => submitCabildo(),
          ),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
            height: 33,
            child: Text(
              "NUEVO CABILDO",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: new ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 25,
                maxHeight: 100.0,
              ),
              child: new SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: TextField(
                  controller: inputNameController,
                  scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  maxLines: null,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Nombre del Cabildo",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: Color(0xffa1a1a1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: new ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 25,
                maxHeight: 100.0,
              ),
              child: new SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: TextField(
                  controller: inputDescController,
                  maxLines: null,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "descripción...",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: Color(0xffa1a1a1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
            padding: EdgeInsets.fromLTRB(10, 14, 0, 0),
            height: 33,
            decoration: BoxDecoration(
              color: Color(0xffcccccc),
              borderRadius: BorderRadius.all(Radius.circular(13)),
            ),
            child: TextField(
              controller: inputLocationController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "ubicación...",
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
              ),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Spacer(),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (inputNameController.text != "" ||
                        inputNameController.text != null ||
                        inputDescController.text != "" ||
                        inputDescController.text != null ||
                        inputLocationController.text != "" ||
                        inputLocationController.text != null) {
                      submitCabildo();
                    }
                  }),
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
