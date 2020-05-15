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
  bool emailVal, fullNameVal, telephoneVal, passwordVal, passwordConfirmVal;
  bool privacy;
  final storage = FlutterSecureStorage();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusScopeNode _node = FocusScopeNode();
  String email, fullName, telephone, password, passwordConfirm;

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    email = "";
    fullName = "";
    telephone = "";
    password = "";
    emailVal = false;
    fullNameVal = false;
    telephoneVal = false;
    passwordVal = false;
    privacy = false;
    passwordConfirmVal = false;
  }

  submitChecker() {
    if (
        // usernameVal == true &&
        emailVal == true &&
            fullNameVal == true &&
            // surnameVal == true &&
            telephoneVal == true &&
            passwordVal == true &&
            privacy == true &&
            passwordConfirmVal == true)
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
            "Acepto las ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            "políticas de privacidad.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w200,
              decoration: TextDecoration.underline,
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

      if (title == "Correo electroníco*") {
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
      }
      //   // For username
      //  else if (title == "nombre de usuario*") {
      //   String p = "[a-zA-Z0-9\.\_\-]{1,16}";

      //   RegExp regExp = RegExp(p);
      //   if (value.trim().isEmpty) {
      //     return "Nombre de usuario de entrada";
      //   } else if (value.trim().length > 16) {
      //     return "Nombre de usuario demasiado largo";
      //   } else if (regExp.hasMatch(value)) {
      //     return null;
      //   } else {
      //     return "Error";
      //   }
      // }
      // For Fullname
      else if (title == "Numbre y Apellido*") {
        if (value.trim().isEmpty) {
          return "El apellido está vacío";
        }
        if (value.trim().length < 5) {
          return "Demasiado corta";
        } else {
          return null;
        }
      }
      // else if (title == "nombre de pila") {
      //   String p = "[a-zA-Z]{1,16}";

      //   RegExp regExp = RegExp(p);
      //   if (value.trim().isEmpty) {
      //     return "El nombre esta vacio";
      //   }
      //   if (value.trim().length > 16) {
      //     return "Demasiado larga";
      //   } else if (regExp.hasMatch(value)) {
      //     return null;
      //   } else {
      //     return "Error";
      //   }
      // }
      // phone number
      else if (title == "Número móvil*") {
        String p = "[0-9]{9}";

        RegExp regExp = RegExp(p);
        if (value.trim().isEmpty) {
          return "el Número móvil está vacío";
        }
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return "Error";
        }
      }
      // password
      else if (title == "Contraseña") {
        RegExp strongRegex = new RegExp(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})");
        if (value.isEmpty) {
          return "la contraseña está vacía";
        }
        if (strongRegex.hasMatch(value)) {
          return null;
        } else {
          return "no coincide";
        }
      } else if (title == "Confirmar contraseña") {
        if (value.isEmpty) {
          return "la contraseña está vacía";
        } else if (value != password) {
          return "La contraseña no coincide";
        } else {
          return null;
        }
      }
      return null;
    }

    void updateValidator(String title) {
      setState(() {
        if (title == "Correo electroníco*") {
          emailVal = true;
        }
        //  else if (title == "nombre de usuario*") {
        //   usernameVal = true;
        // }
        else if (title == "Numbre y Apellido*") {
          fullNameVal = true;
        }
        //  else if (title == "nombre de pila") {
        //   surnameVal = true;
        // }
        else if (title == "Número móvil*") {
          telephoneVal = true;
        } else if (title == "Contraseña") {
          passwordVal = true;
        } else if (title == "Confirmar contraseña") {
          passwordConfirmVal = true;
        }
      });
    }

    bool getValidator(String title) {
      if (title == "Correo electroníco*") {
        return emailVal;
      }
      // else if (title == "nombre de usuario*") {
      //   return usernameVal;
      // }
      else if (title == "Numbre y Apellido*") {
        return fullNameVal;
      } else if (title == "Número móvil*") {
        return telephoneVal;
      } else if (title == "Contraseña") {
        return passwordVal;
      } else if (title == "Confirmar contraseña") {
        return passwordConfirmVal;
      }
      return false;
    }

    // for inputing the values
    parseValue(value) {
      if (title == "Correo electroníco*") {
        email = value;
      } else if (title == "Numbre y Apellido*") {
        fullName = value;
      } else if (title == "Número móvil*") {
        telephone = value;
      } else if (title == "Contraseña") {
        password = value;
      } else if (title == "Confirmar contraseña") {
        passwordConfirm = value;
      }
    }

    // for checking keyboard type
    TextInputType _keyboardType() {
      if (title == "Número móvil*") {
        return TextInputType.phone;
      } else if (title == "Correo electroníco*") {
        return TextInputType.emailAddress;
      } else if (title == "Contraseña") {
        return TextInputType.visiblePassword;
      } else if (title == "Confirmar contraseña") {
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
        inputFormatters: (title == "Número móvil*")
            ? [
                WhitelistingTextInputFormatter(new RegExp("[0-9]")),
              ]
            : null,
        obscureText: (title == "Contraseña" || title == "Confirmar contraseña"),
        onEditingComplete: _node.nextFocus,
        textInputAction: (title == "Confirmar contraseña")
            ? TextInputAction.done
            : TextInputAction.next,
        textAlign: TextAlign.center,
        autovalidate: getValidator(title),
        keyboardType: _keyboardType(),
        validator: _validator,
        onChanged: (value) {
          setState(() {
            // (title == "nombre de pila" || title == "apellido")
            //     ? value = StringUtils.capitalize(value)
            //     : input = value;
            input = value;
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
        'username': fullName,
        'password': password,
        'email': email,
        'firstName': fullName.split("\\s+").first,
        'lastName': fullName.split("\\s+").last, // fullname.split("\\s+")[1]
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
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 55,
                  ),
                  Center(
                    child: Text(
                      "Regístrate en Cibic",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "y sé un ciudadano o ciudadana inteligente.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  textFieldInput(
                    title: "Numbre y Apellido*",
                    input: fullName,
                  ),
                  // textFieldInput(
                  //   title: "nombre de usuario*",
                  //   input: username,
                  // ),
                  textFieldInput(
                    title: "Correo electroníco*",
                    input: email,
                  ),
                  // textFieldInput(
                  //   title: "apellido",
                  //   input: surname,
                  // ),

                  textFieldInput(
                    title: "Número móvil*",
                    input: telephone,
                  ),
                  textFieldInput(
                    title: "Contraseña",
                    input: telephone,
                  ),

                  // SizedBox(height: 1),

                  // PASSWORD RULES
                  Center(
                    child: Text(
                      'Mínimo 8 caractéres, un número, un caracter especial y una mayúscula',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  textFieldInput(
                    title: "Confirmar contraseña",
                    input: passwordConfirm,
                  ),
                  // SizedBox(height: 2),

                  createPrivacyCheck(),
                  // createSubmitButton("siguiente"),

                  // submit
                  submitChecker()
                      ? GestureDetector(
                          onTap: () {
                            // print(
                            //     "$email, $password, $passwordConfirm, $fullName, $telephone");

                            if (_formKey.currentState.validate() && privacy) {
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
                  SizedBox(height: 5),

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
    );
  }
}
