import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:flutter/material.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Description extends StatefulWidget {
  Description();

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  TextEditingController inputDescriptionController;
  var inputBorderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 1, color: Colors.transparent));

  void submitDescription(_DescriptionViewModel vm) {
    final enteredDescription = inputDescriptionController.text;
    if (enteredDescription == "" || enteredDescription == null) return;
    print(enteredDescription);
    vm.submitDescription(enteredDescription);
  }

  @override
  void initState() {
    super.initState();
    inputDescriptionController = new TextEditingController();
  }

  @override
  void dispose() {
    inputDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _DescriptionViewModel>(
      converter: (Store<AppState> store) {
        Function submitDescription = (String description) =>
            {store.dispatch(PutDescriptionAttempt(description))};
        return _DescriptionViewModel(submitDescription);
      },
      builder: (BuildContext context, _DescriptionViewModel vm) {
        return Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 50,
          margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
          decoration: BoxDecoration(
            color: APP_BACKGROUND,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // DESCRIPTION INPUT
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
                    maxHeight: 200.0,
                  ),
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    reverse: true,
                    child: TextField(
                      controller: inputDescriptionController,
                      scrollPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      maxLines: null,
                      inputFormatters: [LengthLimitingTextInputFormatter(1500)],
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                          fontSize: 15),
                      onSubmitted: (String value) {
                        submitDescription(vm);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "entra una nueva descripción...",
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
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      inputDescriptionController.clear();
                      inputDescriptionController.dispose();
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      submitDescription(vm);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DescriptionViewModel {
  Function submitDescription;
  _DescriptionViewModel(this.submitDescription);
}
