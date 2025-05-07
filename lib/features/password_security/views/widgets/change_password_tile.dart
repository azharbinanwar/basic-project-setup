import 'package:basic_project_template/core/card/my_card.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/mixin/validator.dart';
import 'package:basic_project_template/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChangePasswordTile extends StatefulWidget {
  const ChangePasswordTile({super.key});

  @override
  State<ChangePasswordTile> createState() => _ChangePasswordTileState();
}

class _ChangePasswordTileState extends State<ChangePasswordTile> {
  final ValueNotifier<bool> _changePasswordExpanded = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Password requirements
  final ValueNotifier<bool> _hasMinLength = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _hasUppercase = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _hasLowercase = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _hasNumber = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _hasSpecialChar = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _hasMinLength.dispose();
    _hasUppercase.dispose();
    _hasLowercase.dispose();
    _hasNumber.dispose();
    _hasSpecialChar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.0,
      children: [
        Text(
          AppStrings.password.tr(),
          style: context.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.primary,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _changePasswordExpanded,
          builder: (context, isExpanded, _) {
            return Column(
              children: [
                MyCard.outline(
                  onTap: () {
                    _changePasswordExpanded.value = !isExpanded;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(LucideIcons.key, color: context.primary),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.changePassword.tr(),
                                style: context.titleMedium?.bold,
                              ),
                              Text(
                                AppStrings.lastChanged.tr(
                                  args: ['3 months ago'],
                                ),
                                style: context.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                          color: context.onSurface.withAlpha(150),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: isExpanded
                      ? _ChangePasswordForm(
                          formKey: _formKey,
                          currentPasswordController: _currentPasswordController,
                          newPasswordController: _newPasswordController,
                          confirmPasswordController: _confirmPasswordController,
                          onCheckPasswordRequirements: _checkPasswordRequirements,
                          hasMinLength: _hasMinLength,
                          hasUppercase: _hasUppercase,
                          hasLowercase: _hasLowercase,
                          hasNumber: _hasNumber,
                          hasSpecialChar: _hasSpecialChar,
                          onCancel: () {
                            _changePasswordExpanded.value = false;
                            _currentPasswordController.clear();
                            _newPasswordController.clear();
                            _confirmPasswordController.clear();
                          },
                          onSubmit: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _changePassword();
                            }
                          },
                          isPasswordChanging: false,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _checkPasswordRequirements(String password) {
    _hasMinLength.value = password.length >= 8;
    _hasUppercase.value = password.contains(RegExp(r'[A-Z]'));
    _hasLowercase.value = password.contains(RegExp(r'[a-z]'));
    _hasNumber.value = password.contains(RegExp(r'[0-9]'));
    _hasSpecialChar.value = password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );
  }

  Future<void> _changePassword() async {}
}

class _ChangePasswordForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final Function(String) onCheckPasswordRequirements;
  final ValueNotifier<bool> hasMinLength;
  final ValueNotifier<bool> hasUppercase;
  final ValueNotifier<bool> hasLowercase;
  final ValueNotifier<bool> hasNumber;
  final ValueNotifier<bool> hasSpecialChar;
  final bool isPasswordChanging;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  const _ChangePasswordForm({
    required this.formKey,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onCheckPasswordRequirements,
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasNumber,
    required this.hasSpecialChar,
    required this.isPasswordChanging,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  State<_ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm> with Validator {
  final _autoValidateMode = ValueNotifier<AutovalidateMode>(AutovalidateMode.disabled);
  final _obscureTextNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: MyCard.outline(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: _obscureTextNotifier,
          builder: (_, obscureText, child) => ValueListenableBuilder(
            valueListenable: _autoValidateMode,
            builder: (context, autoValidateMode, child) {
              return Form(
                key: widget.formKey,
                autovalidateMode: autoValidateMode,
                child: Column(
                  spacing: 16.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: widget.currentPasswordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: AppStrings.currentPassword.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(obscureText ? LucideIcons.eyeOff : LucideIcons.eye),
                          onPressed: () => _obscureTextNotifier.value = !obscureText,
                        ),
                      ),
                      validator: validatePassword,
                    ),
                    TextFormField(
                      controller: widget.newPasswordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: AppStrings.newPassword.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(obscureText ? LucideIcons.eyeOff : LucideIcons.eye),
                          onPressed: () => _obscureTextNotifier.value = !obscureText,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.pleaseEnterNewPassword.tr();
                        }
                        if (value == widget.currentPasswordController.text) {
                          return AppStrings.newPasswordCannotBeSameAsOld.tr();
                        }
                        if (!(widget.hasMinLength.value &&
                            widget.hasUppercase.value &&
                            widget.hasLowercase.value &&
                            widget.hasNumber.value &&
                            widget.hasSpecialChar.value)) {
                          return AppStrings.passwordDoesNotMeetRequirements.tr();
                        }
                        return null;
                      },
                      onChanged: widget.onCheckPasswordRequirements,
                    ),
                    TextFormField(
                      controller: widget.confirmPasswordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: AppStrings.confirmNewPassword.tr(),
                        suffixIcon: IconButton(
                          icon: Icon(obscureText ? LucideIcons.eyeOff : LucideIcons.eye),
                          onPressed: () => _obscureTextNotifier.value = !obscureText,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.pleaseConfirmNewPassword.tr();
                        }
                        if (value != widget.newPasswordController.text) {
                          return AppStrings.passwordsDoNotMatch.tr();
                        }
                        return null;
                      },
                      onChanged: widget.onCheckPasswordRequirements,
                    ),
                    child!
                  ],
                ),
              );
            },
            child: Column(
              spacing: 24.0,
              children: [
                _PasswordRequirements(
                  hasMinLength: widget.hasMinLength,
                  hasUppercase: widget.hasUppercase,
                  hasLowercase: widget.hasLowercase,
                  hasNumber: widget.hasNumber,
                  hasSpecialChar: widget.hasSpecialChar,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 16.0,
                  children: [
                    TextButton(
                      onPressed: widget.onCancel,
                      child: Text(AppStrings.cancel.tr()),
                    ),
                    AppButton.shrink(
                      width: 180.0,
                      isProcessing: widget.isPasswordChanging,
                      onPressed: widget.isPasswordChanging
                          ? null
                          : () {
                              widget.onSubmit.call();
                              _autoValidateMode.value = AutovalidateMode.always;
                            },
                      child: Text(AppStrings.updatePassword.tr()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordRequirements extends StatelessWidget {
  final ValueNotifier<bool> hasMinLength;
  final ValueNotifier<bool> hasUppercase;
  final ValueNotifier<bool> hasLowercase;
  final ValueNotifier<bool> hasNumber;
  final ValueNotifier<bool> hasSpecialChar;

  const _PasswordRequirements({
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasNumber,
    required this.hasSpecialChar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.passwordRequirements.tr(),
          style: context.bodyMedium?.bold,
        ),
        const SizedBox(height: 8.0),
        _RequirementItem(
          requirement: AppStrings.atLeast8Characters,
          valueNotifier: hasMinLength,
        ),
        _RequirementItem(
          requirement: AppStrings.atLeastOneUppercase,
          valueNotifier: hasUppercase,
        ),
        _RequirementItem(
          requirement: AppStrings.atLeastOneLowercase,
          valueNotifier: hasLowercase,
        ),
        _RequirementItem(
          requirement: AppStrings.atLeastOneNumber,
          valueNotifier: hasNumber,
        ),
        _RequirementItem(
          requirement: AppStrings.atLeastOneSpecialChar,
          valueNotifier: hasSpecialChar,
        ),
      ],
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String requirement;
  final ValueNotifier<bool> valueNotifier;

  const _RequirementItem({
    required this.requirement,
    required this.valueNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, isMet, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            children: [
              Icon(
                isMet ? LucideIcons.circleCheck : LucideIcons.circle,
                size: 16,
                color: isMet ? Colors.green : context.onSurface.withAlpha(100),
              ),
              const SizedBox(width: 8.0),
              Text(
                requirement.tr(),
                style: context.bodySmall?.copyWith(
                  color: isMet ? context.onSurface : context.onSurface.withAlpha(170),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
