import 'package:basic_project_template/core/card/my_card.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Color? background;
  final Color? foreground;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;

  const SettingTile({
    super.key,
    required this.title,
    this.background,
    this.foreground,
    this.trailing,
    this.onTap,
    this.leading,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard.outline(
      onTap: onTap,
      color: background,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 12.0),
            ],
            Expanded(
              child: Text(
                title,
                style: context.titleSmall!.copyWith(color: foreground),
              ),
            ),
            if (trailing != null) trailing! else Icon(Icons.chevron_right, color: foreground ?? context.primary),
          ],
        ),
      ),
    );
  }
}
