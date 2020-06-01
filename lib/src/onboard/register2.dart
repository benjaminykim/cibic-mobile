import 'package:cibic_mobile/src/onboard/onboard.dart';
import 'package:cibic_mobile/src/redux/AppState.dart';
import 'package:cibic_mobile/src/redux/actions/actions_user.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';

class Register extends StatefulWidget {
  final storage;

  Register(this.storage);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FocusScopeNode _node = FocusScopeNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, firstName, lastName, sex, _value, telephone, password;
  bool emailVal, firstNameVal, lastNameVal, telephoneVal, passwordVal;
  bool privacy;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();
  bool isClickable;

  @override
  initState() {
    super.initState();
    email = "";
    firstName = "";
    lastName = "";
    sex = "";
    telephone = "";
    password = "";
    emailVal = false;
    firstNameVal = false;
    lastNameVal = false;
    telephoneVal = false;
    passwordVal = false;
    privacy = false;
    this.isClickable = true;
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

  Container textFieldInput(
      {String title, String input, TextEditingController controller}) {
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
      // For lastName
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

    void updateValidator(String title) {
      setState(() {
        if (title == "correo electrónico*") {
          emailVal = true;
        } else if (title == "apellido") {
          firstNameVal = true;
        } else if (title == "nombre de pila") {
          lastNameVal = true;
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
      } else if (title == "apellido") {
        return firstNameVal;
      } else if (title == "nombre de pila") {
        return lastNameVal;
      } else if (title == "número de teléfono") {
        return telephoneVal;
      } else if (title == "contraseña") {
        return passwordVal;
      }
      return false;
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
        controller: controller,
        autovalidate: getValidator(title),
        validator: _validator,
        onChanged: (value) {
          (title == "nombre de pila" || title == "apellido")
              ? value = value.toUpperCase()
              : value = value;
          setState(() {
            input = value.trim();
          });
          updateValidator(title);
        },
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
    return StoreConnector<AppState, _RegisterViewModel>(
      converter: (Store<AppState> store) {
        Function onRegister = (String email, String password, String firstName,
            String lastName, String telephone, BuildContext context) {
          store.dispatch(PostRegisterAttempt(
              email, password, firstName, lastName, telephone, context));
        };
        return _RegisterViewModel(
          store,
          onRegister,
          store.state.loginState['isSuccess'],
          store.state.loginState['isLoading'],
          store.state.loginState['isError'],
          );
      },
      builder: (BuildContext context, _RegisterViewModel vm) {
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
                          controller: _emailController,
                        ),
                        textFieldInput(
                          title: "nombre de pila",
                          input: firstName,
                          controller: _firstNameController,
                        ),
                        textFieldInput(
                          title: "apellido",
                          input: lastName,
                          controller: _lastNameController,
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 15),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          decoration: REGISTER_INPUT_DEC,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isDense: true,
                              isExpanded: true,
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
                          controller: _phoneController,
                        ),
                        textFieldInput(
                          title: "contraseña",
                          input: password,
                          controller: _passwordController,
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
                        // submit
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate() &&
                                sex != '' &&
                                privacy) {
                              if (this.isClickable  &&
                              vm.isLoading == false ) {
                                this.isClickable = false;
                              await vm.onRegister(
                                  _emailController.text,
                                  _passwordController.text,
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _phoneController.text,
                                  context);
                              if (vm.isSuccess) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Onboard(vm.store)));
                              }
                              }
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
      },
    );
  }
}

class _RegisterViewModel {
  Store store;
  Function onRegister;
  bool isLoading;
  bool isSuccess;
  bool isError;
  _RegisterViewModel(this.store, this.onRegister, this.isLoading, this.isSuccess, this.isError);
}
