import 'dart:async';
import 'package:cibic_mobile/src/onboard/register2.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';

class Welcome extends StatefulWidget {
  Welcome();

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Key _key;
  FlutterSecureStorage storage = FlutterSecureStorage();
  final welcomeDecoration = BoxDecoration(
    color: COLOR_SOFT_BLUE,
    borderRadius: BorderRadius.circular(15),
  );
  bool errorText;
  String forgetEmail;
  bool showLogin;
  bool isLoginable;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    this.showLogin = false;
    this.isLoginable = true;
    errorText = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final welcomeTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  Widget createButtonView(String str) {
    Decoration buttonDecoration;
    TextStyle style;

    if (str == "Inicia sesión") {
      buttonDecoration = BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      );
      style = TextStyle(
        fontSize: 17,
        color: Colors.white,
      );
    } else {
      buttonDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      );
      style = TextStyle(
        fontSize: 17,
        color: Colors.black,
      );
    }

    return Center(
      child: Container(
        height: 45,
        width: 250,
        alignment: Alignment.center,
        decoration: buttonDecoration,
        child: Text(
          str,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }

  Container createInputView(String str, TextEditingController ctlr) {
    return Container(
      height: 40,
      decoration: loginInputDec,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 7),
      child: Center(
        child: TextField(
          controller: ctlr,
          textAlign: TextAlign.center,
          obscureText: (str == "contraseña"), // password label obscurity
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: str,
            hintStyle: LOGIN_INPUT_TXT,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 100),
        () => this._controller.jumpTo(_controller.position.maxScrollExtent));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: COLOR_DEEP_BLUE,
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 20),
          child: Column(
            children: [
              Container(
                  height: 100,
                  child:
                      Image(image: AssetImage('assets/images/cibic_logo.png'))),
              Container(
                height: MediaQuery.of(context).size.height - 230,
                child: Form(
                  key: _key,
                  child: ListView(
                    reverse: true,
                    controller: this._controller,
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom),
                      Text(
                        '\u00a9 cibic 2020',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Register(this.storage)));
                        },
                        child: createButtonView("Registrate"),
                      ),
                      SizedBox(height: 10),
                      (this.showLogin)
                          ? Divider(
                              color: Colors.white,
                              indent: 20,
                              endIndent: 20,
                              thickness: 0.5,
                            )
                          : Container(),
                      (this.showLogin)
                          ? GestureDetector(
                              onTap: () {
                                //Begins shows Dialog
                                showDialog(
                                  barrierDismissible:
                                      (TargetPlatform.iOS) != null
                                          ? false
                                          : true,
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0))),
                                    contentPadding: EdgeInsets.only(top: 10.0),
                                    title: Center(
                                      child: Text(
                                        "Recuperar contraseña",
                                      ),
                                    ),
                                    content: Container(
                                      width: 300.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Center(
                                              child: Text(
                                                "Ingresa un correo para\n   recuperar tu cuenta.",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 25,
                                              right: 25,
                                              top: 5,
                                            ),
                                            child: TextFormField(
                                              onChanged: (value) {
                                                setState(() {
                                                  forgetEmail = value;
                                                });
                                              },
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                hintText: "nombre@ejemplo.com",
                                                hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25.0,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              // show another dialog
                                              showDialog(
                                                barrierDismissible:
                                                    (TargetPlatform.iOS) != null
                                                        ? false
                                                        : true,
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  32.0))),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 10.0),
                                                  title: Center(
                                                    child: Text(
                                                      "Recuperar contraseña",
                                                    ),
                                                  ),
                                                  content: Container(
                                                    width: 200.0,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 17.0,
                                                            right: 17.0,
                                                            bottom: 17.0,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    children: <
                                                                        TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              "Hemos enviado un mail a "),
                                                                      TextSpan(
                                                                        text:
                                                                            "$forgetEmail ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                          text:
                                                                              "con un\nlink para recuperar tu cuenta."),
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            // show another dialog
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20.0,
                                                                    bottom:
                                                                        20.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          32.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          32.0)),
                                                            ),
                                                            child: Text(
                                                              "Ok",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 20.0, bottom: 20.0),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(32.0),
                                                    bottomRight:
                                                        Radius.circular(32.0)),
                                              ),
                                              child: Text(
                                                "Ok",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                                // End of Shows Dialog
                              },
                              child: Text(
                                "¿Has olvidado la contraseña?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(height: 10),
                      StoreConnector<AppState, _WelcomeViewModel>(
                        converter: (Store<dynamic> store) {
                          Function onLogIn = (String email, String password,
                              BuildContext context) {
                            store.dispatch(
                                LogInAttempt(email, password, context));
                          };
                          Function setLogInLoading = () {
                            store.dispatch(LogInLoading());
                          };
                          return _WelcomeViewModel(
                              store.state.loginState['isSuccess'],
                              store.state.loginState['isLoading'],
                              store.state.loginState['isError'],
                              onLogIn,
                              setLogInLoading);
                        },
                        builder: (BuildContext context, _WelcomeViewModel vm) {
                          return GestureDetector(
                            onTap: () {
                              if (this.showLogin) {
                                if (_emailController.text == null ||
                                    _passwordController.text == null ||
                                    _emailController.text == "" ||
                                    _passwordController.text == "") {
                                  setState(() {
                                    this.showLogin = !this.showLogin;
                                  });
                                } else {
                                  if (this.isLoginable &&
                                      vm.isLoginLoading == false) {
                                    this.isLoginable = false;
                                    vm.setLogInLoading();
                                    vm.onLogIn(_emailController.text,
                                        _passwordController.text, context);
                                  } else {
                                    if (vm.isLoginError == true &&
                                        vm.isLoginLoading == false &&
                                        vm.isLoginSuccess == false) {
                                      this.isLoginable = true;
                                    }
                                  }
                                }
                              } else {
                                setState(() {
                                  this.showLogin = !this.showLogin;
                                  this._controller.jumpTo(
                                      _controller.position.maxScrollExtent);
                                });
                              }
                            },
                            child: createButtonView("Inicia sesión"),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      (this.showLogin & errorText)
                          ? Text(
                              "Error",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                              ),
                            )
                          : Container(),
                      (this.showLogin)
                          ? (createInputView(
                              "contraseña", this._passwordController))
                          : Container(),
                      (this.showLogin)
                          ? (createInputView(
                              "correo electrónico", this._emailController))
                          : Container(),
                      SizedBox(height: 30),
                      // WELCOME
                      Text(
                        "Bienvenido/a",
                        textAlign: TextAlign.center,
                        style: this.welcomeTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void displayDialog(context, title, text) => showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Center(
            child: Text(
              title,
            ),
          ),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    text,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _WelcomeViewModel {
  bool isLoginSuccess;
  bool isLoginLoading;
  bool isLoginError;
  Function onLogIn;
  Function setLogInLoading;
  _WelcomeViewModel(this.isLoginSuccess, this.isLoginLoading, this.isLoginError,
      this.onLogIn, this.setLogInLoading);
}
