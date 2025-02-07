import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';

enum _MyCardType { defaultCard, primary, outline }

class MyCard extends StatelessWidget {
  final Widget _child;

  MyCard({
    super.key,
    final num? height,
    final num? width,
    final BoxDecoration? decoration,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    final Function()? onTap,
    final Color? color,
    final BorderRadius? borderRadius,
    final Color? shadowColor,
    final Widget? child,
    final double? elevation,
  }) : _child = _MyDefaultCard(
          height: height,
          width: width,
          decoration: decoration,
          padding: padding,
          margin: margin,
          onTap: onTap,
          color: color,
          borderRadius: borderRadius,
          shadowColor: shadowColor,
          elevation: elevation,
          child: child,
        );

  MyCard.primary({
    super.key,
    final num? height,
    final num? width,
    final BoxDecoration? decoration,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    final Function()? onTap,
    final Color? color,
    final BorderRadius? borderRadius,
    final Color? shadowColor,
    final num elevation = 0.0,
    final Widget? child,
  }) : _child = _MyDefaultCard(
          height: height,
          width: width,
          decoration: decoration,
          padding: padding,
          margin: margin,
          onTap: onTap,
          color: color,
          borderRadius: borderRadius,
          shadowColor: shadowColor,
          elevation: elevation,
          type: _MyCardType.primary,
          child: child,
        );

  MyCard.outline({
    super.key,
    final num? height,
    final num? width,
    final BoxDecoration? decoration,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    final Function()? onTap,
    final Color? color,
    final BorderRadius? borderRadius,
    final Color? shadowColor,
    final num elevation = 0.0,
    final Widget? child,
    final Border? border,
  }) : _child = _MyDefaultCard(
          height: height,
          width: width,
          decoration: decoration,
          padding: padding,
          margin: margin,
          onTap: onTap,
          color: color,
          borderRadius: borderRadius,
          shadowColor: shadowColor,
          elevation: elevation,
          type: _MyCardType.outline,
          border: border,
          child: child,
        );

  @override
  Widget build(BuildContext context) => _child;
}

class _MyDefaultCard extends StatelessWidget {
  final num? height, width;
  final BoxDecoration decoration;
  final EdgeInsets padding;
  final Widget? child;
  final Function()? onTap;
  final Color? color;
  final BorderRadius borderRadius;
  final Color? shadowColor;
  final num elevation;
  final _MyCardType type;
  final Border? border;
  final EdgeInsetsGeometry margin;

  _MyDefaultCard({
    this.height,
    this.width,
    final BoxDecoration? decoration,
    final EdgeInsets? padding,
    final EdgeInsets? margin,
    this.child,
    this.onTap,
    this.color,
    final num? elevation,
    final BorderRadius? borderRadius,
    this.type = _MyCardType.defaultCard,
    this.shadowColor,
    this.border,
  })  : borderRadius = borderRadius ?? BorderRadius.circular(12.0),
        decoration = decoration ?? const BoxDecoration(),
        padding = padding ?? const EdgeInsets.all(0),
        margin = margin ?? const EdgeInsets.all(0),
        elevation = elevation ?? 8.0;

  @override
  Widget build(BuildContext context) {
    /// go with passed other else go with conditional one
    final Color? cardColor = color ?? (type == _MyCardType.primary ? context.primary.withValues(alpha: 255 * 0.05) : null);
    Border? newBorder = border ?? (_MyCardType.outline == type ? Border.all(color: Colors.grey.withValues(alpha: 255 * 0.16)) : null);
    return Padding(
      padding: margin,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Ink(
          padding: padding,
          height: height?.toDouble(),
          width: width?.toDouble(),
          decoration: decoration.copyWith(
            borderRadius: borderRadius,
            border: newBorder,
            color: cardColor ?? context.cardColor,
            boxShadow: [
              BoxShadow(
                color: elevation == 0 ? Colors.transparent : shadowColor ?? context.shadow.withValues(alpha: 255 * 0.2),
                blurRadius: elevation.toDouble(),
                spreadRadius: 0.0,
                offset: Offset.zero,
              )
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
