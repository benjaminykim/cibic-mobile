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
  int offset = 0;

  List<String> searchButtonTextPicker = [
    "Todo",
    "Actividad",
    "Usuario",
    "Cabildo",
    "Tags",
  ];

  Widget noResultsFound = Container(
    height: double.infinity,
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
    child: Text("No se han encontrado resultados para tu búsqueda"),
  );

  @override
  void initState() {
    super.initState();
  }

  void submitSearch(_SearchViewModel vm) {
    final enteredSearchQuery = inputSearchController.text;
    if (enteredSearchQuery == "" || enteredSearchQuery == null) return;
    vm.submitSearchQuery(enteredSearchQuery);
  }

  @override
  void dispose() {
    inputSearchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget tagItem(
      Map<String, dynamic> tag, Function onReact, Function onSave, Function onSearchActivityByTag, int mode) {
    return Container(
      height: 30,
      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: GestureDetector(
        onTap: () async {
          await onSearchActivityByTag(tag['label']);
          _controller.jumpToPage(1);
        },
        child: Text(
          "#" + tag['label'],
          style: TextStyle(
            color: COLOR_DEEP_BLUE,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget searchPageTodo(_SearchViewModel vm) {
    if (vm.searchActivity.length == 0 &&
        vm.searchCabildo.length == 0 &&
        vm.searchUser.length == 0 &&
        vm.searchTag.length == 0) {
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
            vm.searchCabildo.length +
            vm.searchTag.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < vm.searchActivity.length) {
            ActivityModel activity = vm.searchActivity[index];
            return SearchActivityCard(
                activity, activity.activityType, vm.onReact, vm.onSave, 6);
          } else if (index < vm.searchActivity.length + vm.searchUser.length) {
            UserModel user = vm.searchUser[index - vm.searchActivity.length];
            return UserCard(user);
          } else if (index <
              vm.searchActivity.length +
                  vm.searchUser.length +
                  vm.searchCabildo.length) {
            CabildoModel cabildo = vm.searchCabildo[
                index - vm.searchUser.length - vm.searchActivity.length];
            return CabildoCard(cabildo);
          } else {
            return tagItem(
                vm.searchTag[index -
                    vm.searchUser.length -
                    vm.searchActivity.length -
                    vm.searchCabildo.length],
                vm.onReact,
                vm.onSave,
                vm.onSearchActivityByTag,
                7);
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

  Widget searchPageTag(_SearchViewModel vm) {
    if (vm.searchTag.length == 0) {
      return this.noResultsFound;
    } else {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
          indent: 10,
          endIndent: 10,
        ),
        itemCount: vm.searchTag.length,
        itemBuilder: (BuildContext context, int index) {
          return tagItem(vm.searchTag[index], vm.onReact, vm.onSave, vm.onSearchActivityByTag, 7);
        },
      );
    }
  }

  Widget createSearchOptionButton(int mode) {
    return Container(
      width: 55,
      height: 17,
      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
        borderRadius: BorderRadius.circular(5),
        color:
            (this.selectedPage == mode) ? COLOR_DEEP_BLUE : Colors.transparent,
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
            (String query) => {store.dispatch(PostSearchAttempt(query, this.offset))};
        Function onReact = (ActivityModel activity, int reactValue) =>
            store.dispatch(PostReactionAttempt(activity, reactValue, -1));
        Function onSave = (int activityId) =>
            store.dispatch(PostSaveAttempt(activityId, true));
        Function onSearchActivityByTag = (String query) =>
            store.dispatch(PostSearchActivityByTagAttempt(query, this.offset));
        return _SearchViewModel(
            store.state.profile,
            submitSearchQuery,
            store.state.search['activity'],
            store.state.search['user'],
            store.state.search['cabildo'],
            store.state.search['tag'],
            onReact,
            onSave,
            onSearchActivityByTag);
      },
      builder: (BuildContext context, _SearchViewModel vm) {
        return Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
              // SEARCH INPUT
              Container(
                  width: double.infinity,
                  height: 30,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                          onEditingComplete: () => submitSearch(vm),
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
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                alignment: Alignment.center,
                height: 20,
                child: Row(
                  children: [
                    Spacer(),
                    createSearchOptionButton(0),
                    createSearchOptionButton(1),
                    createSearchOptionButton(2),
                    createSearchOptionButton(3),
                    createSearchOptionButton(4),
                    Spacer(),
                  ],
                ),
              ),
              // SEARCH RESULTS
              Container(
                height: MediaQuery.of(context).size.height - 155,
                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
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
                    searchPageTag(vm),
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
  List<Map<String, dynamic>> searchTag;
  Function onReact;
  Function onSave;
  Function onSearchActivityByTag;
  _SearchViewModel(
      this.user,
      this.submitSearchQuery,
      this.searchActivity,
      this.searchUser,
      this.searchCabildo,
      this.searchTag,
      this.onReact,
      this.onSave,
      this.onSearchActivityByTag);
}
