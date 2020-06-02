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
  FlutterSecureStorage storage = FlutterSecureStorage();
  final welcomeDecoration = BoxDecoration(
    color: COLOR_SOFT_BLUE,
    borderRadius: BorderRadius.circular(15),
  );
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
                    StoreConnector<AppState, _WelcomeViewModel>(
                      converter: (Store<dynamic> store) {
                        Function onLogIn = (String email, String password,
                            BuildContext context) {
                          store
                              .dispatch(LogInAttempt(email, password, context));
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
