part of 'app_text_form_field.dart';

class _AppTextFormFieldTime<T> extends StatefulWidget {
  final String? hintText;
  final DateTime? initialValue;
  final void Function(String, String)? onChanged;
  final String? Function(String? value)? validator;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;

  const _AppTextFormFieldTime({
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.prefixIcon,
    final TextInputAction? textInputAction,
    this.validator,
  }) : textInputAction = textInputAction ?? TextInputAction.next;

  @override
  State<_AppTextFormFieldTime> createState() => _AppTextFormFieldTimeState();
}

class _AppTextFormFieldTimeState extends State<_AppTextFormFieldTime> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.datetime,
      textInputAction: widget.textInputAction,
      readOnly: true,
      validator: widget.validator,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: widget.hintText,
      ),
      textAlign: TextAlign.center,
      onTap: () {
        context.showAppGeneralDialog(
          title: 'Title',
          child: SizedBox(
            height: context.height * 0.38,
            width: context.width,
            child: Column(
              children: [
                Material(
                  elevation: 2,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: MyCard(
                    height: context.height * 0.28,
                    width: context.width * 0.5,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: false,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (newTime) {
                        final formattedTime = DateFormat('h:mm a').format(newTime);
                        final time = formattedTime.substring(0, formattedTime.lastIndexOf(' '));
                        final period = formattedTime.substring(formattedTime.lastIndexOf(' ') + 1).toUpperCase();
                        _controller.text = time;
                        setState(() {
                          widget.onChanged!(time, period);
                          Log.i(runtimeType, time);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
                AppButton.outline(
                  height: 48.0,
                  child: Text(context.tr(AppStrings.next)),
                  onPressed: () {
                    context.router.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
