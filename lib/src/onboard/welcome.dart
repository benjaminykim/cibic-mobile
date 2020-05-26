import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/onboard/home.dart';
import 'package:cibic_mobile/src/onboard/register.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  final storage;

  Welcome(this.storage);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Key _key;
  final welcomeDecoration = BoxDecoration(
    color: COLOR_SOFT_BLUE,
    borderRadius: BorderRadius.circular(15),
  );
  bool showLogin = false;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  ScrollController _controller = ScrollController();
  bool errorText = false;
  String forgetEmail;
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
    // currently not used
    String _validation(String value) {
      if (value.isEmpty) {
        return "field Cannot be empty";
      }
      if (str == "correo electroníco") {
        // This is just a regular expression for email addresses
        String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
            "\\@" +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
            "(" +
            "\\." +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
            ")+";

        RegExp regExp = RegExp(p);
        if (regExp.hasMatch(value)) {
          // So, the email is valid
          return null;
        }
        // The pattern of the email didn't match the regex above.
        return 'Este no es un correo electrónico válido';
      } else if (str == "contraseña") {
        return null;
      }
    }

    return Container(
      height: 40,
      decoration: LOGIN_INPUT_DEC,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(35, 0, 35, 7),
      child: Center(
        child: TextFormField(
          controller: ctlr,
          textAlign: TextAlign.center,
          obscureText: (str == "contraseña"), // password label obscurity
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: str,
            hintStyle: LOGIN_INPUT_TXT,
          ),
          autovalidate: false,
          validator: _validation,
          onChanged: (value) {
            // where the magic works
          },
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
                      GestureDetector(
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
                              var jwt = await attemptLogin(context);
                              if (jwt != null) {
                                widget.storage.write(key: "jwt", value: jwt);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Home.fromBase64(jwt)));
                              } else {
                                displayDialog(context, "An Error Occurred",
                                    "No account was found matching that username and password");
                              }
                            }
                          } else {
                            setState(() {
                              this.showLogin = !this.showLogin;
                              this
                                  ._controller
                                  .jumpTo(_controller.position.maxScrollExtent);
                            });
                          }
                        },
                        child: createButtonView("Inicia sesión"),
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

  Future<String> attemptLogin(BuildContext context) async {
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
      // print(
      //     "objectsdfghsdjfsdhkfksdfhksdkhgdsghskdhfgdskgsdgsdhgsdkgsdkghsdhgfh");
      // throw Exception("Error");
    }
  }
}
