import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/core/bloc/helper.dart';
import 'package:basic_project_template/core/card/my_card.dart';
import 'package:basic_project_template/core/constants/app_const.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/services/logger/logger.dart';
import 'package:basic_project_template/core/widgets/app_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

part 'date_text_form_field.dart';
part 'date_with_label_form_field.dart';
part 'dropdown_text_form_field.dart';
part 'time_picket_form_field.dart';

class AppTextFormField<T> extends StatelessWidget {
  final Widget _child;

  AppTextFormField.date({
    final DateTime? initialValue,
    super.key,
    final String? hintText,
    final void Function(DateTime)? onChanged,
    final TextInputAction? textInputAction,
    final String? Function(String? value)? validator,
    final Widget? prefixIcon,
    final bool? updatedBorders,
    final String? format,
  }) : _child = _AppTextFormFieldDate(
          hintText: hintText,
          initialValue: initialValue,
          onChanged: onChanged,
          textInputAction: textInputAction,
          prefixIcon: prefixIcon,
          validator: validator,
          updatedBorders: updatedBorders ?? false,
          format: format,
        );

  AppTextFormField.dateWithLabel({
    final DateTime? initialValue,
    super.key,
    final String? labelText,
    final void Function(String)? onChanged,
    final TextInputAction? textInputAction,
    final String? Function(String? value)? validator,
    final Widget? prefixIcon,
    final BorderRadius? borderRadius,
  }) : _child = _DateWithLabelFormField(
          labelText: labelText,
          initialValue: initialValue,
          onChanged: onChanged,
          textInputAction: textInputAction,
          prefixIcon: prefixIcon,
          validator: validator,
          borderRadius: borderRadius,
        );

  AppTextFormField.time({
    final DateTime? initialValue,
    super.key,
    final String? hintText,
    final void Function(String, String)? onChanged,
    final TextInputAction? textInputAction,
    final String? Function(String? value)? validator,
    final Widget? prefixIcon,
  }) : _child = _AppTextFormFieldTime(
          hintText: hintText,
          initialValue: initialValue,
          onChanged: onChanged,
          textInputAction: textInputAction,
          prefixIcon: prefixIcon,
          validator: validator,
        );

  AppTextFormField.dropdown({
    final T? initialValue,
    super.key,
    required final List<DropdownData<T>> items,
    final void Function(T value)? onChanged,
    final Widget? prefixIcon,
    final String? hintText,
    final String? labelText,
    final String? Function(String? value)? validator,
    final EdgeInsets? contentPadding,
    final TextStyle? itemStyle,
    final TextStyle? hintStyle,
    final TextStyle? style,
    final bool? updatedBorders,
  }) : _child = _DropDownTextFormField(
          initialValue: initialValue,
          items: items,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          hintText: hintText,
          labelText: labelText,
          validator: validator,
          contentPadding: contentPadding,
          hintStyle: hintStyle,
          itemStyle: itemStyle,
          style: style,
          updatedBorders: updatedBorders ?? false,
        );

  AppTextFormField.localeDropdown({
    final T? initialValue,
    super.key,
    required final List<LocaleDropdownData<T>> items,
    final void Function(T value)? onChanged,
    final Widget? prefixIcon,
    final String? hintText,
    final String? Function(String? value)? validator,
    final EdgeInsets? contentPadding,
    final TextStyle? hintStyle,
    final TextStyle? style,
    final bool? updatedBorders,
  }) : _child = _DropDownTextFormFieldLocalization(
          initialValue: initialValue,
          items: items,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          hintText: hintText,
          validator: validator,
          contentPadding: contentPadding,
          hintStyle: hintStyle,
          style: style,
          updatedBorders: updatedBorders ?? false,
        );

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}
