import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(message),
    action: SnackBarAction(
      onPressed: () {},
      label: "DISMISS",
    ),
  ));
}
