import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/source_data.dart';
import '../../../shared/constants/routes.dart';
import '../../../shared/svgs/svgs.dart';
import '../../../shared/theme/styles.dart';
import '../../../shared/widgets/clickable_element.dart';

class Spotlight extends StatefulWidget {
  const Spotlight({super.key, required this.novels});

  final List<NovelModel> novels;

  @override
  State<Spotlight> createState() => _SpotlightState();
}

class _SpotlightState extends State<Spotlight> {
  late PageController controller;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final novels = widget.novels;
    final limit = novels.length >= 5 ? 5 : novels.length;
    final colorScheme = Theme.of(context).colorScheme;
    const spotlightHeight = 240.0;

    if (novels.isEmpty) {
      return Container(
        height: spotlightHeight,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: colorScheme.onSurface.withOpacity(0.1),
        ),
        child: const Center(
          child: Logo(height: 120),
        ),
      );
    }

    startTimer();

    return SizedBox(
      height: spotlightHeight,
      child: PageView.builder(
        itemCount: limit,
        controller: controller,
        onPageChanged: (_) => startTimer(),
        itemBuilder: (_, index) {
          final novel = novels[index];
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) => child!,
            child: NovelBanner(novel: novel),
          );
        },
      ),
    );
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => _spotlightAnimation(),
    );
  }

  _spotlightAnimation() {
    final int nextPage = controller.page!.round() + 1;
    final limit = widget.novels.length >= 5 ? 5 : widget.novels.length;

    if (nextPage == limit) {
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

class NovelBanner extends StatelessWidget {
  const NovelBanner({super.key, required this.novel});

  final NovelModel novel;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          image: NetworkImage(novel.cover),
          fit: BoxFit.cover,
          opacity: 0.9,
        ),
      ),
      child: ClickableElement(
        onTap: () => context.push(AppRoutes.novel, extra: novel.url),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              image: NetworkImage(novel.cover),
              fit: BoxFit.fitHeight,
            ),
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
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                novel.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: textShadow,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
