import 'dart:math';

import 'package:basic_project_template/config/theme/extensions/app_color_extension.dart';
import 'package:basic_project_template/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

extension BuildContextEntension<T> on BuildContext {
  Size get size => MediaQuery.of(this).size;

  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet => MediaQuery.of(this).size.width < 1024.0 && MediaQuery.of(this).size.width >= 650.0;

  bool get isSmallTablet => MediaQuery.of(this).size.width < 650.0 && MediaQuery.of(this).size.width > 500.0;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;

  bool get isSmall => MediaQuery.of(this).size.width < 850.0 && MediaQuery.of(this).size.width >= 560.0;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get paddingTop => MediaQuery.of(this).padding.top;

  double get statusBarHeight => MediaQuery.of(this).padding.top;

  int responsiveBreakpoint([double width = 400]) => max(size.width ~/ width, 1);

  // text styles

  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;

  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;

  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;

  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;

  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;

  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;

  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;

  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;

  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!.copyWith();

  TextStyle get titleTextStyle => Theme.of(this).appBarTheme.titleTextStyle!;

  TextStyle get bodyExtraSmall => bodySmall.copyWith();

  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;

  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;

  TextStyle get dividerTextSmall => bodySmall.copyWith(letterSpacing: 0.5, fontWeight: FontWeight.w700, fontSize: 12.0);

  TextStyle get dividerTextLarge => bodySmall.copyWith(letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 13.0, height: 1.23);

  // colors

  ThemeData get theme => Theme.of(this);

  IconThemeData get iconTheme => Theme.of(this).iconTheme;

  Brightness get brightness => Theme.of(this).brightness;

  ColorScheme get seedColor => Theme.of(this).colorScheme;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get primaryLight => Theme.of(this).extension<AppColorExtension>()!.primaryLight;

  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;

  Color get onPrimaryContainer => Theme.of(this).colorScheme.onPrimaryContainer;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;

  Color get onSecondaryContainer => Theme.of(this).colorScheme.onSecondaryContainer;

  Color get surface => Theme.of(this).colorScheme.surface;

  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  Color get error => Theme.of(this).colorScheme.error;

  Color get onError => Theme.of(this).colorScheme.onError;

  Color get errorContainer => Theme.of(this).colorScheme.errorContainer;

  Color get onErrorContainer => Theme.of(this).colorScheme.onErrorContainer;

  Color get shadow => Theme.of(this).colorScheme.shadow;

  Color get background => Theme.of(this).colorScheme.background;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get cardColor => Theme.of(this).cardColor;

  AppBarTheme get appBarTheme => Theme.of(this).appBarTheme;

  Color get appBarColor => Theme.of(this).appBarTheme.backgroundColor!;

  Color get iconColor => Theme.of(this).iconTheme.color!;

  Color get inputFieldIconColor => Theme.of(this).extension<AppColorExtension>()!.inputFieldIconColor;

  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;

  Orientation get orientation => MediaQuery.of(this).orientation;

  Future<T?> showBottomSheet(
    Widget child, {
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return showModalBottomSheet(
      context: this,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (context) => Wrap(children: [child]),
    );
  }

  Future<dynamic> showOverlayPopup([bool barrierDismissible = false]) {
    return showDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.transparent,
      builder: (context) => const AlertDialog(),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        // backgroundColor: primary,
      ),
    );
  }

  BottomNavigationBarThemeData get bottomNavigationBarTheme => Theme.of(this).bottomNavigationBarTheme;

  Future<Object?> showAppGeneralDialog({
    required final String title,
    final List<Widget> actions = const [],
    required Widget child,
    final EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
  }) {
    // add 8 points between actions
    List<Widget> userActions =
        actions.length <= 1 ? actions : actions.map((e) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0), child: e)).toList();
    return showGeneralDialog(
      context: this,
      barrierColor: primary.withOpacity(0.5),
      pageBuilder: (BuildContext context, _, __) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: min(width * .9, 500.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Material(
              color: context.theme.canvasColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 48.0),
                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: context.appBarTheme.titleTextStyle,
                          ),
                        ),
                        IconButton(
                          splashRadius: 20.0,
                          icon: Icon(Icons.close, color: context.primary),
                          onPressed: Navigator.of(context).pop,
                        )
                      ],
                    ),
                  ),
                  // const SizedBox(height: 8.0),
                  Padding(
                    padding: padding,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        child,
                        if (userActions.isNotEmpty) ...{
                          const SizedBox(height: 16.0),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: userActions).fit()
                        },
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).center();
      },
    );
  }

// Future<bool?> showToast(String message) {
//   return Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: primary,
//     textColor: onPrimary,
//   );
// }
//   AppLocalizations get tr => AppLocalizations.of(this);
}
