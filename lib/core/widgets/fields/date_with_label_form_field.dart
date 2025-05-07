part of 'app_text_form_field.dart';

class _DateWithLabelFormField<T> extends StatefulWidget {
  final String? labelText;
  final DateTime? initialValue;
  final void Function(String)? onChanged;
  final String? Function(String? value)? validator;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final BorderRadius? borderRadius;

  const _DateWithLabelFormField({
    this.labelText,
    this.initialValue,
    this.onChanged,
    this.validator,
    final TextInputAction? textInputAction,
    this.prefixIcon,
    this.borderRadius,
  }) : textInputAction = textInputAction ?? TextInputAction.next;

  @override
  State<_DateWithLabelFormField<T>> createState() => _DateWithLabelFormFieldState<T>();
}

class _DateWithLabelFormFieldState<T> extends State<_DateWithLabelFormField<T>> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.search,
      controller: _controller,
      readOnly: true,
      maxLines: 1,
      validator: widget.validator,
      decoration: InputDecoration(
        // isCollapsed: true,
        prefixIcon: widget.prefixIcon ?? const Icon(LucideIcons.calendar),
        border: OutlineInputBorder(borderRadius: widget.borderRadius ?? BorderRadius.circular(20)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        label: Text(
          widget.initialValue != null ? widget.initialValue!.format() : widget.labelText!,
          style: context.labelLarge!.copyWith(
            color: Colors.grey.withValues(alpha: 200),
          ),
        ),
      ),
      onTap: () async {
        final DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          _controller.text = date.format();
          // widget.onChanged?.call(value.toString());
          setState(() {
            widget.onChanged!(date.toString());
          });
        }
      },
    );
  }
}
