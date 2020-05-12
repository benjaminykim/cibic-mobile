import 'dart:convert';
import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:cibic_mobile/src/onboard/onboard.dart';
import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username, email, firstname, surname, sex, _value, telephone, password;
  bool usernameVal,
      emailVal,
      firstnameVal,
      surnameVal,
      telephoneVal,
      passwordVal;
  bool privacy;
  final storage = FlutterSecureStorage();

  @override
  initState() {
    super.initState();
    username = "";
    email = "";
    firstname = "";
    surname = "";
    sex = "";
    telephone = "";
    password = "";
    usernameVal = false;
    emailVal = false;
    firstnameVal = false;
    surnameVal = false;
    telephoneVal = false;
    passwordVal = false;
    privacy = false;
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  submitChecker() {
    if (usernameVal == true &&
        emailVal == true &&
        firstnameVal == true &&
        surnameVal == true &&
        telephoneVal == true &&
        passwordVal == true &&
        privacy == true)
      return true;
    else
      return false;
  }

  Widget createPrivacyCheck() {
    return Container(
      margin: EdgeInsets.only(left: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: privacy,
            onChanged: (value) {
              setState(() {
                this.privacy = value;
                // this.isSubmitable = computeSubmitable();
              });
            },
          ),
          Text(
            "Acepto las políticas de privacidad.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  Container textFieldInput({String title, String input}) {
    // for validation
    String _validator(String value) {
      // email validation
      // setState(() {
      // _validate = true;
      // });
      if (title == "correo electrónico*") {
        if (value.isEmpty) {
          // The form is empty
          return "Introducir la dirección de correo electrónico";
        }

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
        return 'Email is not valid';

        // For username
      } else if (title == "nombre de usuario*") {
        String p = "[a-zA-Z0-9\.\_\-]{1,16}";

        RegExp regExp = RegExp(p);
        if (value.trim().isEmpty) {
          return "Nombre de usuario de entrada";
        } else if (value.trim().length > 16) {
          return "Nombre de usuario demasiado largo";
        } else if (regExp.hasMatch(value)) {
          return null;
        } else {
          return "Error";
        }
      }
      // For Surname
      else if (title == "apellido") {
        String p = "[a-zA-Z]{1,16}";

        RegExp regExp = RegExp(p);
        if (value.trim().isEmpty) {
          return "El apellido está vacío";
        }
        if (value.trim().length > 16) {
          return "Demasiado larga";
        } else if (regExp.hasMatch(value)) {
          return null;
        }

        return "Error";
      } else if (title == "nombre de pila") {
        String p = "[a-zA-Z]{1,16}";

        RegExp regExp = RegExp(p);
        if (value.trim().isEmpty) {
          return "El nombre esta vacio";
        }
        if (value.trim().length > 16) {
          return "Demasiado larga";
        } else if (regExp.hasMatch(value)) {
          return null;
        } else {
          return "Error";
        }
      }
      // phone number
      else if (title == "número de teléfono") {
        String p = "[0-9]{9}";

        RegExp regExp = RegExp(p);
        if (value.trim().isEmpty) {
          return "el número de teléfono está vacío";
        }
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return "Error";
        }
      }
      // password
      else if (title == "contraseña") {
        if (value.trim().isEmpty) {
          return "la contraseña está vacía";
        }
        if (value.trim().length < 8) {
          return "la contraseña tiene menos de 8 caracteres";
        } else {
          return null;
        }
      }

      //
      return null;
    }

    void updateValidator(String title) {
      setState(() {
        if (title == "correo electrónico*") {
          emailVal = true;
        } else if (title == "nombre de usuario*") {
          usernameVal = true;
        } else if (title == "apellido") {
          firstnameVal = true;
        } else if (title == "nombre de pila") {
          surnameVal = true;
        } else if (title == "número de teléfono") {
          telephoneVal = true;
        } else if (title == "contraseña") {
          passwordVal = true;
        }
      });
    }

    bool getValidator(String title) {
      if (title == "correo electrónico*") {
        return emailVal;
      } else if (title == "nombre de usuario*") {
        return usernameVal;
      } else if (title == "apellido") {
        return firstnameVal;
      } else if (title == "nombre de pila") {
        return surnameVal;
      } else if (title == "número de teléfono") {
        return telephoneVal;
      } else if (title == "contraseña") {
        return passwordVal;
      }
      return false;
    }

    // for inputing the values
    parseValue(value) {
      if (title == "correo electrónico*") {
        email = value;
      } else if (title == "nombre de usuario*") {
        username = value;
      } else if (title == "apellido") {
        firstname = value;
      } else if (title == "nombre de pila") {
        surname = value;
      } else if (title == "número de teléfono") {
        telephone = value;
      } else if (title == "contraseña") {
        password = value;
      }
    }

    // for checking keyboard type
    TextInputType _keyboardType() {
      if (title == "número de teléfono") {
        return TextInputType.phone;
      } else if (title == "correo electrónico*") {
        return TextInputType.emailAddress;
      } else if (title == "contraseña") {
        return TextInputType.visiblePassword;
      } else
        return null;
    }

    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(
        vertical: 2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 0,
      ),
      child: TextFormField(
        obscureText: (title == "contraseña"),
        onEditingComplete: (title != "contraseña") ? _node.nextFocus : null,
        textInputAction: (title == "contraseña")
            ? TextInputAction.done
            : TextInputAction.next,
        textAlign: TextAlign.center,
        autovalidate: getValidator(title),
        keyboardType: _keyboardType(),
        validator: _validator,
        onChanged: (value) {
          setState(() {
            (title == "nombre de pila" || title == "apellido")
                ? value = StringUtils.capitalize(value)
                : input = value;
            input = value.trim();
            parseValue(input);
            updateValidator(title);
          });
        },
        // onSaved: (val) => username = val,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.white,
          focusColor: COLOR_DEEP_BLUE,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: title,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
        ),

        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Map<String, Map<String, dynamic>> createUserRequestBody() {
    Map<String, Map<String, dynamic>> userRequest = {
      'user': {
        'username': username,
        'password': password,
        'email': email,
        'firstName': firstname,
        'lastName': surname,
        'phone': telephone,
        'cabildos': [],
        'files': "none",
        'followers': [],
        'following': [],
        'activityFeed': []
      }
    };
    return userRequest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: COLOR_SOFT_BLUE,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "REGISTRARSE",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 26,
            ),
          ),
        ),
      ),
      // resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          color: COLOR_DEEP_BLUE,
          child: Form(
            key: _formKey,
            child: FocusScope(
              node: _node,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        "DATOS PERSONALES",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Tus datos son privados.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    textFieldInput(
                      title: "correo electrónico*",
                      input: email,
                    ),
                    textFieldInput(
                      title: "nombre de usuario*",
                      input: username,
                    ),
                    textFieldInput(
                      title: "nombre de pila",
                      input: firstname,
                    ),
                    textFieldInput(
                      title: "apellido",
                      input: surname,
                    ),
                    // Dropdown for Gender
                    Container(
                      height: 50,
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 15),

                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                      // alignment: Alignment.center,
                      decoration: REGISTER_INPUT_DEC,
                      // BoxDecoration(color: Colors.white),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true,
                          isExpanded: true,

                          // autofocus: true,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: "1",
                              child: Center(
                                child: Text(
                                  "Masculina",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "2",
                              child: Center(
                                child: Text(
                                  "Hembra",
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "3",
                              child: Center(
                                child: Text(
                                  "Otro",
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                              if (_value == "1") {
                                sex = "Male";
                              } else if (_value == "2") {
                                sex = "Female";
                              } else {
                                sex = "Others";
                              }
                            });
                          },
                          value: _value,
                          hint: Center(
                            child: Text(
                              "sexo",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    textFieldInput(
                      title: "número de teléfono",
                      input: telephone,
                    ),
                    textFieldInput(
                      title: "contraseña",
                      input: telephone,
                    ),

                    SizedBox(height: 2),

                    // PASSWORD RULES
                    Center(
                      child: Text(
                        'Mínimo 8 caractéres, un número y una mayúscula',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),

                    createPrivacyCheck(),
                    // createSubmitButton("siguiente"),

                    // submit
                    submitChecker()
                        ? GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate() &&
                                  sex != '' &&
                                  privacy) {
                                attemptSubmit(createUserRequestBody())
                                    .then((response) {
                                  if (response ==
                                      "Error: Could Not Register Your Account") {
                                    //show alert dialog
                                    if (Platform.isIOS) {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return CupertinoAlertDialog(
                                              title: Text("Error Response"),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(
                                                        "Error attempting to login"),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('Okay'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Error Response",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(
                                                      "Error attempting to login",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('Okay'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  } else {
                                    attemptLogin(email, password).then((jwt) {
                                      // print("jwt: $jwt");
                                      if (jwt != null) {
                                        storage.write(key: "jwt", value: jwt);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Onboard(jwt)));
                                      } else {
                                        // show alert dialog
                                        if (Platform.isIOS) {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  title: Text("Error Response"),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text(
                                                            "Error attempting to login"),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('Okay'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        } else {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "Error Response",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text(
                                                          "Error attempting to login",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text('Okay'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    });
                                  }
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: COLOR_SOFT_BLUE,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(35, 10, 35, 7),
                              child: Text(
                                "siguiente",
                                textAlign: TextAlign.center,
                                style: REGISTER_TXT,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(35, 10, 35, 7),
                              child: Text(
                                "siguiente",
                                textAlign: TextAlign.center,
                                style: REGISTER_TXT,
                              ),
                            ),
                          ),
                    Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Colors.white,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
