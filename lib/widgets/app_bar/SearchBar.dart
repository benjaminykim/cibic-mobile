import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (SizedBox(
      height: 40,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(15, 0, 5, 0),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(20)),
          ),
          filled: true,
          hintText: 'buscar...',
          suffixIcon: Icon(Icons.search),
        ),
      ),
    ));
  }
}
