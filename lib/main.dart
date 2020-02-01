import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff335c9d),
            leading: Icon(Icons.menu),
            bottom: TabBar(
              indicator: BoxDecoration(color: Color(0xff7898ca)),
              tabs: [
                Tab(icon: Icon(Icons.public)),
                Tab(icon: Icon(Icons.people_outline)),
                Tab(icon: Icon(Icons.person_outline)),
                Tab(icon: Icon(Icons.poll)),
              ],
            ),
            title: SizedBox(
              height: 40,
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  fillColor: Color(0xffFFFFFF),
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                  border: new OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20)),
                  ),
                  filled: true,
                  hintText: 'buscar...',
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.public),
              Icon(Icons.people_outline),
              Icon(Icons.person_outline),
              Icon(Icons.poll),
            ],
          ),
        ),
      ),
    );
  }
}
