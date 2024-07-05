import 'package:flutter/material.dart';

ShowsnackBar(context, String massage) async {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(massage),
    duration: Duration(seconds: 4),
    action: SnackBarAction(label: "Cansle", onPressed: () {}),
  ));
}
