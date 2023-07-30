import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'empty_discover.dart';

abstract class _SVG extends StatelessWidget {
  const _SVG({super.key, this.width, this.height});

  final double? width;
  final double? height;
}

extension ColorExtension on Color {
  String toHex() {
    return '#${value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}
