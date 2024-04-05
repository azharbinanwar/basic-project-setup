part of 'app_text_form_field.dart';

class _DropDownTextFormField extends StatelessWidget {
  final List<DropdownData> items;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final String? hintText;

  _DropDownTextFormField({
    super.key,
    required this.items,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
  });

  final Helper<String> _helper = Helper();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Helper<String>, String?>(
      bloc: _helper,
      builder: (context, gender) {
        return DropdownButtonFormField2<String>(
          isExpanded: true,
          selectedItemBuilder: (_) => items.map((e) => Text(context.tr(e.label))).toList(),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
          ),
          hint: hintText == null ? null : Text(hintText!),
          items: List.generate(
            items.length,
            (i) {
              var item = items[i];
              return DropdownMenuItem<String>(
                value: item.value,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: (i == items.length - 1)
                      ? null
                      : BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))),
                  child: ListTile(leading: item.icon, title: Text(context.tr(item.label))),
                ),
              );
            },
          ),
          onChanged: (String? value) {
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

class DropdownData {
  final Widget? icon;
  final String label;
  final String value;

  DropdownData({
    this.icon,
    required this.label,
    required this.value,
  });
}
