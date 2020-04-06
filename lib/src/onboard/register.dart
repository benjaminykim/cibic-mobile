import 'dart:convert';
import 'dart:io';

import 'package:cibic_mobile/src/onboard/onboard.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  final storage;

  Register(this.storage);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isChecked = false;
  bool isSubmitable = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<String> inputLabels = [
    "correo electronico",
    "nombre de usario",
    "nombre de pila",
    "apellido",
    "sexo",
    "numero de telefono",
    "contrasena"
  ];
  List<TextEditingController> inputCtlrs;

  @override
  initState() {
    super.initState();
    this.inputCtlrs = [_emailController, _usernameController, _firstNameController, _lastNameController, _sexController, _phoneController, _passwordController];
  }

  Future<String> attemptSubmit() async {
    Map<String, dynamic> userProfile = {
      'username': '${_usernameController.text}',
      'password': '${_passwordController.text}',
      'email': '${_emailController.text}',
      'firstName': '${_firstNameController.text}',
      'lastName': '${_lastNameController.text}',
      'phone': _phoneController.text,
      'rut': "1234567900",
      'cabildos': [],
      'files': "none",
      'followers': [],
      'following': [],
      'activityFeed': []
    };
    Map map = {'user': userProfile};

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(API_BASE + ENDPOINT_USER));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    httpClient.close();

    if (response.statusCode == 201) {
      final responseBody = await response.transform(utf8.decoder).join();
      print(responseBody.toString());
      Map<String, dynamic> user = jsonDecode(responseBody);
      user['jwt'] = "fakejwtToken";
      print(userProfile);
      print(user);
      return user['jwt'];
    } else {
      setState(() {
        this.isSubmitable = false;
      });
      return null;
    }
  }

  bool computeSubmitable() {
    if ((_emailController.text != null) &&
        (_usernameController.text != null) &&
        (_firstNameController.text != null) &&
        (_lastNameController.text != null) &&
        (_sexController.text != null) &&
        (_phoneController.text != null) &&
        (_passwordController.text != null) &&
        (_emailController.text != "") &&
        (_usernameController.text != "") &&
        (_firstNameController.text != "") &&
        (_lastNameController.text != "") &&
        (_sexController.text != "") &&
        (_phoneController.text != "") &&
        (_passwordController.text != "") &&
        (this.isChecked)) {
      return true;
    }
    return false;
  }

  Container createInputView(int index) {
    String str = this.inputLabels[index];
    TextEditingController ctlr = this.inputCtlrs[index];
    TextField textField;

    // phone number input
    if (index == 5) {
      textField = TextField(
        controller: ctlr,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: str + "*",
          hintStyle: REGISTER_INPUT_TXT,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
      );
    } else {
      textField = TextField(
        controller: ctlr,
        textAlign: TextAlign.center,
        obscureText: (index == 6), // password label obscurity
        onChanged: (_) {
          setState(() {
            this.isSubmitable = computeSubmitable();
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: str + "*",
          hintStyle: REGISTER_INPUT_TXT,
        ),
      );
    }
    return Container(
      height: 40,
      decoration: REGISTER_INPUT_DEC,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(35, 0, 35, 7),
      child: Center(
        child: textField,
      ),
    );
  }

  Widget createPrivacyCheck() {
    return Container(
      margin: EdgeInsets.only(left: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                this.isChecked = value;
                this.isSubmitable = computeSubmitable();
              });
            },
          ),
          Text(
            "Acepto las politicas de privacidad.",
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

  Widget createSubmitButton(String str) {
    return GestureDetector(
      onTap: () {
        if (this.isSubmitable) {
          Future<String> stat = attemptSubmit();
          stat.then((jwt) {
            if (jwt != null) {
              print("User creation successful");
              widget.storage.write(key: "jwt", value: jwt);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Onboard(widget.storage, jwt)));
            } else {
              setState(() {
                this.isSubmitable = false;
              });
            }
          });
        }
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: (this.isSubmitable) ? COLOR_SOFT_BLUE : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(35, 10, 35, 7),
        child: Text(
          str,
          textAlign: TextAlign.center,
          style: REGISTER_TXT,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        color: COLOR_DEEP_BLUE,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: COLOR_SOFT_BLUE,
              height: 100,
              padding: EdgeInsets.only(top: 60),
              child: Text(
                "REGISTRARSE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 120,
              child: ListView(
                children: <Widget>[
                  // HEADER
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
                  createInputView(0),
                  createInputView(1),
                  createInputView(2),
                  createInputView(3),
                  createInputView(4),
                  createInputView(5),
                  createInputView(6),
                  SizedBox(height: 2),
                  // PASSWORD RULES
                  Center(
                    child: Text(
                      "Minimo 8 caracteres, un numero y una mayuscula",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  createPrivacyCheck(),
                  createSubmitButton("siguiente"),
                  // DIVIDER
                  Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Colors.white,
                    thickness: 1,
                  ),
                  // DYNAMIC SPACING
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
