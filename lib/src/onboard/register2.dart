import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/onboard/onboard.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailPasswordSignInForm extends StatefulWidget {
  @override
  _EmailPasswordSignInFormState createState() =>
      _EmailPasswordSignInFormState();
}

class _EmailPasswordSignInFormState extends State<EmailPasswordSignInForm> {
  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username, email, firstname, surname, sex, _value, telephone, password;
  bool privacy;
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
    privacy = false;
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
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
    bool _validate = false;
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
        }

        return "Error";
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
        autovalidate: (input.isEmpty) ? false : true,
        validator: _validator,

        onChanged: (value) {
          (title == "nombre de pila" || title == "apellido")
              ? value = value.toUpperCase()
              : value = value;
          input = value.trim();
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
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
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
                    //TODO Everything is fine upwards

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
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate() &&
                            sex != '' &&
                            privacy) {
                        } else {}
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

class Register2 extends StatefulWidget {
  final storage;

  Register2(this.storage);
  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
