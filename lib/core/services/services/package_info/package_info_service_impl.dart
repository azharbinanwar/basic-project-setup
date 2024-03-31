import 'dart:async';

import 'package:basic_project_template/core/services/services/package_info/package_info_service.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@LazySingleton(as: PackageInfoService)
class PackageServiceInfoImpl implements PackageInfoService {
  late PackageInfo _packageInfo;

  @PostConstruct(preResolve: true)
  @override
  Future<void> init() => PackageInfo.fromPlatform().then((value) => _packageInfo = value);

  @override
  String get appName => _packageInfo.appName;

  @override
  String get buildNumber => _packageInfo.buildNumber;

  @override
  String get packageName => _packageInfo.packageName;

  @override
  String get version => _packageInfo.version;

  @override
  String get versionAndBuildNumber => '${_packageInfo.version}+${_packageInfo.buildNumber}';
}
