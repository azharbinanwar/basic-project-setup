import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/core/card/my_card.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class BugReportPage extends StatefulWidget {
  const BugReportPage({super.key});

  @override
  State<BugReportPage> createState() => _BugReportPageState();
}

class _BugReportPageState extends State<BugReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stepsController = TextEditingController();

  String _selectedPriority = 'medium';
  bool _isSubmitting = false;
  bool _showSuccess = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  Future<void> _submitBugReport() async {
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
          _titleController.clear();
          _descriptionController.clear();
          _stepsController.clear();
          _selectedPriority = 'medium';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.reportBug.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BugReportHeader(),
            const SizedBox(height: 24.0),

            // Bug report form
            _showSuccess
                ? _SuccessMessage()
                : _BugReportForm(
                    formKey: _formKey,
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    stepsController: _stepsController,
                    selectedPriority: _selectedPriority,
                    onPriorityChanged: (value) {
                      setState(() {
                        _selectedPriority = value;
                      });
                    },
                    isSubmitting: _isSubmitting,
                    onSubmit: _submitBugReport,
                  ),
          ],
        ).responsiveConstrains(maxWidth: 800.0),
      ),
    );
  }
}

class _BugReportHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCard.outline(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LucideIcons.bug, color: context.primary, size: 24),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.foundABug.tr(),
                        style: context.titleMedium?.bold,
                      ),
                      Text(
                        AppStrings.reportBugDescription.tr(),
                        style: context.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BugReportForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController stepsController;
  final String selectedPriority;
  final Function(String) onPriorityChanged;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  const _BugReportForm({
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.stepsController,
    required this.selectedPriority,
    required this.onPriorityChanged,
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
              AppStrings.bugDetails.tr(),
              style: context.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            // Bug title field
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: AppStrings.bugTitle.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(LucideIcons.circleAlert),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.pleaseEnterBugTitle.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            // Priority selection
            _PrioritySelector(
              selectedPriority: selectedPriority,
              onPriorityChanged: onPriorityChanged,
            ),
            const SizedBox(height: 16.0),

            // Bug description field
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: AppStrings.bugDescription.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 80.0),
                  child: Icon(LucideIcons.fileText),
                ),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.pleaseEnterBugDescription.tr();
                }
                if (value.length < 20) {
                  return AppStrings.bugDescriptionTooShort.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),

            // Steps to reproduce field
            TextFormField(
              controller: stepsController,
              decoration: InputDecoration(
                labelText: AppStrings.stepsToReproduce.tr(),
                hintText: AppStrings.stepsToReproduceHint.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 80.0),
                  child: Icon(LucideIcons.listOrdered),
                ),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.pleaseEnterStepsToReproduce.tr();
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
                  Text(AppStrings.submitReport.tr()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrioritySelector extends StatelessWidget {
  final String selectedPriority;
  final Function(String) onPriorityChanged;

  const _PrioritySelector({
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final priorities = [
      {'id': 'low', 'label': AppStrings.priorityLow, 'color': Colors.green},
      {
        'id': 'medium',
        'label': AppStrings.priorityMedium,
        'color': Colors.orange,
      },
      {'id': 'high', 'label': AppStrings.priorityHigh, 'color': Colors.red},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.bugPriority.tr(),
          style: context.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: priorities.map((priority) {
            final isSelected = selectedPriority == priority['id'];
            final color = priority['color'] as Color;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: InkWell(
                  onTap: () => onPriorityChanged(priority['id'] as String),
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: isSelected ? color.withAlpha(30) : context.cardColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected ? color : context.onSurface.withAlpha(25),
                        width: isSelected ? 2.0 : 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                            border: Border.all(
                              color: Colors.white,
                              width: isSelected ? 2.0 : 0.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          (priority['label'] as String).tr(),
                          textAlign: TextAlign.center,
                          style: context.bodySmall?.copyWith(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? color : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
            AppStrings.bugReportSubmitted.tr(),
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            AppStrings.bugReportThanks.tr(),
            textAlign: TextAlign.center,
            style: context.bodyMedium,
          ),
        ],
      ),
    );
  }
}
