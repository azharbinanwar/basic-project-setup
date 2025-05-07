import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/core/card/my_card.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({super.key});

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  String _selectedCategory = '';
  bool _isSubmitting = false;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    _selectedCategory = _supportCategories.first.id;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  List<_SupportCategory> get _supportCategories => [
        const _SupportCategory(
          id: 'general',
          name: AppStrings.generalInquiry,
          icon: LucideIcons.circleHelp,
          description: AppStrings.generalInquiryDescription,
        ),
        const _SupportCategory(
          id: 'technical',
          name: AppStrings.technicalSupport,
          icon: LucideIcons.wrench,
          description: AppStrings.technicalSupportDescription,
        ),
        const _SupportCategory(
          id: 'billing',
          name: AppStrings.billingSupport,
          icon: LucideIcons.creditCard,
          description: AppStrings.billingSupportDescription,
        ),
        const _SupportCategory(
          id: 'feedback',
          name: AppStrings.featureFeedback,
          icon: LucideIcons.messageSquare,
          description: AppStrings.featureFeedbackDescription,
        ),
        const _SupportCategory(
          id: 'bug',
          name: AppStrings.reportBug,
          icon: LucideIcons.bug,
          description: AppStrings.reportBugDescription,
        ),
      ];

  Future<void> _submitSupportRequest() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
      _showSuccess = true;
    });

    // Reset form after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSuccess = false;
          _nameController.clear();
          _emailController.clear();
          _subjectController.clear();
          _messageController.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.contactSupport.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Support form section
            const _SectionHeader(title: AppStrings.sendMessage),
            const SizedBox(height: 12.0),

            // Category selection
            _CategorySelector(
              categories: _supportCategories,
              selectedCategoryId: _selectedCategory,
              onCategorySelected: (categoryId) {
                setState(() {
                  _selectedCategory = categoryId;
                });
              },
            ),
            const SizedBox(height: 24.0),

            // Contact form
            _showSuccess
                ? _SuccessMessage()
                : _ContactForm(
                    formKey: _formKey,
                    nameController: _nameController,
                    emailController: _emailController,
                    subjectController: _subjectController,
                    messageController: _messageController,
                    isSubmitting: _isSubmitting,
                    onSubmit: _submitSupportRequest,
                  ),

            const SizedBox(height: 24.0),

            // FAQ reference
            // _FaqReference(),
          ],
        ).responsiveConstrains(maxWidth: 800.0),
      ),
    );
  }
}

class _SupportCategory {
  final String id;
  final String name;
  final IconData icon;
  final String description;

  const _SupportCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
      child: Text(
        title.tr(),
        style: context.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.primary,
        ),
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final List<_SupportCategory> categories;
  final String selectedCategoryId;
  final Function(String) onCategorySelected;

  const _CategorySelector({
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard.outline(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.selectCategory.tr(),
            style: context.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: categories.map((category) {
              final isSelected = category.id == selectedCategoryId;

              return InkWell(
                onTap: () => onCategorySelected(category.id),
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  width: 140.0,
                  height: 100.0,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isSelected ? context.primary.withAlpha(30) : context.cardColor,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: isSelected ? context.primary : context.onSurface.withAlpha(25),
                      width: isSelected ? 2.0 : 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category.icon,
                        color: isSelected ? context.primary : context.onSurface.withAlpha(170),
                        size: 24.0,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        category.name.tr(),
                        textAlign: TextAlign.center,
                        style: context.bodyMedium?.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? context.primary : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          if (selectedCategoryId.isNotEmpty) ...[
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Text(
              categories.firstWhere((c) => c.id == selectedCategoryId).description.tr(),
              style: context.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController subjectController;
  final TextEditingController messageController;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const _ContactForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.subjectController,
    required this.messageController,
    required this.isSubmitting,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: MyCard.outline(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.contactForm.tr(),
              style: context.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            // Name field
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: AppStrings.yourName.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(LucideIcons.user),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.pleaseEnterYourName.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            // Email field
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: AppStrings.yourEmail.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(LucideIcons.mail),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.pleaseEnterYourEmail.tr();
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return AppStrings.pleaseEnterValidEmail.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            // Subject field
            TextFormField(
              controller: subjectController,
              decoration: InputDecoration(
                labelText: AppStrings.subject.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(LucideIcons.alignLeft),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.pleaseEnterSubject.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            // Message field
            TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: AppStrings.message.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 80.0),
                  child: Icon(LucideIcons.messageSquare),
                ),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.pleaseEnterMessage.tr();
                }
                if (value.length < 20) {
                  return AppStrings.messageTooShort.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 24.0),

            // Submit button
            AppButton(
              onPressed: isSubmitting ? null : onSubmit,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSubmitting)
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(right: 12.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: context.onPrimary,
                      ),
                    )
                  else
                    const Icon(LucideIcons.send),
                  const SizedBox(width: 8.0),
                  Text(AppStrings.sendMessage.tr()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCard.outline(
      color: Colors.green.withAlpha(25),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.green.withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.check, color: Colors.green, size: 32.0),
          ),
          const SizedBox(height: 16.0),
          Text(
            AppStrings.messageSent.tr(),
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            AppStrings.messageSentDescription.tr(),
            textAlign: TextAlign.center,
            style: context.bodyMedium,
          ),
        ],
      ),
    );
  }
}
