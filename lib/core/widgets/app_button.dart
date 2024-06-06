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

  AppButton.verticalIcon({
    super.key,
    final double? height,
    final double? width,
    final double? elevation,
    final Color? background,
    final Color? foregroundColor,
    final VoidCallback? onPressed,
    final bool? isProcessing,
    final BoxConstraints? constraints,
    final BorderRadius? borderRadius,
    required final Widget icon,
    required final Widget child,
  }) : _child = _VerticalIconButton(
          height: height,
          width: width,
          elevation: elevation,
          background: background,
          foregroundColor: foregroundColor,
          onPressed: onPressed,
          isProcessing: isProcessing ?? false,
          constraints: constraints,
          borderRadius: borderRadius,
          icon: icon,
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
    final bool? isProcessing,
    final BoxConstraints? constraints,
    final BorderRadius? borderRadius,
  }) : _child = _TextButton(
          height: height,
          width: width,
          elevation: elevation,
          foregroundColor: foregroundColor,
          onPressed: onPressed,
          isProcessing: isProcessing ?? false,
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
    final Color? foregroundColor,
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
          foregroundColor: foregroundColor,
          borderColor: borderColor,
          onPressed: onPressed,
          isProcessing: isProcessing ?? false,
          borderRadius: borderRadius,
          child: child,
        );

  AppButton.icon({
    super.key,
    final double? height,
    final double? width,
    final double? elevation,
    required final Widget child,
    required final Widget icon,
    final Color? background,
    final VoidCallback? onPressed,
    final bool? isProcessing,
    final BorderRadius? borderRadius,
  }) : _child = _IconButton(
          height: height,
          width: width,
          elevation: elevation,
          background: background,
          onPressed: onPressed,
          isProcessing: isProcessing ?? false,
          borderRadius: borderRadius,
          icon: icon,
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
    final Color? foregroundColor,
    final VoidCallback? onPressed,
    final BorderRadius? borderRadius,
    final bool? isProcessing,
  }) : _child = _ShrinkElevatedButton(
          elevation: elevation,
          height: height,
          width: width,
          background: background,
          foregroundColor: foregroundColor,
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
        maximumSize: WidgetStateProperty.all<Size>(Size(width, height)),
        minimumSize: WidgetStateProperty.all<Size>(Size(width, height)),
        elevation: WidgetStateProperty.all(elevation),
        backgroundColor: WidgetStateProperty.all<Color>(background ?? context.primary),
        foregroundColor: foregroundColor == null ? null : WidgetStateProperty.all<Color>(foregroundColor!),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
      ),
      onPressed: onPressed == null
          ? null
          : () {
              if (isProcessing) return;
              onPressed?.call();
            },
      child:
          isProcessing ? _CircularProgressIndicator(height: height * 0.7, color: foregroundColor ?? Theme.of(context).colorScheme.onPrimary) : child,
    );
  }
}

class _VerticalIconButton extends StatelessWidget {
  final double height, width;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final Color? background;
  final Color? foregroundColor;
  final Widget child;
  final Widget icon;
  final BoxConstraints? constraints;
  final BorderRadius borderRadius;

  const _VerticalIconButton({
    final double? height,
    final double? width,
    this.elevation,
    this.onPressed,
    this.background,
    this.foregroundColor,
    required this.child,
    required this.icon,
    this.constraints,
    final BorderRadius? borderRadius,
    this.isProcessing = false,
  })  : width = width ?? double.infinity,
        height = height ?? _defaultButtonHeight,
        borderRadius = borderRadius ?? _borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProcessing) return;
        if (onPressed != null) onPressed!();
      },
      child: Center(
        child: isProcessing
            ? _CircularProgressIndicator(height: height * 0.7, color: Theme.of(context).colorScheme.onPrimary)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const SizedBox(height: 3.0),
                  child,
                ],
              ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final double height, width;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final Color? background;
  final Color? foregroundColor;
  final Widget child;
  final Widget icon;
  final BoxConstraints? constraints;
  final BorderRadius borderRadius;

  const _IconButton({
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
    required this.icon,
  })  : width = width ?? double.infinity,
        height = height ?? _defaultButtonHeight,
        borderRadius = borderRadius ?? _borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        maximumSize: WidgetStateProperty.all<Size>(Size(width, height)),
        elevation: WidgetStateProperty.all(elevation),
        backgroundColor: background == null ? null : WidgetStateProperty.all<Color>(background!),
        foregroundColor: foregroundColor == null ? null : WidgetStateProperty.all<Color>(foregroundColor!),
        minimumSize: WidgetStateProperty.all<Size>(Size(width, _defaultButtonHeight)),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
      ),
      onPressed: onPressed == null
          ? null
          : () {
              if (isProcessing) return;
              onPressed?.call();
            },
      child:
          isProcessing ? _CircularProgressIndicator(height: height * 0.7, color: foregroundColor ?? Theme.of(context).colorScheme.onPrimary) : child,
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final double height, width;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final Color? background;
  final Color? foregroundColor;
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
    this.foregroundColor,
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
        maximumSize: WidgetStateProperty.all<Size>(Size(width, height)),
        minimumSize: WidgetStateProperty.all<Size>(Size(width, height)),
        side: WidgetStateProperty.all(BorderSide(color: borderColor ?? foregroundColor ?? context.primary)),
        padding: padding == null ? null : WidgetStateProperty.all(padding),
        elevation: WidgetStateProperty.all(elevation),
        backgroundColor: background == null ? null : WidgetStateProperty.all<Color>(background!),
        foregroundColor: WidgetStateProperty.all<Color>(foregroundColor ?? context.primary),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
      ),
      onPressed: onPressed,
      child: isProcessing ? _CircularProgressIndicator(height: height * 0.7, color: foregroundColor ?? context.primary) : child,
    );
  }
}

class _TextButton extends StatelessWidget {
  final double? height, width;
  final double? elevation;
  final VoidCallback? onPressed;
  final bool isProcessing;
  final Color? foregroundColor;
  final Widget child;
  final BoxConstraints? constraints;
  final BorderRadius borderRadius;

  const _TextButton({
    final double? height,
    final double? width,
    this.elevation,
    this.onPressed,
    this.isProcessing = false,
    this.constraints,
    this.foregroundColor,
    required this.child,
    final BorderRadius? borderRadius,
  })  : height = height ?? _defaultButtonHeight,
        width = width ?? double.infinity,
        borderRadius = borderRadius ?? _borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
        elevation: WidgetStateProperty.all(elevation),
        foregroundColor: WidgetStateProperty.all<Color>(foregroundColor ?? context.primary),
        textStyle: WidgetStateProperty.all<TextStyle>(context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
      ),
      onPressed: onPressed,
      child: isProcessing ? _CircularProgressIndicator(height: height! * 0.7, color: context.primary) : child,
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
        maximumSize: WidgetStateProperty.all<Size>(Size(width, height)),
        side: WidgetStateProperty.all(BorderSide(color: borderColor ?? context.primary)),
        padding: padding == null ? null : WidgetStateProperty.all(padding),
        elevation: WidgetStateProperty.all(elevation),
        backgroundColor: background == null ? null : WidgetStateProperty.all<Color>(background!),
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
  final Color? foregroundColor;
  final Widget child;
  final BorderRadius borderRadius;

  const _ShrinkElevatedButton({
    final double? height,
    this.elevation,
    this.width,
    this.onPressed,
    this.background,
    this.foregroundColor,
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
            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
            elevation: WidgetStateProperty.all(elevation),
            backgroundColor: background == null ? null : WidgetStateProperty.all<Color>(background!),
            foregroundColor: foregroundColor == null ? null : WidgetStateProperty.all<Color>(foregroundColor!)),
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
          side: borderColor == null ? null : WidgetStateProperty.all(BorderSide(color: borderColor!)),
          elevation: WidgetStateProperty.all(elevation),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: borderRadius)),
          backgroundColor: background == null ? null : WidgetStateProperty.all<Color>(background!),
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
