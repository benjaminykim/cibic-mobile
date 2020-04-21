import 'package:cibic_mobile/src/onboard/home.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UserEducation extends StatefulWidget {
  final jwt;

  UserEducation(this.jwt);

  @override
  _UserEducationState createState() => _UserEducationState();
}

class _UserEducationState extends State<UserEducation> {
  final _controller = ScrollController();
  ScrollPhysics _physics;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.haveDimensions && _physics == null) {
        setState(() {
          var dimension = _controller.position.maxScrollExtent / (5);
          _physics = CardScrollPhysics(itemDimension: dimension);
        });
      }
    });
  }

  final TextStyle descStyle = TextStyle(
    fontSize: 14,
    color: Colors.white,
  );
  final TextStyle headerStyle = TextStyle(
    fontSize: 27,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  Widget pageBuilder(
      BuildContext context, Widget list, bool padding, bool margin) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: (margin) ? EdgeInsets.fromLTRB(0, 0, 0, 0) : EdgeInsets.zero,
      padding: (padding)
          ? EdgeInsets.fromLTRB(30, 100, 30, 40)
          : EdgeInsets.fromLTRB(0, 0, 0, 30),
      color: COLOR_DEEP_BLUE,
      child: list,
    );
  }

  Widget pageMark(int pageIndex) {
    Widget circle(bool marked) {
      return Container(
        width: 10,
        height: 10,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: new BoxDecoration(
          color: (marked) ? Colors.white : Colors.grey,
          shape: BoxShape.circle,
        ),
      );
    }

    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          circle(0 == pageIndex),
          circle(1 == pageIndex),
          circle(2 == pageIndex),
          circle(3 == pageIndex),
          circle(4 == pageIndex),
          circle(5 == pageIndex),
        ],
      ),
    );
  }

  Widget page1(BuildContext context) {
    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Image(image: AssetImage('assets/images/user_education_1.png')),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          margin: EdgeInsets.fromLTRB(0, 70, 0, 20),
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: COLOR_SOFT_BLUE,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            "¿Qué es cibic?",
            textAlign: TextAlign.center,
            style: headerStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            "Cibic es una red social civica, una herramienta de organizacion social que permite la interaccion entre todos los ciudadanos de Chile",
            textAlign: TextAlign.left,
            style: descStyle,
          ),
        ),
        Spacer(),
        pageMark(0),
      ],
    );
    return pageBuilder(context, column, true, true);
  }

  Widget page2(BuildContext context) {
    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Image(image: AssetImage('assets/images/user_education_2.png')),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          margin: EdgeInsets.fromLTRB(0, 70, 0, 20),
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: COLOR_SOFT_BLUE,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            "¿Por qué usar cibic?",
            textAlign: TextAlign.center,
            style: headerStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            "Se parte de una plataforma segura donde podras informarte, expresarte y poder influir directamente en la construccion de un nuevo Chile.",
            textAlign: TextAlign.left,
            style: descStyle,
          ),
        ),
        Spacer(),
        pageMark(1),
      ],
    );
    return pageBuilder(context, column, true, true);
  }

  Widget page3(BuildContext context) {
    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Image(image: AssetImage('assets/images/user_education_3.png')),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          margin: EdgeInsets.fromLTRB(0, 70, 0, 20),
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: COLOR_SOFT_BLUE,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            "¿Cómo usar cibic?",
            textAlign: TextAlign.center,
            style: headerStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            "Registrate en Cibic, genera temas de discusion, informarte, expresate y transformate en un Ciudadano Inteligente.",
            textAlign: TextAlign.left,
            style: descStyle,
          ),
        ),
        Spacer(),
        pageMark(2),
      ],
    );
    return pageBuilder(context, column, true, true);
  }

  Widget page4(BuildContext context) {
    Stack stack = Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 30, 30, 0),
          alignment: Alignment.topRight,
          child: Image.asset(
            'assets/images/user_education_4a.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 45,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Text(
                    "Cabildos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(30, 10, 100, 70),
                child: Text(
                  "Crea tus propios cabildos digitales y expone los temas de discusión más relevantes para tus seguidores y toda la comunidad Cibic.",
                  style: descStyle,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 45,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  child: Text(
                    "Cartas de Propuestas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(100, 10, 30, 0),
                child: Text(
                  "Crea una carta de propuesta y presenta opinión de los temas más trascendentes de la actualidad. ¡Todos queremos expresarnos!",
                  style: descStyle,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
          alignment: Alignment.bottomLeft,
          child: Image.asset(
            'assets/images/user_education_4b.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        pageMark(3),
      ],
    );
    return pageBuilder(context, stack, false, true);
  }

  Widget page5(BuildContext context) {
    Stack stack = Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
          alignment: Alignment.topLeft,
          child: Image.asset(
            'assets/images/user_education_5a.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 45,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(width: 0.5, color: Colors.white),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  child: Text(
                    "Cartas de Discusión",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(100, 10, 30, 70),
                child: Text(
                  "Desarrolla cartas de discusión y genera debate entre toda la comunidad. ¡El respeto y la tolerancia es la esencia de un ciudadano inteligente!",
                  style: descStyle,
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 45,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Text(
                    "Cartas de Encuestas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(30, 10, 100, 0),
                child: Text(
                  "¿De acuerdo o en desacuerdo? Crea cartas de encuestas cerradas y genera interacción con toda la comunidad Cibic. Además podrás ver todos los resultados en la pantalla de estadísticas.",
                  style: descStyle,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
          alignment: Alignment.bottomRight,
          child: Image.asset(
            'assets/images/user_education_5b.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        pageMark(4),
      ],
    );
    return pageBuilder(context, stack, false, true);
  }

  Widget page6(BuildContext context) {
    Column start = Column(
      children: <Widget>[
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Home.fromBase64(widget.jwt)));
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: COLOR_SOFT_BLUE,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              "Comienzo",
              textAlign: TextAlign.center,
              style: headerStyle,
            ),
          ),
        ),
        Spacer(),
        pageMark(5),
      ],
    );
    return pageBuilder(context, start, true, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: COLOR_DEEP_BLUE,
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          physics: _physics,
          dragStartBehavior: DragStartBehavior.down,
          children: <Widget>[
            page1(context),
            page2(context),
            page3(context),
            page4(context),
            page5(context),
            page6(context),
          ],
        ),
      ),
    );
  }
}


class CardScrollPhysics extends ScrollPhysics {
  final double itemDimension;

  CardScrollPhysics({this.itemDimension, ScrollPhysics parent})
      : super(parent: parent);

  @override
  CardScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CardScrollPhysics(
        itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getPage(ScrollPosition position) {
    return position.pixels / itemDimension;
  }

  double _getPixels(double page) {
    return page * itemDimension;
  }

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return _getPixels(page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}