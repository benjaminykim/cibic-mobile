import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:flutter/material.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Search extends StatefulWidget {
  Search();

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final inputSearchController = TextEditingController();
  var inputBorderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(width: 1, color: Colors.transparent));

  @override
  void initState() {
    super.initState();
  }

  void submitSearch(_SearchViewModel vm) {
    final enteredSearchQuery = inputSearchController.text;
    vm.submitSearchQuery(enteredSearchQuery);
  }

  void dispose() {
    inputSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SearchViewModel>(
      converter: (Store<AppState> store) {
        Function submitSearchQuery =
            (String query) => {store.dispatch(PostSearchAttempt(query))};
        return _SearchViewModel(
            store.state.user,
            submitSearchQuery,
            store.state.searchActivity,
            store.state.searchUser,
            store.state.searchCabildo);
      },
      builder: (BuildContext context, _SearchViewModel vm) {
        return Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 50,
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
              // SEARCH INPUT
              Container(
                  width: double.infinity,
                  height: 30,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffcccccc),
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: inputSearchController,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            hintText: "buscar...",
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: inputBorderDecoration,
                            focusedBorder: inputBorderDecoration,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: InkWell(
                          onTap: () => submitSearch(vm),
                          child:
                              Icon(Icons.search, color: Colors.black, size: 25),
                        ),
                      ),
                    ],
                  )),
              // SEARCH RESULTS
              Container(
                height: MediaQuery.of(context).size.height - 150,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                decoration: BoxDecoration(
                  color: Color(0xfff5f6f7),
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                child: ListView.builder(
                    itemCount: vm.searchActivity.length + vm.searchUser.length + vm.searchCabildo.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < vm.searchActivity.length) {
                      return Text(
                        vm.searchActivity[index].title,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      );
                      } else if (index - vm.searchActivity.length < vm.searchUser.length) {
                      return Text(
                        vm.searchUser[index - vm.searchActivity.length].firstName + " " + vm.searchUser[index].lastName,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      );
                      } else if (index - vm.searchActivity.length - vm.searchUser.length < vm.searchCabildo.length) {
                      return Text(
                        vm.searchCabildo[index - vm.searchActivity.length - vm.searchCabildo.length - vm.searchActivity.length].name,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      );
                      } else {
                        return Text("no hay nada");
                      }
                    },
                  ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchViewModel {
  UserModel user;
  Function submitSearchQuery;
  List<ActivityModel> searchActivity;
  List<UserModel> searchUser;
  List<CabildoModel> searchCabildo;
  _SearchViewModel(this.user, this.submitSearchQuery, this.searchActivity,
      this.searchUser, this.searchCabildo);
}
