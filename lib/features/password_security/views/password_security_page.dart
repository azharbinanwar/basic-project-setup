import 'package:auto_route/auto_route.dart';
import 'package:basic_project_template/core/card/my_card.dart';
import 'package:basic_project_template/core/constants/app_strings.dart';
import 'package:basic_project_template/core/widgets/app_tile.dart';
import 'package:basic_project_template/features/password_security/views/widgets/change_password_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extensions_plus/extensions_plus.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

@RoutePage()
class PasswordSecurityPage extends StatefulWidget {
  const PasswordSecurityPage({super.key});

  @override
  State<PasswordSecurityPage> createState() => _PasswordSecurityPageState();
}

class _PasswordSecurityPageState extends State<PasswordSecurityPage> {
  bool _twoFactorEnabled = false;
  bool _biometricEnabled = true;

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

  void _showSetup2FADialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.twoFactorSetup.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.onSurface.withAlpha(25),
              ),
              child: Center(
                child: Icon(
                  LucideIcons.shield,
                  color: context.primary,
                  size: 56,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(AppStrings.scanQrCodeWith2faApp.tr()),
            const SizedBox(height: 24.0),
            TextField(
              decoration: InputDecoration(
                labelText: AppStrings.verificationCode.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _twoFactorEnabled = false;
              });
            },
            child: Text(AppStrings.cancel.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.twoFactorAuthEnabled.tr()),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text(AppStrings.verify.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.passwordSecurity.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SecurityStatusCard(),
            const SizedBox(height: 24.0),
            const ChangePasswordTile(),
            const SizedBox(height: 24.0),
            const _SectionHeader(title: AppStrings.twoFactorAuthentication),
            AppTile(
              title: Text(AppStrings.twoFactorAuth.tr()),
              leading: Icon(LucideIcons.shield, color: context.primary),
              trailing: Switch(
                value: _twoFactorEnabled,
                onChanged: (value) {
                  setState(() {
                    _twoFactorEnabled = value;
                  });
                  if (value) {
                    _showSetup2FADialog();
                  }
                },
              ),
              onTap: () {
                setState(() {
                  _twoFactorEnabled = !_twoFactorEnabled;
                });
                if (_twoFactorEnabled) {
                  _showSetup2FADialog();
                }
              },
            ),
            const SizedBox(height: 16.0),
            const _SectionHeader(title: AppStrings.deviceSecurity),
            AppTile(
              title: Text(AppStrings.biometricLogin.tr()),
              leading: Icon(LucideIcons.fingerprint, color: context.primary),
              trailing: Switch(
                value: _biometricEnabled,
                onChanged: (value) {
                  setState(() {
                    _biometricEnabled = value;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  _biometricEnabled = !_biometricEnabled;
                });
              },
            ),
            const SizedBox(height: 24.0),
            const _SectionHeader(title: AppStrings.activeSessions),
            _SessionsList(),
          ],
        ).responsiveConstrains(maxWidth: 800.0),
      ),
    );
  }
}

class _SecurityStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Calculate security score (example)
    const int securityScore = 80;

    return MyCard.outline(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(LucideIcons.shieldCheck, color: context.primary, size: 28),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.securityStatus.tr(),
                        style: context.titleMedium?.bold,
                      ),
                      Text(
                        securityScore >= 70 ? AppStrings.goodSecurity.tr() : AppStrings.improveSecurity.tr(),
                        style: context.bodySmall?.copyWith(
                          color: securityScore >= 70 ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.cardColor,
                    border: Border.all(
                      color: securityScore >= 70 ? Colors.green : Colors.orange,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$securityScore%',
                      style: context.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: securityScore >= 70 ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const _SecurityProgressBar(percentage: securityScore),
          ],
        ),
      ),
    );
  }
}

class _SecurityProgressBar extends StatelessWidget {
  final int percentage;

  const _SecurityProgressBar({required this.percentage});

  @override
  Widget build(BuildContext context) {
    Color progressColor = Colors.green;

    if (percentage < 50) {
      progressColor = context.error;
    } else if (percentage < 70) {
      progressColor = Colors.orange;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 8.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.onSurface.withAlpha(25),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            Container(
              height: 8.0,
              width: (MediaQuery.of(context).size.width - 64.0) * percentage / 100,
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
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

class _SessionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define sessions data
    final sessions = [
      {
        'device': 'Chrome - Windows',
        'location': 'San Francisco, CA',
        'time': 'Current session',
        'isCurrent': true,
        'icon': LucideIcons.laptop,
      },
      {
        'device': 'iPhone 14 Pro',
        'location': 'San Francisco, CA',
        'time': '1 hour ago',
        'isCurrent': false,
        'icon': LucideIcons.smartphone,
      },
      {
        'device': 'Safari - MacBook Pro',
        'location': 'San Francisco, CA',
        'time': '2 days ago',
        'isCurrent': false,
        'icon': LucideIcons.laptop,
      },
    ];

    // Create AppTile for each session
    final sessionTiles = sessions.map((session) {
      final bool isCurrent = session['isCurrent'] as bool;
      final String deviceName = session['device'] as String;
      final String location = session['location'] as String;
      final String time = session['time'] as String;
      final IconData icon = session['icon'] as IconData;

      return AppTile(
        leading: Icon(icon, color: context.primary),
        title: Text(deviceName),
        subtitle: Text('$location · $time'),
        trailing: isCurrent
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withAlpha(25),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  AppStrings.current.tr(),
                  style: context.bodySmall?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : TextButton(
                onPressed: () {
                  // Show logout confirmation dialog
                },
                child: Text(
                  AppStrings.terminate.tr(),
                  style: context.bodySmall?.copyWith(
                    color: context.error,
                  ),
                ),
              ),
        onTap: isCurrent
            ? null
            : () {
                // Perhaps show session details
              },
      );
    }).toList();

    // Return the group of tiles
    return AppTileGroup(tiles: sessionTiles);
  }
}
