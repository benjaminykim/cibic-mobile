import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:flutter/material.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Compose extends StatefulWidget {
  Compose();

  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  final inputTitleController = TextEditingController();
  final inputBodyController = TextEditingController();
  final inputCabildoController = TextEditingController();
  final inputTagController = TextEditingController();
  int selectedActivity = 0;
  List<int> selectedItems = [];
  PageController _controller = PageController(
    initialPage: 0,
  );
  String dropdownValue = "comparte en un cabildo";

  @override
  void dispose() {
    inputTitleController.dispose();
    inputBodyController.dispose();
    inputCabildoController.dispose();
    inputTagController.dispose();
    _controller.dispose();
    super.dispose();
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

  Container createActivityButton(int type, int pageIndex) {
    return Container(
      width: 68,
      height: 17,
      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: labelColorPicker[type],
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(5),
        color: (pageIndex == this.selectedActivity)
            ? labelColorPicker[type]
            : Colors.transparent,
      ),
      child: GestureDetector(
        onTap: () {
          _controller.jumpToPage(pageIndex);
        },
        child: Center(
          child: Text(
            labelTextPicker[type],
            style: TextStyle(
              color: (pageIndex == this.selectedActivity)
                  ? Colors.white
                  : Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Container createTitle(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
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
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          reverse: true,
          child: TextField(
            controller: inputTitleController,
            scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            maxLines: null,
            inputFormatters: [LengthLimitingTextInputFormatter(80)],
            style: TextStyle(
              fontWeight: FontWeight.w200,
              color: Colors.black,
              fontSize: 15,
            ),
            onSubmitted: (String value) {},
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: title,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget createDiscussionPage(
      BuildContext context, UserModel user, _ComposeViewModel vm) {
    List<DropdownMenuItem<String>> cabildoMenu = [];

    cabildoMenu.add(createMenuItem("comparte en un cabildo"));
    cabildoMenu.add(createMenuItem("todo"));
    for (int i = 0; i < user.cabildos.length; i++) {
      cabildoMenu.add(createMenuItem(user.cabildos[i].name));
    }
    return Column(children: [
      // title
      createTitle("¿De qué se trata?"),
      Container(
        margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
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
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            reverse: true,
            child: TextField(
              controller: inputBodyController,
              scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              maxLines: null,
              inputFormatters: [LengthLimitingTextInputFormatter(1500)],
              style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                  fontSize: 15),
              onSubmitted: (String value) {},
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: "cuéntanos más...",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Color(0xffa1a1a1),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Icon(Icons.people, size: 40),
          ),
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
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
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
                child: GestureDetector(
                  onTap: () {},
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(25),
                      new WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z]"))
                    ],
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: COLOR_DEEP_BLUE,
                      fontSize: 15,
                    ),
                    controller: inputTagController,
                    onChanged: (String value) {
                      if (value == "" || value == null) {
                        // clear the search cache
                        vm.filterTag(value);
                      } else {
                        // TAG FILTER
                        vm.filterTag(value);
                        print(vm.tags);
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "#tags",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: COLOR_DEEP_BLUE,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              (vm.tags.length != 0)
                  ? Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: MediaQuery.of(context).size.width - 108,
                      decoration: BoxDecoration(
                        color: Color(0xffcccccc),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 100,
                          minHeight: 30,
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              indent: 5,
                              endIndent: 5,
                              color: Colors.grey,
                            );
                          },
                          itemCount: vm.tags.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                inputTagController.text =
                                    vm.tags[index]['label'];
                                inputTagController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            inputTagController.text.length));
                                vm.filterTag("");
                              },
                              child: Container(
                                height: 25,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "#" + vm.tags[index]['label'],
                                        style: TextStyle(
                                          color: COLOR_DEEP_BLUE,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Text(
                                        vm.tags[index]['count'].toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(height: 0),
            ],
          ),
        ],
      ),
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
            onPressed: () => submitActivity(dropdownValue, vm),
          ),
        ],
      ),
    ]);
  }

  Widget createPollPage(
      BuildContext context, UserModel user, _ComposeViewModel vm) {
    List<DropdownMenuItem<String>> cabildoMenu = [];

    cabildoMenu.add(createMenuItem("comparte en un cabildo"));
    cabildoMenu.add(createMenuItem("todo"));
    for (int i = 0; i < user.cabildos.length; i++) {
      cabildoMenu.add(createMenuItem(user.cabildos[i].name));
    }
    return Column(children: [
      createTitle("¿Qué quieres preguntar?"),
      Row(
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
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down),
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
                child: GestureDetector(
                  onTap: () {},
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(25),
                      new WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z]"))
                    ],
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: COLOR_DEEP_BLUE,
                      fontSize: 15,
                    ),
                    controller: inputTagController,
                    onChanged: (String value) {
                      if (value == "" || value == null) {
                        // clear the search cache
                        vm.filterTag(value);
                      } else {
                        // TAG FILTER
                        vm.filterTag(value);
                        print(vm.tags);
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "#tags",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: COLOR_DEEP_BLUE,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              (vm.tags.length != 0)
                  ? Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      width: MediaQuery.of(context).size.width - 108,
                      decoration: BoxDecoration(
                        color: Color(0xffcccccc),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 100,
                          minHeight: 30,
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              indent: 5,
                              endIndent: 5,
                              color: Colors.grey,
                            );
                          },
                          itemCount: vm.tags.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                inputTagController.text =
                                    vm.tags[index]['label'];
                                inputTagController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            inputTagController.text.length));
                                vm.filterTag("");
                              },
                              child: Container(
                                height: 25,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "#" + vm.tags[index]['label'],
                                        style: TextStyle(
                                          color: COLOR_DEEP_BLUE,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Text(
                                        vm.tags[index]['count'].toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(height: 0)
            ],
          ),
        ],
      ),
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
            onPressed: () => submitActivity(dropdownValue, vm),
          ),
        ],
      ),
    ]);
  }

  void submitActivity(String cabildoName, _ComposeViewModel vm) async {
    UserModel user = vm.user;
    final enteredTitle = inputTitleController.text;
    final enteredBody = inputBodyController.text;
    final enteredTag = inputTagController.text;
    int idCabildo = -1;

    if (cabildoName != "todo") {
      for (int i = 0; i < user.cabildos.length; i++) {
        if (user.cabildos[i].name == cabildoName) {
          idCabildo = user.cabildos[i].id;
          break;
        }
      }
    }

    if (selectedActivity == 0 || selectedActivity == 2) {
      if (enteredTitle.isEmpty || enteredBody.isEmpty) {
        return;
      } else {
        await vm.submitActivity((selectedActivity == 0) ? 0 : 1, enteredTitle,
            enteredBody, idCabildo, [enteredTag]);
      }
    } else if (selectedActivity == 1) {
      if (enteredTitle.isEmpty) {
        return;
      } else {
        vm.submitActivity(
            2, enteredTitle, enteredBody, idCabildo, [enteredTag]);
      }
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ComposeViewModel>(
      converter: (Store<AppState> store) {
        Function submitActivityCallback = (int type, String title, String body,
                int idCabildo, List<String> tag) =>
            {
              store.dispatch(
                  SubmitActivityAttempt(type, title, body, idCabildo, tag))
            };
        Function filterTag = (String query) {
          store.dispatch(PostTagFilterAttempt(query));
        };

        List<Map<String, dynamic>> tags = store.state.search['composeTags'];
        return _ComposeViewModel(store.state.user['jwt'], store.state.profile,
            submitActivityCallback, filterTag, tags);
      },
      builder: (BuildContext context, _ComposeViewModel vm) {
        return Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 50,
          margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
          decoration: BoxDecoration(
            color: CARD_BACKGROUND,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Crea y comparte contenido",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 5),
              Text(
                "¿Qué quieres compartir?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Row(children: [
                Spacer(),
                createActivityButton(ACTIVITY_DISCUSS, 0),
                createActivityButton(ACTIVITY_POLL, 1),
                Spacer(),
              ]),
              Expanded(
                child: Container(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (int pageIndex) {
                      setState(() {
                        this.selectedActivity = pageIndex;
                      });
                    },
                    children: [
                      createDiscussionPage(context, vm.user, vm),
                      createPollPage(context, vm.user, vm),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ComposeViewModel {
  String jwt;
  UserModel user;
  Function submitActivity;
  Function filterTag;
  List<Map<String, dynamic>> tags;
  _ComposeViewModel(
      this.jwt, this.user, this.submitActivity, this.filterTag, this.tags);
}
