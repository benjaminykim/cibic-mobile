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
  String username, email, firstname, surname, sex, telephone, password;

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
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  Container textFieldInput({String title, String value}) {
    // for validation
    String _validator(String value) {
      // email validation
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
      else if (title == "numerii de telefono") {
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
      else if (title == "contrasena") {
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
        // autovalidate: true,
        textAlign: TextAlign.center,
        // autovalidate: true,
        // validator: _validator,

        onChanged: (value) {},
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
                    ),
                    textFieldInput(
                      title: "nombre de usuario*",
                    ),
                    textFieldInput(
                      title: "nombre de pila",
                    ),
                    textFieldInput(
                      title: "apellido",
                    ),
                    textFieldInput(
                      title: "sexo",
                    ),
                    textFieldInput(
                      title: "número de teléfono",
                    ),
                    textFieldInput(
                      title: "contraseña",
                    ),

                    //TODO This is where all the changes ends

                    Container(
                        height: 40,
                        decoration: REGISTER_INPUT_DEC,
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(35, 0, 35, 7),
                        child: Center(
                            child: TextFormField(
                          onEditingComplete: _node.nextFocus,
                          textInputAction: TextInputAction.next,

                          // focusNode: myFocusNode,
                          validator: (value) {
                            if (value.length < 10) {
                              return "Username is empty";
                            } else {
                              return null;
                            }
                          },
                          // controller: ctlr,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "*",
                            hintStyle: REGISTER_INPUT_TXT,
                          ),
                          // autofocus: true,
                          // enabled: true,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            // setState(() {
                            //   sex = value;
                            //   _formKey.currentState.validate();
                            //   print("OMG");
                            //   //   this.isSubmitable = computeSubmitable();
                            // });
                          },
                        ))),
                    // email
                    SizedBox(
                      height: 500,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'john@doe.com',
                      ),
                      validator: (value) {
                        if (value.length < 10) {
                          return "Username is empty";
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      // move to the next field
                      onEditingComplete: _node.nextFocus,
                    ),
                    // password
                    TextFormField(
                      validator: (value) {
                        // setState(() {
                        //   if (value.isEmpty) {
                        //     return "Password cant be empty";
                        //   } else
                        //     return null;
                        // });
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      // move to the next field
                      onEditingComplete: _node.nextFocus,
                    ),

                    // Container(
                    //     height: 40,
                    //     decoration: REGISTER_INPUT_DEC,
                    //     alignment: Alignment.center,
                    //     margin: EdgeInsets.fromLTRB(35, 0, 35, 7),
                    //     child: Center(
                    //         child: TextFormField(
                    //       onEditingComplete: _node.nextFocus,
                    //       // textInputAction: TextInputAction.next,

                    //       // focusNode: myFocusNode,
                    //       validator: (value) {
                    //         if (value.length < 10) {
                    //           return "Username is empty";
                    //         } else {
                    //           return null;
                    //         }
                    //       },
                    //       // controller: ctlr,
                    //       textAlign: TextAlign.center,
                    //       decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         hintText: "this is an amazoing test *",
                    //         hintStyle: REGISTER_INPUT_TXT,
                    //       ),
                    //       // autofocus: true,
                    //       // enabled: true,
                    //       textAlignVertical: TextAlignVertical.center,
                    //       keyboardType: TextInputType.emailAddress,
                    //       onSaved: (value) {
                    //         setState(() {
                    //           sex = value;
                    //           print("Saving ");
                    //           //   this.isSubmitable = computeSubmitable();
                    //         });
                    //       },
                    //     ))),
                    // submit
                    RaisedButton(
                      child: Text('Sign In'),
                      onPressed: () {/* submit code here */},
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

// class TextFieldInput extends StatelessWidget {
//   final String title;
//   const TextFieldInput({
//     @required this.title,
//     Key key,
//   }) : super(key: key);

//   String _validator(String value) {
//     if (this.title == "correo electrónico*") {
//       if (value.isEmpty) {
//         // The form is empty
//         return "Introducir la dirección de correo electrónico";
//       }

//       // This is just a regular expression for email addresses
//       String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
//           "\\@" +
//           "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
//           "(" +
//           "\\." +
//           "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
//           ")+";

//       RegExp regExp = new RegExp(p);
//       if (regExp.hasMatch(value)) {
//         // So, the email is valid
//         return null;
//       }

//       // The pattern of the email didn't match the regex above.
//       return 'Email is not valid';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       margin: EdgeInsets.symmetric(
//         vertical: 2,
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: 30,
//         vertical: 0,
//       ),
//       child: TextFormField(
//         // autovalidate: true,
//         textAlign: TextAlign.center,
//         // autovalidate: true,
//         validator: _validator,

//         onChanged: (value) {},
//         // onSaved: (val) => username = val,
//         decoration: InputDecoration(
//           alignLabelWithHint: true,
//           filled: true,
//           fillColor: Colors.white,
//           focusColor: COLOR_DEEP_BLUE,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           hintText: title,
//           hintStyle: TextStyle(
//             fontSize: 15,
//             color: Colors.grey,
//           ),
//           contentPadding:
//               const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.white),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),

//         style: TextStyle(
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }

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
