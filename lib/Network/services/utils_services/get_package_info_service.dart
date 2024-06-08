import 'package:flutter/services.dart';

class GetPackageInfoService extends PackageInfoData {
  static const _platform = MethodChannel('AndroidMethodChannel');

  GetPackageInfoService({
    required super.appName,
    required super.packageName,
    required super.version,
    required super.buildNumber,
    String? installerStore,
  });

  static Future<PackageInfoData> getInfo() async {
    final info = await _platform.invokeMapMethod<String, dynamic>('getPackageInfo');
    GetPackageInfoService instance = GetPackageInfoService(
      appName: info?['appName'] ?? '',
      packageName: info?['packageName'] ?? '',
      version: info?['version'] ?? '',
      buildNumber: info?['buildNumber'] ?? '',
      installerStore: info?['installerStore'] as String?,
    );

    return instance;
  }
}

abstract class PackageInfoData {
  /// Constructs an instance with the given values for testing. [PackageInfoData]
  /// instances constructed this way won't actually reflect any real information
  /// from the platform, just whatever was passed in at construction time.
  PackageInfoData({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
    this.installerStore,
  });

  /// The app name. `CFBundleDisplayName` on iOS, `application/label` on Android.
  final String appName;

  /// The package name. `bundleIdentifier` on iOS, `getPackageName` on Android.
  final String packageName;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  final String version;

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  final String buildNumber;

  /// The installer store. Indicates through which store this application was installed.
  final String? installerStore;
}
