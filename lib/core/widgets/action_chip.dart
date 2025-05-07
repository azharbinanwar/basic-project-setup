import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/extensions/build_context_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// A customizable chip widget with various predefined variants.
///
/// Provides consistent visual styling while allowing for customization.
/// Has variants like .live, .active, .success, .error, etc.
/// All variants support selection state via the selected parameter.
class AppChip extends StatelessWidget {
  final Widget _child;

  /// Creates a standard chip with the specified color, label and optional leading icon
  AppChip({
    super.key,
    final Widget? leading,
    required final Text label,
    final Color? color,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          leading: (context) => leading,
          label: label,
          colorSelector: (context) => color ?? context.onSurfaceVariant.withValues(alpha: 0.1),
          textColorSelector: (context) => context.onSurfaceVariant,
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates a "live" status chip with a pulsing dot indicator.
  ///
  /// Used to indicate something is currently active/live.
  AppChip.live({
    super.key,
    required final Text label,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _LiveChip(
          label: label,
          textColor: textColor,
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates an "active" status chip.
  ///
  /// Used to indicate an active state or status.
  AppChip.active({
    super.key,
    required final Text label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label,
          colorSelector: (context) => Colors.green,
          textColorSelector: (context) => textColor,
          leading: (context) => leading ?? const Icon(LucideIcons.check, size: 14.0, color: Colors.green),
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates an "inactive" status chip.
  ///
  /// Used to indicate an inactive or disabled state.
  AppChip.inactive({
    super.key,
    required final Text label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label,
          colorSelector: (context) => context.onSurface.withAlpha(180),
          textColorSelector: (context) => textColor,
          leading: (context) => leading,
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates a "success" chip.
  ///
  /// Used to indicate a successful status or action.
  AppChip.success({
    super.key,
    required final Text label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label,
          colorSelector: (context) => context.success,
          textColorSelector: (context) => textColor,
          leading: (context) => leading ?? const Icon(LucideIcons.circleCheck, size: 14.0, color: Colors.green),
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates an "error" chip.
  ///
  /// Used to indicate an error or destructive action.
  AppChip.error({
    super.key,
    required final Text label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label,
          colorSelector: (context) => context.error,
          textColorSelector: (context) => textColor,
          leading: (context) => leading ?? const Icon(LucideIcons.circleX, size: 14.0, color: Colors.red),
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates a "warning" chip.
  ///
  /// Used to indicate a warning status or action.
  AppChip.warning({
    super.key,
    required final Text label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label,
          colorSelector: (context) => context.warning,
          textColorSelector: (context) => textColor,
          leading: (context) => leading ?? const Icon(LucideIcons.triangleAlert, size: 14.0, color: Colors.orange),
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates an "info" chip.
  ///
  /// Used to indicate informational content.
  AppChip.info({
    super.key,
    required final Text label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label,
          colorSelector: (context) => context.info,
          textColorSelector: (context) => textColor,
          leading: (context) => leading ?? Icon(LucideIcons.info, size: 14.0, color: context.info),
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates a "primary" styled chip.
  ///
  /// Uses the primary theme color.
  AppChip.primary({
    super.key,
    required final Text label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label,
          colorSelector: (context) => context.primary,
          textColorSelector: (context) => textColor,
          leading: (context) => leading,
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates a "secondary" styled chip.
  ///
  /// Uses the secondary theme color.
  AppChip.secondary({
    super.key,
    required final Text label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label,
          colorSelector: (context) => context.secondary,
          textColorSelector: (context) => textColor,
          leading: (context) => leading,
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates an "edit" action chip.
  ///
  /// Used for edit actions, uses primary color by default.
  AppChip.edit({
    super.key,
    final Text? label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label ?? const Text(AppStrings.edit).tr(),
          colorSelector: (context) => context.primary,
          textColorSelector: (context) => textColor,
          leading: (context) => leading ?? Icon(LucideIcons.pen, size: 14.0, color: context.primary),
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates a "delete" action chip.
  ///
  /// Used for delete/remove actions, uses error color by default.
  AppChip.delete({
    super.key,
    final Text? label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label ?? const Text(AppStrings.delete).tr(),
          colorSelector: (context) => context.error,
          textColorSelector: (context) => textColor,
          leading: (context) => leading ?? Icon(LucideIcons.trash2, size: 14.0, color: context.error),
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates a "newFeature" chip.
  ///
  /// Used to highlight new items or features.
  AppChip.newFeature({
    super.key,
    final Text? label,
    final Widget? leading,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _ColoredChip(
          label: label ?? const Text('New'),
          colorSelector: (context) => context.secondary,
          textColorSelector: (context) => textColor,
          leading: (context) => leading ?? Icon(LucideIcons.star, size: 14.0, color: context.secondary),
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  /// Creates a "count" chip.
  ///
  /// Used to display counts or numbers.
  AppChip.count({
    super.key,
    required final int count,
    final Color? textColor,
    final VoidCallback? onTap,
    final EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    final double borderRadius = 16.0,
    final Color? color,
    final bool selected = false,
    final Color? selectedBackgroundColor,
    final Color? selectedTextColor,
  }) : _child = _CountChip(
          count: count,
          textColor: textColor,
          onTap: onTap,
          padding: padding,
          borderRadius: borderRadius,
          color: color,
          selected: selected,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
        );

  @override
  Widget build(BuildContext context) => _child;
}

/// Base chip implementation for standard chips
class _StandardChip extends StatelessWidget {
  final Widget? leading;
  final Text label;
  final Color color;
  final Color? textColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool selected;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;

  const _StandardChip({
    this.leading,
    required this.label,
    required this.color,
    this.textColor,
    this.onTap,
    required this.padding,
    required this.borderRadius,
    this.selected = false,
    this.selectedBackgroundColor,
    this.selectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = selected ? (selectedBackgroundColor ?? color) : color.withAlpha(25);

    // First check for explicitly provided text colors
    // Then fall back to auto-calculated colors based on background luminance
    final effectiveColor =
        selected ? (selectedTextColor ?? (effectiveBackgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white)) : (textColor ?? color);

    // Default text style based on the chip color and selection state
    final defaultTextStyle = context.bodySmall!.copyWith(
      color: effectiveColor,
      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: color.withAlpha(40),
        highlightColor: color.withAlpha(20),
        child: Ink(
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[
                IconTheme(
                    data: IconThemeData(
                      size: 15.0,
                      color: selected ? selectedTextColor ?? effectiveColor : textColor ?? color,
                    ),
                    child: leading!),
                const SizedBox(width: 4),
              ],
              Flexible(
                child: DefaultTextStyle(
                  style: defaultTextStyle,
                  child: label,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Live status chip with animated dot
class _LiveChip extends StatelessWidget {
  final Text label;
  final Color? textColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool selected;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;

  const _LiveChip({
    required this.label,
    this.textColor,
    this.onTap,
    required this.padding,
    required this.borderRadius,
    this.selected = false,
    this.selectedBackgroundColor,
    this.selectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return _StandardChip(
      leading: const _PulsingDot(color: Colors.green, size: 8.0),
      label: label,
      color: Colors.green,
      textColor: textColor,
      onTap: onTap,
      padding: padding,
      borderRadius: borderRadius,
      selected: selected,
      selectedBackgroundColor: selectedBackgroundColor,
      selectedTextColor: selectedTextColor,
    );
  }
}

/// Chip with dynamic color from context
class _ColoredChip extends StatelessWidget {
  final Text label;
  final Color Function(BuildContext) colorSelector;
  final Color? Function(BuildContext)? textColorSelector;
  final Widget? Function(BuildContext)? leading;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool selected;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;

  const _ColoredChip({
    required this.label,
    required this.colorSelector,
    this.textColorSelector,
    this.leading,
    this.onTap,
    required this.padding,
    required this.borderRadius,
    this.selected = false,
    this.selectedBackgroundColor,
    this.selectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = colorSelector(context);
    final textColor = textColorSelector?.call(context);

    return _StandardChip(
      leading: leading?.call(context),
      label: label,
      color: color,
      textColor: textColor,
      onTap: onTap,
      padding: padding,
      borderRadius: borderRadius,
      selected: selected,
      selectedBackgroundColor: selectedBackgroundColor,
      selectedTextColor: selectedTextColor,
    );
  }
}

/// Count chip for numeric values
class _CountChip extends StatelessWidget {
  final int count;
  final Color? textColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color? color;
  final bool selected;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;

  const _CountChip({
    required this.count,
    this.textColor,
    this.onTap,
    required this.padding,
    required this.borderRadius,
    this.color,
    this.selected = false,
    this.selectedBackgroundColor,
    this.selectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? context.primary;

    return _StandardChip(
      label: Text(count.toString()),
      color: effectiveColor,
      textColor: textColor,
      onTap: onTap,
      padding: padding,
      borderRadius: borderRadius,
      selected: selected,
      selectedBackgroundColor: selectedBackgroundColor,
      selectedTextColor: selectedTextColor,
    );
  }
}

/// A pulsing dot indicator widget for live status
class _PulsingDot extends StatefulWidget {
  final Color color;
  final double size;

  const _PulsingDot({
    required this.color,
    this.size = 8.0,
  });

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.5 * _animation.value),
                blurRadius: 6.0 * _animation.value,
                spreadRadius: 2.0 * _animation.value,
              ),
            ],
          ),
        );
      },
    );
  }
}
