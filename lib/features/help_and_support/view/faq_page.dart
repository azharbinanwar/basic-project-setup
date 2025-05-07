import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/core/card/my_card.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/widgets/app_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  // Track expanded FAQ items
  final Map<int, bool> _expandedItems = {};

  // Search controller
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter FAQs based on search query
    final filteredFaqs = _getFaqItems().where((faq) {
      if (_searchQuery.isEmpty) return true;
      return faq.question.tr().toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
          faq.answer.tr().toLowerCase().contains(
                _searchQuery.toLowerCase(),
              );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.faq.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FaqHeader(),
            const SizedBox(height: 24.0),

            // Search bar
            _SearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),

            const SizedBox(height: 24.0),

            // FAQ Categories
            _FaqCategories(
              onCategorySelected: (category) {
                // Handle category selection
              },
            ),

            const SizedBox(height: 24.0),

            // FAQ List
            filteredFaqs.isEmpty
                ? _NoResultsFound(searchQuery: _searchQuery)
                : Column(
                    children: List.generate(filteredFaqs.length, (index) {
                      final faq = filteredFaqs[index];
                      final isExpanded = _expandedItems[index] ?? false;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: _FaqItem(
                          question: faq.question,
                          answer: faq.answer,
                          isExpanded: isExpanded,
                          onToggle: () {
                            setState(() {
                              _expandedItems[index] = !isExpanded;
                            });
                          },
                        ),
                      );
                    }),
                  ),

            const SizedBox(height: 24.0),

            // Contact support section
            _ContactSupportSection(),
          ],
        ).responsiveConstrains(maxWidth: 800.0),
      ),
    );
  }

  List<_FaqData> _getFaqItems() {
    return [
      const _FaqData(
        question: AppStrings.exportDataQuestion,
        answer: AppStrings.exportDataAnswer,
      ),
      const _FaqData(
        question: AppStrings.accountDeletionQuestion,
        answer: AppStrings.accountDeletionAnswer,
      ),
      const _FaqData(
        question: AppStrings.apiIntegrationQuestion,
        answer: AppStrings.apiIntegrationAnswer,
      ),
      const _FaqData(
        question: AppStrings.modelAccuracyQuestion,
        answer: AppStrings.modelAccuracyAnswer,
      ),
    ];
  }
}

class _FaqData {
  final String question;
  final String answer;

  const _FaqData({required this.question, required this.answer});
}

class _FaqHeader extends StatelessWidget {
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
                Icon(LucideIcons.circleHelp, color: context.primary, size: 24),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.frequentlyAskedQuestions.tr(),
                        style: context.titleMedium?.bold,
                      ),
                      Text(
                        AppStrings.faqDescription.tr(),
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

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: AppStrings.searchInFaq.tr(),
        prefixIcon: const Icon(LucideIcons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: context.onSurface.withAlpha(30)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: context.onSurface.withAlpha(30)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: context.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(LucideIcons.x),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              )
            : null,
      ),
      onChanged: onChanged,
    );
  }
}

class _FaqCategories extends StatelessWidget {
  final Function(String) onCategorySelected;

  const _FaqCategories({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': AppStrings.gettingStarted, 'icon': LucideIcons.rocket},
      {'name': AppStrings.accountBilling, 'icon': LucideIcons.creditCard},
      {'name': AppStrings.dataPrivacy, 'icon': LucideIcons.shield},
      {'name': AppStrings.apiIntegration, 'icon': LucideIcons.code},
      {'name': AppStrings.modelTraining, 'icon': LucideIcons.brain},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () => onCategorySelected(category['name'] as String),
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: context.cardColor,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: context.onSurface.withAlpha(30),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      size: 18.0,
                      color: context.primary,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      (category['name'] as String).tr(),
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _FaqItem({
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard.outline(
      onTap: onToggle,
      color: isExpanded ? context.primary.withAlpha(30) : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    question.tr(),
                    style: context.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isExpanded ? context.primary : null,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
                  color: isExpanded ? context.primary : context.onSurface.withAlpha(20),
                  size: 20.0,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 12.0),
              const Divider(),
              const SizedBox(height: 12.0),
              Text(answer.tr(), style: context.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}

class _NoResultsFound extends StatelessWidget {
  final String searchQuery;

  const _NoResultsFound({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.search,
              size: 64.0,
              color: context.onSurface.withAlpha(75),
            ),
            const SizedBox(height: 16.0),
            Text(
              AppStrings.noResultsFound.tr(),
              style: context.titleMedium?.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              'SOmething to search for: "$searchQuery"',
              style: context.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactSupportSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCard.outline(
      color: context.primary.withAlpha(30),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  LucideIcons.messageSquare,
                  color: context.primary,
                  size: 24.0,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.stillNeedHelp.tr(),
                        style: context.titleMedium?.bold,
                      ),
                      Text(
                        AppStrings.contactSupportDescription.tr(),
                        style: context.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Column(
              spacing: 16.0,
              children: [
                AppButton.outline(
                  onPressed: () {
                    // Handle viewing documentation
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12.0,
                    children: [
                      const Icon(LucideIcons.bookOpen),
                      Text(AppStrings.viewDocumentation.tr()),
                    ],
                  ),
                ),
                AppButton(
                  onPressed: () {
                    // Handle contact support
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12.0,
                    children: [
                      const Icon(LucideIcons.messageSquare),
                      Text(AppStrings.contactSupport.tr()),
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
