import 'package:cibic_mobile/src/models/activity_model.dart';
import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_activity.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/widgets/activity/CabildoCard.dart';
import 'package:cibic_mobile/src/widgets/activity/SearchActivityCard.dart';
import 'package:cibic_mobile/src/widgets/activity/UserCard.dart';
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
  int selectedPage = 0;
  PageController _controller = PageController(
    initialPage: 0,
  );

  List<String> searchButtonTextPicker = [
    "Todo",
    "Actividad",
    "Usuario",
    "Cabildo"
  ];

  Widget noResultsFound = Container(
    height: double.infinity,
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
    child: Text("No Results Found"),
  );

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
    _controller.dispose();
    super.dispose();
  }

  Widget searchPageTodo(_SearchViewModel vm) {
    if (vm.searchActivity.length == 0 &&
        vm.searchCabildo.length == 0 &&
        vm.searchUser.length == 0) {
      return this.noResultsFound;
    } else {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
          indent: 10,
          endIndent: 10,
        ),
        itemCount: vm.searchActivity.length +
            vm.searchUser.length +
            vm.searchCabildo.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < vm.searchActivity.length) {
            ActivityModel activity = vm.searchActivity[index];
            return SearchActivityCard(
                activity, activity.activityType, vm.onReact, vm.onSave, 6);
          } else if (index < vm.searchActivity.length + vm.searchUser.length) {
            UserModel user = vm.searchUser[index - vm.searchActivity.length];
            return UserCard(user);
          } else {
            CabildoModel cabildo = vm.searchCabildo[index - vm.searchUser.length - vm.searchActivity.length];
            return CabildoCard(cabildo);
          }
        },
      );
    }
  }

  Widget searchPageActivity(_SearchViewModel vm) {
    if (vm.searchActivity.length == 0) {
      return this.noResultsFound;
    } else {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
          indent: 10,
          endIndent: 10,
        ),
        itemCount: vm.searchActivity.length,
        itemBuilder: (BuildContext context, int index) {
          ActivityModel activity = vm.searchActivity[index];
          return SearchActivityCard(
              activity, activity.activityType, vm.onReact, vm.onSave, 6);
        },
      );
    }
  }

  Widget searchPageUser(_SearchViewModel vm) {
    if (vm.searchUser.length == 0) {
      return this.noResultsFound;
    } else {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
          indent: 10,
          endIndent: 10,
        ),
        itemCount: vm.searchUser.length,
        itemBuilder: (BuildContext context, int index) {
          UserModel user = vm.searchUser[index];
          return UserCard(user);
        },
      );
    }
  }

  Widget searchPageCabildo(_SearchViewModel vm) {
    if (vm.searchCabildo.length == 0) {
      return this.noResultsFound;
    } else {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
          indent: 10,
          endIndent: 10,
        ),
        itemCount: vm.searchCabildo.length,
        itemBuilder: (BuildContext context, int index) {
          CabildoModel cabildo = vm.searchCabildo[index];
          return CabildoCard(cabildo);
        },
      );
    }
  }

  Widget createSearchOptionButton(int mode) {
    return Container(
      width: 68,
      height: 17,
      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(5),
        color: (this.selectedPage == mode) ? Colors.blue : Colors.transparent,
      ),
      child: GestureDetector(
        onTap: () {
          _controller.jumpToPage(mode);
        },
        child: Center(
          child: Text(
            searchButtonTextPicker[mode],
            style: TextStyle(
              color: (this.selectedPage == mode) ? Colors.white : Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SearchViewModel>(
      converter: (Store<AppState> store) {
        Function submitSearchQuery =
            (String query) => {store.dispatch(PostSearchAttempt(query))};
        Function onReact = (ActivityModel activity, int reactValue) =>
            store.dispatch(PostReactionAttempt(activity, reactValue, 6));
        Function onSave = (int activityId) =>
            store.dispatch(PostSaveAttempt(activityId, true));
        return _SearchViewModel(
            store.state.profile['selfUser'],
            submitSearchQuery,
            store.state.search['activity'],
            store.state.search['cabildo'],
            store.state.search['user'],
            onReact,
            onSave);
      },
      builder: (BuildContext context, _SearchViewModel vm) {
        return Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 50,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              color: APP_BACKGROUND,
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
              // SEARCH OPTIONS
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 20,
                child: Row(
                  children: [
                    createSearchOptionButton(0),
                    createSearchOptionButton(1),
                    createSearchOptionButton(2),
                    createSearchOptionButton(3),
                  ],
                ),
              ),
              // SEARCH RESULTS
              Container(
                height: MediaQuery.of(context).size.height - 155,
                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                    color: Colors.black,
                    width: 1,
                  )),
                ),
                child: PageView(
                  controller: _controller,
                  onPageChanged: (int pageIndex) {
                    setState(() {
                      this.selectedPage = pageIndex;
                    });
                  },
                  children: [
                    searchPageTodo(vm),
                    searchPageActivity(vm),
                    searchPageUser(vm),
                    searchPageCabildo(vm),
                  ],
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
  Function onReact;
  Function onSave;
  _SearchViewModel(this.user, this.submitSearchQuery, this.searchActivity,
      this.searchUser, this.searchCabildo, this.onReact, this.onSave);
}
