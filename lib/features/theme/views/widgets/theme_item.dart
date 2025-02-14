import 'package:basic_project_template/config/theme/theme_dark.dart';
import 'package:basic_project_template/config/theme/theme_light.dart';
import 'package:basic_project_template/core/widgets/app_image.dart';
import 'package:basic_project_template/features/theme/data/models/theme_model.dart';
import 'package:basic_project_template/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';

class ThemeItem extends StatelessWidget {
  final ThemeModel item;
  final bool selected;
  final void Function(ThemeModel theme) onThemeChanged;

  const ThemeItem({super.key, required this.item, required this.selected, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = item.themeMode == ThemeMode.dark ? ThemeDark().themeData : ThemeLight().themeData;

    if (item.themeMode == ThemeMode.system) {
      return Stack(
        children: [
          // Light theme base
          _ThemeItem(item: item, theme: ThemeLight().themeData, onThemeChanged: onThemeChanged, selected: selected),

          // Dark theme overlay with CustomPaint
          ClipPath(
            clipper: DiagonalClipper(),
            clipBehavior: Clip.hardEdge,
            child: _ThemeItem(item: item, theme: ThemeDark().themeData, onThemeChanged: onThemeChanged, selected: selected),
          ),
        ],
      );
    } else {
      return _ThemeItem(item: item, theme: themeData, onThemeChanged: onThemeChanged, selected: selected);
    }
  }
}

class _ThemeItem extends StatelessWidget {
  final ThemeModel item;
  final ThemeData theme;
  final bool selected;
  final void Function(ThemeModel item) onThemeChanged;

  const _ThemeItem({required this.item, required this.theme, required this.onThemeChanged, required this.selected});

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        Theme(
          data: theme,
          child: Column(
            spacing: 16.0,
            children: [
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () => onThemeChanged(item),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: context.outlineVariant.withAlpha(50), width: 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.scaffoldBackgroundColor,
                          border: selected ? Border.all(color: ctx.primary, width: 3) : Border.all(color: Colors.transparent, width: 3),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          spacing: 16.0,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateTime.now().format(format: 'hh:mm'), style: context.bodySmall?.withSize(4.0)),
                                  Text('55%', style: context.bodySmall?.withSize(4.0)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
                              child: Column(
                                spacing: 8.0,
                                children: [
                                  Container(
                                    height: 24,
                                    width: 24,
                                    decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(4.0)),
                                    child: FittedBox(child: AppImage.svg(Assets.svgs.appOutlineLogo, color: context.onPrimary)).center(),
                                  ),
                                  Container(
                                    height: 30,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: context.primary,
                                      border: Border.all(color: context.outlineVariant, width: 0.5),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  Container(
                                    height: 14,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: context.outlineVariant, width: 0.5),
                                      color: context.surface,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    spacing: 3,
                                    children: List.generate(
                                      3,
                                          (index) =>
                                          Container(
                                            decoration: BoxDecoration(
                                              color: context.cardColor,
                                              borderRadius: BorderRadius.circular(2),
                                              border: Border.all(color: context.outlineVariant, width: 0.5),
                                            ),
                                            height: 14,
                                            width: double.infinity,
                                          ).expanded(),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(color: context.outlineVariant, width: 0.5),
                                    ),
                                    height: 14,
                                    width: double.infinity,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(color: context.primary, borderRadius: BorderRadius.circular(2)),
                                    height: 14,
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Text(item.name, style: ctx.bodySmall).tr(),
      ],
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(0, size.height * 0.9);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
