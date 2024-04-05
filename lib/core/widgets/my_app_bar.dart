import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget _child;

  MyAppbar({
    super.key,
    final Widget? leading,
    final bool automaticallyImplyLeading = true,
    final Widget? title,
    final List<Widget>? actions,
    final Widget? flexibleSpace,
    final PreferredSizeWidget? bottom,
    final double? elevation,
    final double? scrolledUnderElevation,
    final Color? shadowColor,
    final Color? surfaceTintColor,
    final ShapeBorder? shape,
    final Color? backgroundColor,
    final Color? foregroundColor,
    final IconThemeData? iconTheme,
    final IconThemeData? actionsIconTheme,
    final bool? centerTitle,
    final double? titleSpacing,
    final double? toolbarHeight,
    final double? leadingWidth,
    final TextStyle? toolbarTextStyle,
    final TextStyle? titleTextStyle,
    final SystemUiOverlayStyle? systemOverlayStyle,
    final Clip? clipBehavior,
  }) : _child = _DefaultAppbar(
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title,
          actions: actions,
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          elevation: elevation,
          scrolledUnderElevation: scrolledUnderElevation,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          shape: shape,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          iconTheme: iconTheme,
          actionsIconTheme: actionsIconTheme,
          centerTitle: centerTitle,
          titleSpacing: titleSpacing,
          toolbarHeight: toolbarHeight,
          leadingWidth: leadingWidth,
          toolbarTextStyle: toolbarTextStyle,
          titleTextStyle: titleTextStyle,
          systemOverlayStyle: systemOverlayStyle,
          clipBehavior: clipBehavior,
        );

  @override
  Widget build(BuildContext context) {
    return _child;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DefaultAppbar extends StatelessWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final double? scrolledUnderElevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool? centerTitle;
  final double? titleSpacing;
  final double? toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Clip? clipBehavior;

  const _DefaultAppbar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ??
          AutoLeadingButton(
            builder: (context, LeadingType leadingType, _) {
              return IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  /// we can override this function as per our requirements
                  if (leadingType == LeadingType.back) {
                    context.maybePop();
                  }
                },
              );
            },
          ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      shape: shape,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: systemOverlayStyle,
      clipBehavior: clipBehavior,
    );
  }
}

// todo: update it before using
class _AppbarWithSearch extends StatelessWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final double? scrolledUnderElevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool? centerTitle;
  final double? titleSpacing;
  final double? toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Clip? clipBehavior;

  const _AppbarWithSearch({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.centerTitle,
    this.titleSpacing,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.clipBehavior,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ??
          AutoLeadingButton(
            builder: (context, LeadingType leadingType, _) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  /// we can override this function as per our requirements
                  if (leadingType == LeadingType.back) {
                    context.maybePop();
                  }
                },
              );
            },
          ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      shape: shape,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: systemOverlayStyle,
      clipBehavior: clipBehavior,
    );
  }
}
