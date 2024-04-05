part of 'app_text_form_field.dart';

class _AppTextFormFieldDate extends StatefulWidget {
  final String? hintText;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;

  const _AppTextFormFieldDate({
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    final TextInputAction? textInputAction,
  }) : textInputAction = textInputAction ?? TextInputAction.next;

  @override
  State<_AppTextFormFieldDate> createState() => _AppTextFormFieldDateState();
}

class _AppTextFormFieldDateState extends State<_AppTextFormFieldDate> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.datetime,
      textInputAction: widget.textInputAction,
      readOnly: true,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon ?? Icon(Icons.calendar_month_sharp),
        hintText: widget.hintText,
      ),
      onTap: () {
        context.showAppGeneralDialog(
          title: context.tr(AppStrings.chooseDate),
          child: Text('Add your date picker'),
        );
      },
    );
  }
}
