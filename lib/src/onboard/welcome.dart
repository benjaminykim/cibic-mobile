import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/onboard/home.dart';
import 'package:cibic_mobile/src/onboard/register.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Welcome extends StatefulWidget {
  final storage;

  Welcome(this.storage);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final welcomeDecoration = BoxDecoration(
    color: COLOR_SOFT_BLUE,
    borderRadius: BorderRadius.circular(15),
  );
  bool showLogin = false;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  ScrollController _controller = ScrollController();

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
      margin: EdgeInsets.fromLTRB(35, 0, 35, 7),
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
                child: ListView(
                  reverse: true,
                  controller: this._controller,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
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
                                    Register(widget.storage)));
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
                        ? Text(
                            "¿Has olvidado la contraseña?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          )
                        : Container(),
                    SizedBox(height: 10),
                    StoreConnector<AppState, Function>(
                      converter: (Store<dynamic> store) {
                        return () => store;
                      },
                      builder: (BuildContext context, vm) {
                        return GestureDetector(
                          onTap: () async {
                            if (this.showLogin) {
                              if (_emailController.text == null ||
                                  _passwordController.text == null ||
                                  _emailController.text == "" ||
                                  _passwordController.text == "") {
                                setState(() {
                                  this.showLogin = !this.showLogin;
                                });
                              } else {
                                await vm().dispatch(LogInAttempt(
                                    _emailController.text,
                                    _passwordController.text));
                                if (vm().state.isLogIn) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home("", "")));
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
            ],
          ),
        ));
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  Future<String> attemptLogin1() async {
    Map requestBody = {
      'email': '${_emailController.text}',
      'password': '${_passwordController.text}'
    };
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_LOGIN));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(requestBody)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    if (response.statusCode == 201) {
      final responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jwtResponse = jsonDecode(responseBody);
      return jwtResponse['access_token'];
    } else {
      throw Exception("Error");
    }
  }
}
