import 'package:basic_project_template/config/theme/extensions/app_color_extension.dart';
import 'package:basic_project_template/core/card/my_card.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

extension BuildContextEntension<T> on BuildContext {
  Color get inputFieldColor => Theme.of(this).extension<AppColorExtension>()!.inputFieldIconColor;

  Color get inputFieldIconColor => Theme.of(this).extension<AppColorExtension>()!.inputFieldIconColor;

  // success
  Color get success => Theme.of(this).extension<AppColorExtension>()!.success;

  Color get onSuccess => Theme.of(this).extension<AppColorExtension>()!.onSuccess;

  Color get successContainer => Theme.of(this).extension<AppColorExtension>()!.successContainer;

  Color get onSuccessContainer => Theme.of(this).extension<AppColorExtension>()!.onSuccessContainer;

  // Info colors
  Color get info => Theme.of(this).extension<AppColorExtension>()!.info;

  Color get onInfo => Theme.of(this).extension<AppColorExtension>()!.onInfo;

  Color get infoContainer => Theme.of(this).extension<AppColorExtension>()!.infoContainer;

  Color get onInfoContainer => Theme.of(this).extension<AppColorExtension>()!.onInfoContainer;

// Warning colors
  Color get warning => Theme.of(this).extension<AppColorExtension>()!.warning;

  Color get onWarning => Theme.of(this).extension<AppColorExtension>()!.onWarning;

  Color get warningContainer => Theme.of(this).extension<AppColorExtension>()!.warningContainer;

  Color get onWarningContainer => Theme.of(this).extension<AppColorExtension>()!.onWarningContainer;

// Neutral colors
  Color get neutral => Theme.of(this).extension<AppColorExtension>()!.neutral;

  Color get onNeutral => Theme.of(this).extension<AppColorExtension>()!.onNeutral;

  Color get neutralContainer => Theme.of(this).extension<AppColorExtension>()!.neutralContainer;

  Color get onNeutralContainer => Theme.of(this).extension<AppColorExtension>()!.onNeutralContainer;

// Neutral Variant colors
  Color get neutralVariant => Theme.of(this).extension<AppColorExtension>()!.neutralVariant;

  Color get onNeutralVariant => Theme.of(this).extension<AppColorExtension>()!.onNeutralVariant;

  Color get neutralVariantContainer => Theme.of(this).extension<AppColorExtension>()!.neutralVariantContainer;

  Color get onNeutralVariantContainer => Theme.of(this).extension<AppColorExtension>()!.onNeutralVariantContainer;

// Neutral Muted colors
  Color get neutralMuted => Theme.of(this).extension<AppColorExtension>()!.neutralMuted;

  Color get onNeutralMuted => Theme.of(this).extension<AppColorExtension>()!.onNeutralMuted;

  Color get neutralMutedContainer => Theme.of(this).extension<AppColorExtension>()!.neutralMutedContainer;

  Color get onNeutralMutedContainer => Theme.of(this).extension<AppColorExtension>()!.onNeutralMutedContainer;
}

/// Toast type enum used for different toast styles
enum ToastType {
  info,
  success,
  error,
  warning,
}

/// Extension on BuildContext to provide easy toast access
extension ToastExtension on BuildContext {
  /// Toast service accessor
  ToastService get toast => ToastService(this);
}

/// Toast service for showing different types of toasts
class ToastService {
  final BuildContext context;
  final FToast _fToast = FToast();

  ToastService(this.context) {
    _fToast.init(context);
  }

  /// Show an info toast
  void info(String message) => _showToast(message, ToastType.info);

  /// Show a success toast
  void success(String message) => _showToast(message, ToastType.success);

  /// Show an error toast
  void error(String message) => _showToast(message, ToastType.error);

  /// Show a warning toast
  void warning(String message) => _showToast(message, ToastType.warning);

  /// Main method to show a toast with the specified type
  void _showToast(String message, ToastType type) {
    _fToast.showToast(
      gravity: ToastGravity.BOTTOM,
      positionedToastBuilder: (context, child, gravity) => Positioned(
        left: 16.0,
        right: 16.0,
        bottom: 16.0 + context.paddingBottom,
        child: child,
      ),
      child: _buildToastCard(message, type),
    );
  }

  /// Build the toast card based on the message and type
  Widget _buildToastCard(String message, ToastType type) {
    // Get type-specific properties
    final (IconData icon, Color color) = _getToastProperties(type);

    return MyCard.outline(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        border: Border.all(color: color.withAlpha(50), width: 1.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: context.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Get type-specific properties based on toast type
  (IconData, Color) _getToastProperties(ToastType type) {
    return switch (type) {
      ToastType.info => (LucideIcons.info, context.primary),
      ToastType.success => (LucideIcons.circleCheck, Colors.green),
      ToastType.error => (LucideIcons.circleAlert, context.error),
      ToastType.warning => (LucideIcons.triangleAlert, Colors.orange),
    };
  }
}

/// Shorter global toast method for use in places without direct context
class Toast {
  /// Show an info toast
  static void i(BuildContext context, String message) => context.toast.info(message);

  /// Show a success toast
  static void s(BuildContext context, String message) => context.toast.success(message);

  /// Show an error toast
  static void e(BuildContext context, String message) => context.toast.error(message);

  /// Show a warning toast
  static void w(BuildContext context, String message) => context.toast.warning(message);
}
