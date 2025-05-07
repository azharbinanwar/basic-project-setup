import 'package:basic_project_template/core/card/my_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';

/// Position of a setting tile within a group
enum GroupPosition {
  /// Single item (not in group)
  single,

  /// First item in group
  first,

  /// Middle item in group
  middle,

  /// Last item in group
  last,
}

/// A tile widget used for settings screens with support for
/// grouping, badges, actions, and various customization options.
///
/// Use [AppTileGroup] to create grouped settings with proper
/// visual separation and borders.
class AppTile extends StatelessWidget {
  /// The title text to display
  final Widget title;

  /// Background color of the tile
  final Color? background;

  /// Foreground (text) color
  final Color? foreground;

  /// Widget to display at the end of the tile
  final Widget? trailing;

  /// Callback when the tile is tapped
  final VoidCallback? onTap;

  /// Widget to display at the start of the tile
  final Widget? leading;

  /// Custom padding for the tile content
  final EdgeInsetsGeometry? padding;

  /// Optional subtitle widget
  final Widget? subtitle;

  /// Optional badge widget to display
  final Widget? badge;

  /// List of action widgets to display at the bottom of the tile
  final List<Widget>? actions;

  /// Whether the tile is selected
  final bool isSelected;

  /// Whether the tile is part of a group
  final bool isGrouped;

  /// Position of the tile within a group
  final GroupPosition groupPosition;

  /// Key for testing purposes
  final String? testKey;

  /// Spacing between actions
  final double actionSpacing;

  /// Whether to show a divider above actions
  final bool showActionDivider;

  /// Color for the action divider
  final Color? actionDividerColor;

  const AppTile({
    super.key,
    required this.title,
    this.background,
    this.foreground,
    this.trailing,
    this.onTap,
    this.leading,
    this.padding,
    this.subtitle,
    this.badge,
    this.actions,
    this.isSelected = false,
    this.isGrouped = false,
    this.groupPosition = GroupPosition.single,
    this.testKey,
    this.actionSpacing = 8.0,
    this.showActionDivider = true,
    this.actionDividerColor,
  });

  @override
  Widget build(BuildContext context) {
    // Apply appropriate border radius based on group position
    final BorderRadius borderRadius = _getBorderRadius();

    // Create content widget
    final contentWidget = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main tile content
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              if (leading != null) ...[
                Padding(padding: const EdgeInsets.all(8), child: leading!),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: context.titleSmall!.copyWith(
                        color: foreground ?? (isSelected ? context.primary : null),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                      child: Row(
                        children: [
                          Expanded(child: title),
                          if (badge != null) ...[
                            const SizedBox(width: 8),
                            badge!,
                          ]
                        ],
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      DefaultTextStyle(
                        style: context.bodySmall!.copyWith(
                          color: context.onSurface.withAlpha(170),
                        ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 8),
                trailing!,
              ] else if (onTap != null && actions == null) ...[
                // Only show chevron if there are no actions and tile is tappable
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: foreground ?? (isSelected ? context.primary : context.onSurface.withAlpha(150)),
                  size: 20,
                ),
              ],
            ],
          ),
        ),

        // Action buttons section with divider
        if (actions != null && actions!.isNotEmpty) ...[
          if (showActionDivider) const Divider(indent: 12.0, endIndent: 12.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            alignment: Alignment.centerRight,
            child: Wrap(
              // mainAxisAlignment: MainAxisAlignment.end,
              runSpacing: actionSpacing,
              spacing: actionSpacing,
              alignment: WrapAlignment.end,
              children: actions!,
            ),
          ),
        ],
      ],
    );

    // Return either grouped or standalone version based on isGrouped flag
    return Semantics(
      label: title is Text ? (title as Text).data : null,
      enabled: onTap != null,
      button: onTap != null,
      child: isGrouped ? _buildGroupedTile(context, borderRadius, contentWidget) : _buildStandaloneTile(context, borderRadius, contentWidget),
    );
  }

  /// Creates a grouped tile with appropriate styling
  Widget _buildGroupedTile(BuildContext context, BorderRadius borderRadius, Widget contentWidget) {
    // Determine border width based on position (will be set by AppTileGroup)
    final double borderWidth = groupPosition == GroupPosition.middle
        ? (AppTileGroup.of(context)?.innerBorderWidth ?? 0.5)
        : (AppTileGroup.of(context)?.outerBorderWidth ?? 1.0);

    return MyCard.outline(
      key: testKey != null ? Key(testKey!) : null,
      onTap: onTap,
      color: background ?? (isSelected ? context.primary.withAlpha(25) : context.cardColor),
      borderRadius: borderRadius,
      border: Border.all(
        color: isSelected ? context.primary.withAlpha(75) : context.outlineVariant.withAlpha(50),
        width: borderWidth,
      ),
      elevation: 0,
      child: contentWidget,
    );
  }

  /// Creates a standalone tile with card styling
  Widget _buildStandaloneTile(BuildContext context, BorderRadius borderRadius, Widget contentWidget) {
    return MyCard.outline(
      key: testKey != null ? Key(testKey!) : null,
      onTap: onTap,
      color: background ?? (isSelected ? context.primary.withAlpha(25) : null),
      borderRadius: borderRadius,
      border: isSelected ? Border.all(color: context.primary.withAlpha(75)) : null,
      child: contentWidget,
    );
  }

  /// Returns the appropriate border radius based on group position
  BorderRadius _getBorderRadius() {
    const double radius = 12.0;
    const double middleRadius = 4.0; // Reduced corner radius for middle items

    if (!isGrouped) return BorderRadius.circular(radius);

    // Each tile gets appropriate corner rounding
    return switch (groupPosition) {
      GroupPosition.first => const BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(middleRadius),
          bottomRight: Radius.circular(middleRadius),
        ),
      GroupPosition.middle => BorderRadius.circular(middleRadius),
      GroupPosition.last => const BorderRadius.only(
          topLeft: Radius.circular(middleRadius),
          topRight: Radius.circular(middleRadius),
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
      GroupPosition.single => BorderRadius.circular(radius),
    };
  }
}

/// Helper class to create grouped setting tiles with proper styling and structure
class AppTileGroup extends StatelessWidget {
  /// Access the current AppTileGroup from descendants
  static AppTileGroup? of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<AppTileGroup>();
  }

  /// List of setting tiles to display in the group
  final List<AppTile> tiles;

  /// Optional group title
  final String? title;

  /// Padding around the group
  final EdgeInsetsGeometry padding;

  /// Background color for all tiles in the group
  final Color? backgroundColor;

  /// Key for testing purposes
  final String? testKey;

  /// Spacing between items in the group
  final double itemSpacing;

  /// Border width for outer tiles (first and last)
  final double outerBorderWidth;

  /// Border width for inner tiles (middle)
  final double innerBorderWidth;

  const AppTileGroup({
    super.key,
    required this.tiles,
    this.title,
    this.padding = const EdgeInsets.only(bottom: 16),
    this.backgroundColor,
    this.testKey,
    this.itemSpacing = 4.0, // Reduced spacing between items
    this.outerBorderWidth = 1.0, // Standard border width for outer tiles
    this.innerBorderWidth = 0.5, // Thinner border for inner tiles
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> groupedTiles = _createGroupedTiles(context);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                title!.tr(),
                style: context.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.primary,
                ),
              ),
            ),
          ],

          // Simple container without an additional border
          Container(
            key: testKey != null ? Key(testKey!) : null,
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: groupedTiles,
            ),
          ),
        ],
      ),
    );
  }

  /// Creates properly positioned tiles and spacing for the group
  List<Widget> _createGroupedTiles(BuildContext context) {
    final List<Widget> groupedTiles = [];

    for (int i = 0; i < tiles.length; i++) {
      // Determine position in group
      final GroupPosition position = _getPositionInGroup(i);

      // Create a new tile with group properties
      final tile = AppTile(
        title: tiles[i].title,
        background: tiles[i].background ?? backgroundColor,
        foreground: tiles[i].foreground,
        trailing: tiles[i].trailing,
        onTap: tiles[i].onTap,
        leading: tiles[i].leading,
        padding: tiles[i].padding,
        subtitle: tiles[i].subtitle,
        badge: tiles[i].badge,
        actions: tiles[i].actions,
        isSelected: tiles[i].isSelected,
        isGrouped: true,
        groupPosition: position,
        testKey: tiles[i].testKey,
        actionSpacing: tiles[i].actionSpacing,
        showActionDivider: tiles[i].showActionDivider,
        actionDividerColor: tiles[i].actionDividerColor,
      );

      // Add tile to list
      groupedTiles.add(tile);

      // Add spacing between items (except after the last one)
      if (i < tiles.length - 1) {
        groupedTiles.add(SizedBox(height: itemSpacing));
      }
    }

    return groupedTiles;
  }

  /// Determines the position of a tile within the group
  GroupPosition _getPositionInGroup(int index) {
    if (tiles.length == 1) {
      return GroupPosition.single;
    } else if (index == 0) {
      return GroupPosition.first;
    } else if (index == tiles.length - 1) {
      return GroupPosition.last;
    } else {
      return GroupPosition.middle;
    }
  }
}
