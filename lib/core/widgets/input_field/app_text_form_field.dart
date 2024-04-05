import 'package:basic_project_template/core/bloc/helper.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/extensions/build_context_extension.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'date_text_form_field.dart';
part 'dropdown_text_form_field.dart';

class AppTextFormField extends StatelessWidget {
  final Widget _child;

  AppTextFormField.date({
    super.key,
    final String? hintText,
    final void Function(String)? onChanged,
    final TextInputAction? textInputAction,
    final Widget? prefixIcon,
  }) : _child = _AppTextFormFieldDate(
          hintText: hintText,
          onChanged: onChanged,
          textInputAction: textInputAction,
          prefixIcon: prefixIcon,
        );

  AppTextFormField.dropdown({
    super.key,
    required final List<DropdownData> items,
    final void Function(String)? onChanged,
    final Widget? prefixIcon,
    final String? hintText,
  }) : _child = _DropDownTextFormField(
          items: items,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          hintText: hintText,
        );

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}
