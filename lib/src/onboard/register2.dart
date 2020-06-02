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
  List<String> titles;
  List<bool> shouldValidate;
  List<bool> isValid;
  List<TextInputType> keyboards;
  bool privacy;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final storage = FlutterSecureStorage();
  bool isSubmitable;

  @override
  initState() {
    super.initState();
    titles = [
      "correo electrónico",
      "nombre de pila",
      "apellido",
      "número móvil",
      "contraseña",
      "confirmar contraseña"
    ];
    this.isValid = [
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    this.shouldValidate = [
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    this.keyboards = [
      TextInputType.emailAddress,
      TextInputType.text,
      TextInputType.text,
      TextInputType.number,
      TextInputType.text,
      TextInputType.text,
    ];
    this.isSubmitable = false;
    this.privacy = false;
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  bool computeSubmitable() {
    if (this.privacy == false) {
      return false;
    }
    for (int i = 0; i < this.isValid.length; i++) {
      if (this.isValid[i] == false) {
        return false;
      }
    }
    return true;
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
                this.isSubmitable = computeSubmitable();
              });
            },
          ),
          Text.rich(
            TextSpan(
              text: 'Acepto las ',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: "políticas de privacidad.",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateSubmitable(int index) {
    this.isValid[index] = true;
    this.isSubmitable = computeSubmitable();
  }

  Container textFieldInput({int index, TextEditingController controller}) {
    String _validator(String value) {
      if (index == 0) {
        // EMAIL
        String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
            "\\@" +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
            "(" +
            "\\." +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
            ")+";
        if (value.isEmpty) {
          return 'Introduce un correo electrónico válido';
        } else if (RegExp(p).hasMatch(value)) {
          updateSubmitable(index);
          return null;
        } else {
          return 'Introduce un correo electrónico válido';
        }
      } else if (index == 1) {
        // FIRSTNAME
        String p = "[a-zA-Z]{1,16}";
        RegExp regExp = RegExp(p);
        if (value.trim().isEmpty) {
          return "Introduce un nombre válido";
        } else if (regExp.hasMatch(value)) {
          updateSubmitable(index);
          return null;
        } else {
          return "Introduce un nombre válido";
        }
      } else if (index == 2) {
        // LASTNAME
        String p = "[a-zA-Z]{1,16}";
        RegExp regExp = RegExp(p);
        if (value.trim().isEmpty) {
          return "Introduce un apellido válido";
        } else if (regExp.hasMatch(value)) {
          updateSubmitable(index);
          return null;
        } else {
          return "Introduce un apellido válido";
        }
      } else if (index == 3) {
        // PHONE NUMBER
        String p = "[0-9]{9}";
        RegExp regExp = RegExp(p);
        if (value.trim().isEmpty) {
          return "Introduce un número válido";
        } else if (regExp.hasMatch(value)) {
          updateSubmitable(index);
          return null;
        } else {
          return "Introduce un número válido";
        }
      }
      // password
      else if (index == 4) {
        String reg =
            r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
        RegExp regExp = RegExp(reg);
        if (value.trim().isEmpty) {
          return "Introduce una contraseña válida";
        } else if (regExp.hasMatch(value.trim())) {
          updateSubmitable(index);
          return null;
        } else {
          return "Introduce una contraseña válida";
        }
      } else if (index == 5) {
        if (_passwordController.text != _passwordConfirmController.text) {
          return ("Las contraseñas no coinciden");
        } else {
          updateSubmitable(index);
          return null;
        }
      } else {
        return null;
      }
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
        obscureText: (index == 4 || index == 5),
        onEditingComplete: () {
          if (index != 5) {
            _node.nextFocus();
          }
          shouldValidate[index] = true;
        },
        textInputAction:
            (index == 5) ? TextInputAction.done : TextInputAction.next,
        textAlign: TextAlign.center,
        controller: controller,
        autovalidate: shouldValidate[index],
        validator: _validator,
        keyboardType: this.keyboards[index],
        onChanged: (value) {},
        decoration: InputDecoration(
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.white,
          focusColor: COLOR_DEEP_BLUE,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: this.titles[index],
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
                            "Regístrate en Cibic",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "y sé un ciudadano o ciudadana inteligente",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        textFieldInput(
                          index: 0,
                          controller: _emailController,
                        ),
                        textFieldInput(
                          index: 1,
                          controller: _firstNameController,
                        ),
                        textFieldInput(
                          index: 2,
                          controller: _lastNameController,
                        ),
                        textFieldInput(
                          index: 3,
                          controller: _phoneController,
                        ),
                        textFieldInput(
                          index: 4,
                          controller: _passwordController,
                        ),
                        textFieldInput(
                          index: 5,
                          controller: _passwordConfirmController,
                        ),
                        SizedBox(height: 2),
                        // PASSWORD RULES
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            'Mínimo 8 caractéres, un número, un carácter especial y una mayúscula',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        createPrivacyCheck(),
                        // submit
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate() && privacy) {
                              if (this.isSubmitable && vm.isLoading == false) {
                                this.isSubmitable = false;
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
                                          builder: (context) =>
                                              Onboard(vm.store)));
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: (this.isSubmitable)
                                  ? COLOR_SOFT_BLUE
                                  : COLOR_SOFT_BLUE,
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
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          color: COLOR_DEEP_BLUE,
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
  _RegisterViewModel(this.store, this.onRegister, this.isLoading,
      this.isSuccess, this.isError);
}
