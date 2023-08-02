import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Toolbar {
  const Toolbar();

  final title = '';

  AppBar android();

  CupertinoNavigationBar ios();
}
