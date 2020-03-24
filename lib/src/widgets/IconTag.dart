import 'package:flutter/material.dart';

class IconTag extends StatelessWidget {
  final Icon icon;
  final String text;

  IconTag(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon,
        SizedBox(width: 5),
        Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff828282),
          ),
        )
      ],
    );
  }
}
