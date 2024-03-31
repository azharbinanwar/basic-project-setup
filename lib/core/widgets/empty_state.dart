import 'package:flutter/material.dart';
import 'package:basic_project_template/core/extensions/build_context_extension.dart';
import 'package:basic_project_template/core/extensions/widget_extension.dart';

class EmptyState extends StatelessWidget {
  final Widget _child;

  EmptyState({
    super.key,
    final Widget? title,
    final Widget? subtitle,
    final Widget? icon,
    final Widget? child,
    final EdgeInsets? padding,
  }) : _child = _EmptyState(
          padding: padding,
          title: title ?? const SizedBox(),
          subtitle: subtitle ?? const SizedBox(),
          icon: icon ?? const SizedBox(),
          child: child ?? const SizedBox(),
        );

  EmptyState.fail({
    super.key,
    final Widget? title,
    final Widget? subtitle,
    final Widget? icon,
    final Widget? child,
    final Color? onSurface,
    final EdgeInsets? padding,
  }) : _child = _EmptyState(
          padding: padding,
          title: title ?? const SizedBox(),
          subtitle: subtitle ?? const SizedBox(),
          icon: icon ?? const SizedBox(),
          isErrorState: true,
          child: child ?? const SizedBox(),
        );

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}

class _EmptyState extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget icon;
  final Widget child;
  final bool isErrorState;
  final EdgeInsets padding;

  const _EmptyState({
    final Widget? title,
    final Widget? subtitle,
    final Widget? icon,
    final Widget? child,
    final EdgeInsets? padding,
    this.isErrorState = false,
  })  : title = title ?? const SizedBox(),
        subtitle = subtitle ?? const SizedBox(),
        icon = icon ?? const SizedBox(),
        child = child ?? const SizedBox(),
        padding = padding ?? EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Theme(
            data: context.theme.copyWith(iconTheme: context.iconTheme.copyWith(size: 64.0, color: isErrorState ? context.error : null)),
            child: icon,
          ),
          DefaultTextStyle(style: context.titleLarge, textAlign: TextAlign.center, child: title),
          DefaultTextStyle(style: context.titleMedium, textAlign: TextAlign.center, child: subtitle),
          child,
        ],
      ).childrenPadding(const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0)),
    ).padding(padding);
  }
}
