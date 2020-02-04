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
          style: Theme.of(context).textTheme.body2,
        )
      ],
    );
  }
}
