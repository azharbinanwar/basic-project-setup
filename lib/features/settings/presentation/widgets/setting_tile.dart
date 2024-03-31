import 'package:flutter/material.dart';
import 'package:basic_project_template/core/extensions/build_context_extension.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final Color? color;
  final Widget? trailing;
  final Function()? onTap;
  final Widget? leading;

  const SettingTile({
    super.key,
    required this.title,
    this.color,
    this.trailing,
    this.onTap,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onTap: onTap,
      leading: leading,
      tileColor: Theme.of(context).cardColor,
      title: Text(title, style: context.bodyMedium.copyWith(color: color)),
      trailing: trailing ?? Icon(Icons.chevron_right, color: context.primary),
    );
  }
}
