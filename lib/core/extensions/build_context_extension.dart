import 'package:basic_project_template/core/card/my_card.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension BuildContextEntension<T> on BuildContext {
  void showToast(String message) {
    return FToast().init(this).showToast(
          gravity: ToastGravity.SNACKBAR,
          positionedToastBuilder: (context, child, gravity) => Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 16.0 + context.paddingBottom,
            child: child,
          ),
          child: MyCard.outline(
            padding: EdgeInsets.all(12.0),
            color: primaryContainer.withAlpha(50),
            child: Text(message, style: titleSmall),
          ),
        );
  }
}
