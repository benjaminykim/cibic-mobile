import 'package:cibic_mobile/src/models/cabildo_model.dart';
import 'package:cibic_mobile/src/models/user_model.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:cibic_mobile/src/resources/utils.dart';
import 'package:cibic_mobile/src/widgets/menu/menu-overlay/CreateCabildo.dart';
import 'package:cibic_mobile/src/widgets/profile/CabildoProfileScreen.dart';
import 'package:flutter/material.dart';

class MyCabildos extends StatefulWidget {
  final String jwt;

  MyCabildos(this.jwt);

  @override
  _MyCabildosState createState() => _MyCabildosState();
}

class _MyCabildosState extends State<MyCabildos> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<UserModel> user;

  @override
  void initState() {
    super.initState();
    this.user = fetchUserProfile(extractID(widget.jwt), widget.jwt);
  }

  Future<Null> refreshUser() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      this.user = fetchUserProfile(extractID(widget.jwt), widget.jwt);
    });
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

  Widget cabildoCreate() {
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
              child: CreateCabildo(widget.jwt),
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

  Widget cabildoItem(CabildoModel cabildo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CabildoProfileScreen(cabildo.id, widget.jwt)));
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
                child: FutureBuilder<UserModel>(
                    future: fetchUserProfile(extractID(widget.jwt), widget.jwt),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var cabildos = snapshot.data.cabildos;
                        return ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                            itemCount: cabildos.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return cabildoCreate();
                              } else if (index == cabildos.length + 1) {
                                return cabildoAdd();
                              } else {
                                CabildoModel cabildo = cabildos[index - 1];
                                return cabildoItem(cabildo);
                              }
                            });
                      } else if (snapshot.hasError) {
                        return serverError();
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
          ),
        ));
  }
}
