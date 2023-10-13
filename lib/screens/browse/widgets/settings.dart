import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kagayaku_modules/kagayaku_modules.dart';
import 'package:path/path.dart' show join;

import '../../../data/models/source.dart';
import '../../../shared/theme/styles.dart';
import '../../../utils/snackbar.dart';

class ModuleSettings extends ConsumerStatefulWidget {
  const ModuleSettings({
    super.key,
    required this.source,
    required this.uninstall,
  });

  final Source source;
  final Function(String moduleId) uninstall;

  @override
  ConsumerState<ModuleSettings> createState() => _ModuleSettingsState();
}

class _ModuleSettingsState extends ConsumerState<ModuleSettings> {
  double? buttonWidth;
  double buttonsWidth = 0;
  bool singleButton = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    divider() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: 3,
          height: 40,
          color: colorScheme.outline,
        ),
      );
    }

    info(String title, String text) {
      return Expanded(
        child: Column(
          children: [
            Text(title, style: textTheme.labelSmall),
            Text(text, style: textTheme.titleMedium),
          ],
        ),
      );
    }

    final moduleIcon = File(join(widget.source.path, widget.source.icon));

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.background.withOpacity(0.8),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.file(
                  moduleIcon,
                  height: 130.0,
                  width: 130.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                widget.source.name,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.source.moduleId,
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  info('Version', widget.source.version),
                  divider(),
                  info('Developer', widget.source.developer),
                  divider(),
                  info('Language', Languages.get(widget.source.language)),
                ],
              ),
              const SizedBox(height: 32.0),
              AnimatedSwitcher(
                duration: animationDuration,
                child: singleButton
                    ? AnimatedContainer(
                        duration: animationDuration,
                        width: buttonWidth ?? MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: buttonWidth == null ? onUninstall : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: Text(
                            'Uninstall',
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      )
                    : AnimatedContainer(
                        duration: animationDuration,
                        width: buttonsWidth,
                        child: Column(
                          children: [
                            Text(
                              'Do you want to uninstall?',
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.labelLarge,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Button(
                                    'Cancel',
                                    onPressed: cancelUninstall,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Button(
                                    'Yes',
                                    onPressed: () {
                                      widget.uninstall(widget.source.moduleId);
                                      context.pop();
                                      showSnackBar(
                                        context,
                                        'Uninstalled: ${widget.source.name}',
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onUninstall() async {
    setState(() => buttonWidth = 0.0);

    await Future.delayed(animationDuration);

    setState(() => singleButton = false);

    await Future.delayed(animationDuration);

    setState(() => buttonsWidth = MediaQuery.of(context).size.width);
  }

  cancelUninstall() async {
    setState(() => buttonsWidth = 0);

    await Future.delayed(animationDuration);

    setState(() => singleButton = true);

    await Future.delayed(animationDuration);

    setState(() => buttonWidth = null);
  }
}

class Button extends StatelessWidget {
  const Button(this.text, {super.key, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: textTheme.titleMedium?.copyWith(
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
