import 'package:flutter/material.dart';

import '../../../constants.dart';

class Label extends StatelessWidget {
  final String type;

  Label(this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Container(
        width: 60,
        height: 15,
        margin: const EdgeInsets.fromLTRB(0, 15, 20, 0),
        child: Center(
          child: Text(
            labelTextPicker[this.type],
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: labelColorPicker[type], width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
