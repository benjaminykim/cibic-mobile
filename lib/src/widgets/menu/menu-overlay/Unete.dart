import 'package:cibic_mobile/src/resources/api_provider.dart';
import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Unete extends StatefulWidget {
  @override
  _UneteState createState() => _UneteState();
}

class _UneteState extends State<Unete> {
  final inputCommentController = TextEditingController();

  final TextStyle style = TextStyle(
    color: Colors.black,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  final TextStyle contentStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w200,
  );

  final EdgeInsets aboutPadding = EdgeInsets.fromLTRB(30, 10, 30, 10);

  _launchURL() async {
    const url = 'https://www.github.com/cibic-io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchEmail() async {
    const url = 'mailto:contacto@cibic.app?subject=Contacto&body=Hola!';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
    inputCommentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: cibicTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("ÚNETE",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              )),
          centerTitle: true,
          titleSpacing: 0.0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Container(
          color: APP_BACKGROUND,
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: aboutPadding,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Déjanos tu comentario",
                      style: style,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: TextField(
                        controller: inputCommentController,
                        maxLines: 4,
                        style: TextStyle(
                            fontWeight: FontWeight.w200, color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.grey,
                          hintText: "comenta...",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w200, color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => submitUneteComment(
                              "fake jwt", inputCommentController.text),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: aboutPadding,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Únete!",
                      style: style,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _launchEmail();
                      },
                      child: Text(
                        "contacto@cibic.app",
                        style: contentStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: aboutPadding,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Proyecto Abierto",
                      style: style,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: _launchURL,
                      child: Text(
                        'Github',
                        style: contentStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
