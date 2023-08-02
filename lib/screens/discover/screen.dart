import 'package:flutter/material.dart';

import '../../shared/svgs/svgs.dart';
import 'widgets/toolbar.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  final isEmpty = true;

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return const Scaffold(
        appBar: DiscoverToolbar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmptyDiscover(height: 250),
              Text('You don\'t have any sources installed yet.'),
            ],
          ),
        ),
      );
    }

    return const Scaffold(
      appBar: DiscoverToolbar(),
      body: Column(
        children: [],
      ),
    );
  }
}
