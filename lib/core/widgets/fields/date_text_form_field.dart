part of 'app_text_form_field.dart';

class _AppTextFormFieldDate<T> extends StatefulWidget {
  final String? hintText;
  final DateTime? initialValue;
  final void Function(DateTime)? onChanged;
  final String? Function(String? value)? validator;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final bool updatedBorders;
  final String format;

  const _AppTextFormFieldDate({
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.prefixIcon,
    final TextInputAction? textInputAction,
    this.validator,
    this.updatedBorders = false,
    final String? format,
  })  : textInputAction = textInputAction ?? TextInputAction.next,
        format = format ?? AppConst.dateFormat;

  @override
  State<_AppTextFormFieldDate> createState() => _AppTextFormFieldDateState();
}

class _AppTextFormFieldDateState extends State<_AppTextFormFieldDate> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) _controller.text = widget.initialValue!.format();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      // initialValue: widget.initialValue?.format(widget.format),
      keyboardType: TextInputType.datetime,
      textInputAction: widget.textInputAction,
      readOnly: true,
      // onChanged: (value) => widget.onChanged!(value.toString()),
      validator: widget.validator,
      style: context.titleMedium!.copyWith(color: Colors.grey.withValues(alpha: 200)),
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon ?? const Icon(LucideIcons.calendar, color: Colors.grey),

        hintText: widget.initialValue != null ? widget.initialValue!.format() : widget.hintText,
        // hintStyle: context.titleMedium!.copyWith(color: context.lightGreyBorderColor.withOpacity(0.5)),
        border: widget.updatedBorders
            ? OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withValues(alpha: 200)), borderRadius: BorderRadius.circular(20))
            : null,
        enabledBorder: widget.updatedBorders
            ? OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withValues(alpha: 200)), borderRadius: BorderRadius.circular(20))
            : null,

        focusedBorder: widget.updatedBorders
            ? OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withValues(alpha: 200)), borderRadius: BorderRadius.circular(20))
            : null,
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
            widget.onChanged!(date);
          });
        }
      },
    );
  }
}
