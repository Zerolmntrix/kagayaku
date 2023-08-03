import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Toolbar {
  const Toolbar();

  final String title = '';

  AppBar android();

  CupertinoNavigationBar ios();
}
