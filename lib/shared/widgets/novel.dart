import 'package:flutter/material.dart';

import '../theme/styles.dart';
import 'clickable_element.dart';

class Novel extends StatelessWidget {
  final String title;
  final String cover;
  final int? unread;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  const Novel({
    super.key,
    required this.title,
    required this.cover,
    this.unread,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ClickableElement(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: colorScheme.surfaceVariant,
          image: DecorationImage(
            image: NetworkImage(cover),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (unread != null && unread! > 0) UnreadBadge(unread!),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      shadows: textShadow,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UnreadBadge extends StatelessWidget {
  const UnreadBadge(this.unread, {super.key});

  final int unread;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: colorScheme.primary,
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '$unread',
              style: textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
