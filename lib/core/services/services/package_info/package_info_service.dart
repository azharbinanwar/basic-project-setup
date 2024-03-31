import 'dart:async';

abstract class PackageInfoService {
  FutureOr<void> init();

  String get appName;

  String get packageName;

  String get version;

  String get buildNumber;

  String get versionAndBuildNumber;
}
