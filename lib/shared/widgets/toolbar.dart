import 'package:flutter/material.dart';

mixin Toolbar implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
