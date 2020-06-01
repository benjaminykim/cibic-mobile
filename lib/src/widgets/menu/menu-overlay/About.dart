import 'package:cibic_mobile/src/resources/constants.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
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

  _launchURL() async {
    const url = 'https://www.cibic.app';
    print(url);
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  final EdgeInsets aboutPadding = EdgeInsets.fromLTRB(30, 10, 30, 10);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: cibicTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("ABOUT CIBIC",
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
                      "El Sitio Web",
                      style: style,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _launchURL();
                      },
                      child: Text(
                        "www.cibic.app",
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
                      "Acerca de CIBIC",
                      style: style,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "CIBIC es una plataforma de uso social y de uso cívico para poder organizarnos.",
                      style: contentStyle,
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
                      "Contacto",
                      style: style,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "contacto@cibic.app",
                      style: contentStyle,
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
