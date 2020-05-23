import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/CreateCabildo.dart';
import 'package:cibic_mobile/src/widgets/profile/CabildoProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MyCabildos extends StatefulWidget {
  MyCabildos();

  @override
  _MyCabildosState createState() => _MyCabildosState();
}

class _MyCabildosState extends State<MyCabildos> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshUser() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  Widget cabildoAdd() {
    return Container(
      height: 65,
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: Icon(Icons.add_circle_outline, size: 50),
          ),
          Text(
            "Agregar cabildo",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget cabildoCreate(_MyCabildosViewModel vm) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          elevation: 5,
          backgroundColor: Colors.transparent,
          builder: (bContext) {
            return GestureDetector(
              onTap: () {},
              child: CreateCabildo(vm.store),
              behavior: HitTestBehavior.opaque,
            );
          },
        );
      },
      child: Container(
        height: 65,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Icon(Icons.create, size: 35),
            ),
            Text(
              "Crear un cabildo",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cabildoItem(CabildoModel cabildo, Store store) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CabildoProfileScreen(cabildo.id)));
      },
      child: Container(
        height: 65,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
              decoration: new BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              cabildo.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _MyCabildosViewModel>(
      converter: (Store<AppState> store) {
        return _MyCabildosViewModel(store.state.user, store);
      },
      builder: (BuildContext context, _MyCabildosViewModel vm) {
        List<CabildoModel> cabildos = vm.user.cabildos;
        return MaterialApp(
          theme: cibicTheme,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Text("MIS CABILDOS",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  )),
              centerTitle: true,
              titleSpacing: 0.0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Container(
              color: APP_BACKGROUND,
              child: RefreshIndicator(
                key: refreshKey,
                onRefresh: refreshUser,
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                  ),
                  itemCount: cabildos.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return cabildoCreate(vm);
                    } else if (index == cabildos.length + 1) {
                      return cabildoAdd();
                    } else {
                      CabildoModel cabildo = cabildos[index - 1];
                      return cabildoItem(cabildo, vm.store);
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MyCabildosViewModel {
  UserModel user;
  Store store;
  _MyCabildosViewModel(this.user, this.store);
}
