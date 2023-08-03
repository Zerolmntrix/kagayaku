import 'package:flutter/material.dart';

showSnackBar(
  BuildContext context,
  String message, {
  VoidCallback? function,
  bool retry = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(message),
    action: SnackBarAction(
      onPressed: function ?? () {},
      label: retry ? "RETRY" : "DISMISS",
    ),
  ));
}
