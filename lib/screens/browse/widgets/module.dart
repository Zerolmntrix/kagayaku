import 'package:flutter/material.dart';
import 'package:kagayaku_modules/kagayaku_modules.dart';

import '../../../data/models/module.dart';
import '../../../shared/constants/endpoints.dart';

class Module extends StatelessWidget {
  final Widget trailing;
  final ModuleModel module;
  final bool loading;

  const Module({
    super.key,
    required this.module,
    required this.trailing,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final modulePath = module.id.split('.')[1];
    final icon =
        '${Endpoints.modulesDir}/${module.language}/$modulePath/${module.icon}';
    final iconSize = loading ? 40.0 : 60.0;

    return ListTile(
      leading: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(icon),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          if (loading) ...[
            Transform.scale(
              scale: 1.7,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 50),
          ]
        ],
      ),
      title: Text(module.name),
      subtitle: Text('${Languages.get(module.language)} ${module.version}'),
      trailing: trailing,
    );
  }
}
