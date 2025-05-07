import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/core/card/my_card.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.privacyPolicy.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PrivacyPolicyHeader(),
            const SizedBox(height: 24.0),
            _PrivacyPolicyContent(),
          ],
        ).responsiveConstrains(maxWidth: 800.0),
      ),
    );
  }
}

class _PrivacyPolicyHeader extends StatelessWidget {
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
                Icon(LucideIcons.shield, color: context.primary, size: 24),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.privacyPolicy.tr(),
                        style: context.titleMedium?.bold,
                      ),
                      Text(
                        AppStrings.lastUpdated.tr(
                          args: [(DateTime.now().format())],
                        ),
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

class _PrivacyPolicyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sections = [
      const _PolicySection(
        title: AppStrings.informationWeCollect,
        content: AppStrings.informationWeCollectContent,
      ),
      const _PolicySection(
        title: AppStrings.howWeUseInformation,
        content: AppStrings.howWeUseInformationContent,
      ),
      const _PolicySection(
        title: AppStrings.dataSecurity,
        content: AppStrings.dataSecurityContent,
      ),
      const _PolicySection(
        title: AppStrings.yourRights,
        content: AppStrings.yourRightsContent,
      ),
      const _PolicySection(
        title: AppStrings.thirdPartyServices,
        content: AppStrings.thirdPartyServicesContent,
      ),
      const _PolicySection(
        title: AppStrings.cookiesPolicy,
        content: AppStrings.cookiesPolicyContent,
      ),
      const _PolicySection(
        title: AppStrings.changesPolicy,
        content: AppStrings.changesPolicyContent,
      ),
      _PolicySection(
        title: AppStrings.contactUs,
        content: AppStrings.contactPrivacyContent.tr(
          args: ['privacy@quantumai.com'],
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.map((section) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: MyCard.outline(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.title.tr(),
                  style: context.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.primary,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(section.content.tr(), style: context.bodyMedium),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PolicySection {
  final String title;
  final String content;

  const _PolicySection({required this.title, required this.content});
}
