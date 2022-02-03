import 'package:flutter/material.dart';
class AddButton extends StatelessWidget {
  final function;

  AddButton({this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FloatingActionButton(
        onPressed: function,
        backgroundColor: Colors.white,
        elevation: 10,
        child: Icon(
          Icons.add,
          color: Colors.lightBlueAccent,
          size: 40,
        ),
      ),
    );
  }
}
