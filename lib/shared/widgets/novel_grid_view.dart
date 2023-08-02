import 'package:flutter/material.dart';

import '../../data/source_data.dart';
import 'novel.dart';

class NovelGridView extends StatelessWidget {
  const NovelGridView({super.key, required this.novels, required this.builder});

  final List<NovelModel> novels;
  final Novel Function(NovelModel novel) builder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: novels.length,
      itemBuilder: (context, index) {
        return builder(novels[index]);
      },
    );
  }
}
