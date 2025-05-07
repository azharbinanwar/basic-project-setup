part of 'app_text_form_field.dart';

class _DropDownTextFormField<T> extends StatelessWidget {
  final T? initialValue;
  final List<DropdownData> items;
  final void Function(T value)? onChanged;
  final Widget? prefixIcon;
  final String? hintText;
  final String? labelText;
  final String? Function(String? value)? validator;
  final EdgeInsets? contentPadding;
  final TextStyle? itemStyle;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool updatedBorders;

  _DropDownTextFormField({
    super.key,
    this.initialValue,
    required this.items,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.contentPadding,
    this.itemStyle,
    this.hintStyle,
    this.labelText,
    this.style,
    this.updatedBorders = false,
  });

  final Helper<T> _helper = Helper();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Helper<T>, T?>(
      bloc: _helper,
      builder: (context, gender) {
        return DropdownButtonFormField2<T>(
          value: initialValue,
          isExpanded: true,
          validator: (value) => validator?.call(value?.toString()),
          selectedItemBuilder: (_) => items.map((e) => Text(context.tr(e.label))).toList(),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            isDense: true,
            label: labelText != null ? Text(context.tr(labelText!)) : null,
            border: Theme.of(context).inputDecorationTheme.border,
            enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
            focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          ),
          hint: hintText == null ? null : Text(hintText!, style: hintStyle),
          style: style ?? context.titleMedium,
          items: List.generate(
            items.length,
            (i) {
              final item = items[i];
              return DropdownMenuItem<T>(
                value: item.value,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: (i == items.length - 1) ? null : const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: ListTile(leading: item.icon, title: Text(context.tr(item.label), style: itemStyle)),
                ),
              );
            },
          ),
          onChanged: (value) {
            _helper.update(value);
            if (value != null) onChanged?.call(value);
          },
          iconStyleData: const IconStyleData(icon: Icon(LucideIcons.chevronDown, color: Colors.grey)),
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            offset: const Offset(0.0, -5.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey)),
          ),
          menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.zero),
        );
      },
    );
  }
}

class _DropDownTextFormFieldLocalization<T> extends StatelessWidget {
  final T? initialValue;
  final List<LocaleDropdownData> items;
  final void Function(T value)? onChanged;
  final Widget? prefixIcon;
  final String? hintText;
  final String? Function(String? value)? validator;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool updatedBorders;

  _DropDownTextFormFieldLocalization({
    super.key,
    this.initialValue,
    required this.items,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.contentPadding,
    this.hintStyle,
    this.style,
    this.updatedBorders = false,
  });

  final Helper<T> _helper = Helper();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Helper<T>, T?>(
      bloc: _helper,
      builder: (context, gender) {
        return DropdownButtonFormField2<T>(
          value: initialValue,
          isExpanded: true,
          validator: (value) => validator?.call(value?.toString()),
          selectedItemBuilder: (_) => items.map((e) => Text(context.tr(e.label))).toList(),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            contentPadding: contentPadding,
            isDense: true,
            border: updatedBorders
                ? OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withValues(alpha: 200)), borderRadius: BorderRadius.circular(20))
                : null,
            enabledBorder: updatedBorders
                ? OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withValues(alpha: 200)), borderRadius: BorderRadius.circular(20))
                : null,
            focusedBorder: updatedBorders
                ? OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withValues(alpha: 200)), borderRadius: BorderRadius.circular(20))
                : null,
          ),
          hint: hintText == null ? null : Text(hintText!, style: hintStyle),
          style: style ?? context.titleMedium!.copyWith(color: Colors.grey.withValues(alpha: 200)),
          items: List.generate(
            items.length,
            (i) {
              final item = items[i];
              return DropdownMenuItem<T>(
                value: item.value,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: (i == items.length - 1)
                      ? null
                      : BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withValues(alpha: 250 * 0.3)))),
                  child: ListTile(leading: item.icon, title: Text(context.tr(item.label), style: item.itemStyle)),
                ),
              );
            },
          ),
          onChanged: (value) {
            _helper.update(value);
            if (value != null) onChanged?.call(value);
          },
          iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey)),
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            offset: const Offset(0.0, -5.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey)),
          ),
          menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.zero),
        );
      },
    );
  }
}

class DropdownData<T> {
  final Widget? icon;
  final String label;
  final T value;

  DropdownData({
    this.icon,
    required this.label,
    required this.value,
  });
}

class LocaleDropdownData<T> {
  final Widget? icon;
  final String label;
  final T value;
  final TextStyle? itemStyle;

  LocaleDropdownData({
    this.icon,
    required this.label,
    required this.value,
    this.itemStyle,
  });
}
