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

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
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
      body: Container(
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
                        // validator: ,
                        // controller: ctlr,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: str + "*",
                          hintStyle: REGISTER_INPUT_TXT,
                        ),
                        // autofocus: true,
                        // enabled: true,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          // setState(() {
                          //   email = value;
                          //   this.isSubmitable = computeSubmitable();
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
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    // move to the next field
                    onEditingComplete: _node.nextFocus,
                  ),
                  // password
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    // move to the next field
                    onEditingComplete: _node.nextFocus,
                  ),

                  Container(
                    height: 40,
                    decoration: REGISTER_INPUT_DEC,
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(35, 0, 35, 7),
                    child: Center(
                      child: TextFormField(
                        // validator: () {},
                        // controller: ctlr,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: str + "*",
                          hintStyle: REGISTER_INPUT_TXT,
                        ),
                        autofocus: true,
                        enabled: true,

                        // keyboardType: TextInputType.text,
                        onChanged: (value) {
                          // setState(() {
                          //   sex = value;
                          //   this.isSubmitable = computeSubmitable();
                          // });
                        },
                      ),
                    ),
                  ),
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
