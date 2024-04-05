import 'package:basic_project_template/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

const double _defaultButtonHeight = 52.0;
const BorderRadius _borderRadius = BorderRadius.all(Radius.circular(40.0));

class AppButton extends StatelessWidget {
  final Widget _child;

  AppButton({
    super.key,
    final double? height,
    final double? width,
    final double? elevation,
    required final Widget child,
    final Color? background,
    final Color? foregroundColor,
    final VoidCallback? onPressed,
    final bool? isProcessing,
    final BoxConstraints? constraints,
    final BorderRadius? borderRadius,
  }) : _child = _ElevatedButton(
          height: height,
          width: width,
          elevation: elevation,
          background: background,
          foregroundColor: foregroundColor,
          onPressed: onPressed,
          isProcessing: isProcessing ?? false,
          constraints: constraints,
          borderRadius: borderRadius,
          child: child,
        );

  AppButton.text({
    super.key,
    final double? height,
    final double? width,
    final double? elevation,
    required final Widget child,
    final Color? background,
    final Color? foregroundColor,
    final Color? fore,
    final VoidCallback? onPressed,
    final BoxConstraints? constraints,
    final BorderRadius? borderRadius,
  }) : _child = _TextButton(
          height: height,
          width: width,
          elevation: elevation,
          foregroundColor: foregroundColor,
          onPressed: onPressed,
          constraints: constraints,
          borderRadius: borderRadius,
          child: child,
        );

  AppButton.outline({
    super.key,
    final double? height,
    final double? width,
    final double? elevation,
    required final Widget child,
    final Color? background,
    final Color? borderColor,
    final VoidCallback? onPressed,
    final bool? isProcessing,
    final EdgeInsets? padding,
    final BorderRadius? borderRadius,
  }) : _child = _OutlineButton(
          height: height,
          width: width,
          padding: padding,
          elevation: elevation,
          background: background,
          borderColor: borderColor,
          onPressed: onPressed,
          isProcessing: isProcessing ?? false,
          borderRadius: borderRadius,
          child: child,
        );

  AppButton.expandedText({
    super.key,
    final double? height,
    final double? width,
    final double? elevation,
    required final Widget child,
    final Color? background,
    final Color? borderColor,
    final VoidCallback? onPressed,
    final bool? isProcessing,
    final EdgeInsets? padding,
  }) : _child = _ExpandedTextButton(
          height: height,
          width: width,
          padding: padding,
          elevation: elevation,
          background: background,
          borderColor: borderColor,
          onPressed: onPressed,
          isProcessing: isProcessing ?? false,
          child: child,
        );

  AppButton.shrink({
    super.key,
    final double? height,
    final double? elevation,
    final double? width,
    required final Widget child,
    final Color? background,
    final VoidCallback? onPressed,
    final BorderRadius? borderRadius,
    final bool? isProcessing,
  }) : _child = _ShrinkElevatedButton(
          elevation: elevation,
          height: height,
          width: width,
          background: background,
          onPressed: onPressed,
          borderRadius: borderRadius,
          isProcessing: isProcessing ?? false,
          child: child,
        );

  AppButton.outlineShrink({
    super.key,
    final double? height,
    final double? elevation,
    final double? width,
    required final Widget child,
    final Color? background,
    final Color? borderColor,
    final VoidCallback? onPressed,
    final bool? isProcessing,
    final BorderRadius? borderRadius,
  }) : _child = _ShrinkOutlineButton(
          elevation: elevation,
          height: height,
          width: width,
          background: background,
          borderColor: borderColor,
          onPressed: onPressed,
          isProcessing: isProcessing ?? false,
          borderRadius: borderRadius,
          child: child,
        );

  @override
  Widget build(BuildContext context) => _child;
}

class _ElevatedButton extends StatelessWidget {
  final double height, width;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final Color? background;
  final Color? foregroundColor;
  final Widget child;
  final BoxConstraints? constraints;
  final BorderRadius borderRadius;

  const _ElevatedButton({
    final double? height,
    final double? width,
    this.elevation,
    this.onPressed,
    this.background,
    this.foregroundColor,
    this.constraints,
    final BorderRadius? borderRadius,
    this.isProcessing = false,
    required this.child,
  })  : width = width ?? double.infinity,
        height = height ?? _defaultButtonHeight,
        borderRadius = borderRadius ?? _borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all<Size>(Size(width, height)),
        elevation: MaterialStateProperty.all(elevation),
        backgroundColor: background == null ? null : MaterialStateProperty.all<Color>(background!),
        foregroundColor: foregroundColor == null ? null : MaterialStateProperty.all<Color>(foregroundColor!),
        minimumSize: MaterialStateProperty.all<Size>(Size(width, _defaultButtonHeight)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
      ),
      onPressed: () {
        if (isProcessing) return;
        if (onPressed != null) onPressed!();
      },
      child: isProcessing ? _CircularProgressIndicator(height: height * 0.7, color: Theme.of(context).colorScheme.onPrimary) : child,
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final double height, width;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final Color? background;
  final Color? borderColor;
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius borderRadius;

  const _OutlineButton({
    final double? height,
    final double? width,
    this.elevation,
    this.onPressed,
    this.background,
    this.borderColor,
    this.isProcessing = false,
    this.padding,
    final BorderRadius? borderRadius,
    required this.child,
  })  : height = height ?? _defaultButtonHeight,
        width = width ?? double.infinity,
        borderRadius = borderRadius ?? _borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all<Size>(Size(width, height)),
        minimumSize: MaterialStateProperty.all<Size>(Size(width, height)),
        side: MaterialStateProperty.all(BorderSide(color: borderColor ?? context.primary)),
        padding: padding == null ? null : MaterialStateProperty.all(padding),
        elevation: MaterialStateProperty.all(elevation),
        backgroundColor: background == null ? null : MaterialStateProperty.all<Color>(background!),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
      ),
      onPressed: onPressed,
      child: isProcessing ? _CircularProgressIndicator(height: height * 0.7, color: context.onPrimary) : child,
    );
  }
}

class _TextButton extends StatelessWidget {
  final double? height, width;
  final double? elevation;
  final VoidCallback? onPressed;
  final Color? foregroundColor;
  final Widget child;
  final BoxConstraints? constraints;
  final BorderRadius borderRadius;

  const _TextButton({
    this.height,
    this.width,
    this.elevation,
    this.onPressed,
    this.constraints,
    this.foregroundColor,
    required this.child,
    final BorderRadius? borderRadius,
  }) : borderRadius = borderRadius ?? _borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
        elevation: MaterialStateProperty.all(elevation),
        foregroundColor: MaterialStateProperty.all<Color>(foregroundColor ?? context.primary),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class _ExpandedTextButton extends StatelessWidget {
  final double height, width;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final Color? background;
  final Color? borderColor;
  final Widget child;
  final EdgeInsets? padding;

  const _ExpandedTextButton({
    final double? height,
    final double? width,
    this.elevation,
    this.onPressed,
    this.background,
    this.borderColor,
    this.isProcessing = false,
    this.padding,
    required this.child,
  })  : height = height ?? _defaultButtonHeight,
        width = width ?? double.infinity;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all<Size>(Size(width, height)),
        side: MaterialStateProperty.all(BorderSide(color: borderColor ?? context.primary)),
        padding: padding == null ? null : MaterialStateProperty.all(padding),
        elevation: MaterialStateProperty.all(elevation),
        backgroundColor: background == null ? null : MaterialStateProperty.all<Color>(background!),
      ),
      onPressed: onPressed,
      child: isProcessing ? _CircularProgressIndicator(height: height * 0.7, color: context.onPrimary) : child,
    );
  }
}

class _ShrinkElevatedButton extends StatelessWidget {
  final double height;
  final double? width;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final Color? background;
  final Widget child;
  final BorderRadius borderRadius;

  const _ShrinkElevatedButton({
    final double? height,
    this.elevation,
    this.width,
    this.onPressed,
    this.background,
    final BorderRadius? borderRadius,
    required this.isProcessing,
    required this.child,
  })  : height = height ?? _defaultButtonHeight,
        borderRadius = borderRadius ?? _borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
          elevation: MaterialStateProperty.all(elevation),
          backgroundColor: background == null ? null : MaterialStateProperty.all<Color>(background!),
        ),
        onPressed: onPressed,
        child: isProcessing ? _CircularProgressIndicator(height: height * 0.7) : child,
      ),
    );
  }
}

class _ShrinkOutlineButton extends StatelessWidget {
  final double height;
  final double? width;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final Color? background;
  final Color? borderColor;
  final Widget child;
  final BorderRadius borderRadius;

  const _ShrinkOutlineButton({
    final double? height,
    this.elevation,
    this.width,
    this.onPressed,
    this.background,
    this.isProcessing = false,
    this.borderColor,
    required this.child,
    final BorderRadius? borderRadius,
  })  : height = height ?? _defaultButtonHeight,
        borderRadius = borderRadius ?? _borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: null,
      height: height,
      child: OutlinedButton(
        style: ButtonStyle(
          side: borderColor == null ? null : MaterialStateProperty.all(BorderSide(color: borderColor!)),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
          backgroundColor: background == null ? null : MaterialStateProperty.all<Color>(background!),
        ),
        onPressed: onPressed,
        child: isProcessing ? _CircularProgressIndicator(height: height * 0.7, color: context.onPrimary) : child,
      ),
    );
  }
}

class _CircularProgressIndicator extends StatelessWidget {
  final double height;
  final Color? color;

  const _CircularProgressIndicator({required this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.7,
      width: height * 0.7,
      child: CircularProgressIndicator(strokeWidth: 2, color: color ?? context.onPrimary),
    );
  }
}
