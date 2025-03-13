import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_flutter/main.dart';
import '../../providers/theme_provider.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      )
          : null,
      actions: [
        ...?actions,
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Scaffold.of(context).openEndDrawer(); // Opens the settings drawer
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
