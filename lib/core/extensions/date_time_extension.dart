import 'package:basic_project_template/core/constants/app_const.dart';
import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String toFormattedString() {
    return '$year-$month-$day';
  }

  String format([String format = AppConst.dateFormat]) {
    return DateFormat(format).format(this);
  }
}
