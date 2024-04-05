import 'package:basic_project_template/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension WidgetExtension on Widget {
  Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  Widget padding(EdgeInsets padding) => Padding(padding: padding, child: this);

  Widget onTap(VoidCallback? onTap) => GestureDetector(onTap: onTap, child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical), child: this);

  Widget paddingOnly({
    double left = 0.0,
    double right = 0.0,
    double top = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );

  Widget paddingFromLTRB({required double left, required double right, required double top, required double bottom}) =>
      Padding(padding: EdgeInsets.fromLTRB(left, top, right, bottom), child: this);

  Widget marginAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);

  Widget marginSymmetric({required double horizontal, required double vertical}) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical), child: this);

  Widget marginOnly({required double left, required double right, required double top, required double bottom}) =>
      Padding(padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom), child: this);

  Widget marginFromLTRB({required double left, required double right, required double top, required double bottom}) =>
      Padding(padding: EdgeInsets.fromLTRB(left, top, right, bottom), child: this);

  Widget center() => Center(child: this);

  Widget fit() => FittedBox(child: this);

  Widget materialized() => Material(child: this);

  Widget safeArea() => SafeArea(child: this);

  // Widget centerHorizontal() => Center(child: this);

  Widget align([AlignmentGeometry alignment = Alignment.center]) => Align(alignment: alignment, child: this);

  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget background(Color color) => Material(color: color, child: this);

  Widget constrains({
    double minWidth = 0.0,
    double maxWidth = double.infinity,
    double minHeight = 0.0,
    double maxHeight = double.infinity,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
      ),
      child: this,
    );
  }

  /// update status bar color according to the screens and theme
  Widget annotateRegion(BuildContext context, {Color? statusBarColor, Brightness? statusBarIconBrightness, Brightness? statusBarBrightness}) {
    Brightness brightness = Theme.of(context).brightness;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      /// if the value is null, the value of the current scope will be used
      /// if the value is not null, the value of the current scope will be replaced
      /// status bar colors are used opposite to the theme brightness
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? context.appBarColor,
        statusBarIconBrightness: statusBarIconBrightness ?? (brightness == Brightness.light ? Brightness.dark : Brightness.light),
        statusBarBrightness: statusBarBrightness ?? brightness,
      ),
      child: this,
    );
  }

  Widget toScrollableList([int length = 10, Axis scrollDirection = Axis.vertical, EdgeInsets padding = EdgeInsets.zero]) {
    List<Widget> items = List.generate(length, (index) => this);
    return SingleChildScrollView(
      padding: padding,
      scrollDirection: scrollDirection,
      child: scrollDirection == Axis.vertical ? Column(children: items) : Row(children: items),
    );
  }

  Widget scrollable({Axis scrollDirection = Axis.vertical, EdgeInsets padding = EdgeInsets.zero}) {
    return SingleChildScrollView(
      scrollDirection: scrollDirection,
      padding: padding,
      child: this,
    );
  }
}

extension ColumnExtension on Column {
  Column childrenPadding(EdgeInsets padding) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: children.map((e) => e.padding(padding)).toList(),
    );
  }
}
