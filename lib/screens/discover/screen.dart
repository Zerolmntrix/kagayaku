import 'package:flutter/material.dart';

import '../../shared/svgs/svgs.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: const Center(
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
}
