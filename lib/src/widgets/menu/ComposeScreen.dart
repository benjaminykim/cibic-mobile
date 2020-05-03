import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';

class Compose extends StatefulWidget {
  final String jwt;

  Compose(this.jwt);

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
  Future<UserModel> _user;

  @override
  initState() {
    super.initState();
    this.activityButtons = [
      createActivityButton('discussion', 1),
      createActivityButton('poll', 0),
      createActivityButton('proposal', 0)
    ];

    _user = fetchUserProfile(extractID(widget.jwt), widget.jwt);
  }

  DropdownMenuItem<String> createMenuItem(String value) {
    return DropdownMenuItem<String>(
        value: value,
        child: Container(
          child: Text(value,
              style: TextStyle(
                fontWeight: FontWeight.w200,
                color: Color(0xffa1a1a1),
              )),
        ));
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
        "¿Qué quieres compartir?",
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
          hintText: "De qué se trata?",
          hintStyle: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  List<Widget> createBody(BuildContext context, UserModel user) {
    List<Widget> body = [];
    if (selectedActivity == 0 || selectedActivity == 2) {
      body = [
        // title
        createTitle("¿De qué se trata?"),
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
              hintText: "introducción...",
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
              hintText: "cuéntanos más...",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w200, color: Color(0xffa1a1a1)),
            ),
          ),
        ),
      ];
    } else if (selectedActivity == 1) {
      body = [
        // title
        createTitle("¿Qué quieres preguntar?"),
      ];
    }
    // cabildos and tags
    List<DropdownMenuItem<String>> cabildoMenu = [];

    cabildoMenu.add(createMenuItem("comparte en un cabildo"));
    cabildoMenu.add(createMenuItem("todo"));
    for (int i = 0; i < user.cabildos.length; i++) {
      cabildoMenu.add(createMenuItem(user.cabildos[i].name));
    }

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
                items: cabildoMenu,
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

  void submitActivity(String idCabildo, UserModel user) {
    final enteredTitle = inputTitleController.text;
    final enteredIntro = inputIntroController.text;
    final enteredBody = inputBodyController.text;
    final enteredTag = inputTagController.text;

    if (idCabildo != "todo") {
      for (int i = 0; i < user.cabildos.length; i++) {
        if (user.cabildos[i].name == idCabildo) {
          idCabildo = user.cabildos[i].id;
          break;
        }
      }
    }

    if (selectedActivity == 0 || selectedActivity == 2) {
      if (enteredTitle.isEmpty || enteredIntro.isEmpty || enteredBody.isEmpty) {
        return;
      } else {
        composeActivity(enteredTitle, enteredIntro, enteredBody, idCabildo,
            enteredTag, widget.jwt);
      }
    } else if (selectedActivity == 1) {
      if (enteredTitle.isEmpty || idCabildo.isEmpty) {
        return;
      } else {
        composePoll(enteredTitle, idCabildo, enteredTag, widget.jwt);
      }
    }
    Navigator.of(context).pop();
  }

  List<Widget> createActionButtons(String cabildoName, UserModel user) {
    return [
      Spacer(),
      Row(
        children: <Widget>[
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () { Navigator.of(context).pop(); },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => submitActivity(cabildoName, user),
          ),
        ],
      )
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
    return FutureBuilder(
      future: _user,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
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
                ...createBody(context, snapshot.data),
                ...createActionButtons(dropdownValue, snapshot.data),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
