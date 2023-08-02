import 'dart:async';

import 'package:flutter/material.dart';

import '../../../shared/theme/styles.dart';
import '../../../shared/widgets/novel.dart';

class Spotlight extends StatefulWidget {
  const Spotlight({super.key, this.novels = const []});

  final List<NovelPropType> novels;

  @override
  State<Spotlight> createState() => _SpotlightState();
}

class _SpotlightState extends State<Spotlight> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    Timer.periodic(const Duration(seconds: 4), (_) => _spotlightAnimation());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final novels = widget.novels;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 240,
      child: PageView.builder(
        itemCount: novels.length,
        controller: controller,
        itemBuilder: (_, index) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) => child!,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(novels[index]['cover']),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        novels[index]['title'],
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _spotlightAnimation() {
    final int nextPage = controller.page!.round() + 1;

    if (nextPage == widget.novels.length) {
      _goToSpotlight(0);
      return;
    }

    _goToSpotlight(nextPage);
  }

  _goToSpotlight(int index) {
    controller.animateToPage(
      index,
      duration: animationDuration,
      curve: Curves.easeIn,
    );
  }
}
