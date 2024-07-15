import 'dart:io';

import 'package:bombay_chowpati/Constants/app_constance.dart';
import 'package:bombay_chowpati/Constants/app_utils.dart';
import 'package:bombay_chowpati/Network/services/utils_services/get_package_info_service.dart';
import 'package:bombay_chowpati/Utils/in_app_update_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateAppService {
  Future<void> getStoreVersion({
    required BuildContext context,
  }) async {
    String? storeVersion;
    PackageInfoData? infoData = (await GetPackageInfoService.getInfo());
    String? currentVersion = infoData.version;
    debugPrint('currentVersion :: $currentVersion');
    if (Platform.isAndroid) {
      PlayStoreSearchAPI playStoreSearchAPI = PlayStoreSearchAPI();
      final result = await playStoreSearchAPI.lookupById(infoData.packageName, country: 'IN');

      if (result != null) {
        storeVersion = playStoreSearchAPI.version(result);
        debugPrint('storeVersion :: $storeVersion');

        if (Get.isDialogOpen == false && Utils.isUpdateAvailable(currentVersion: currentVersion, newAPKVersion: storeVersion ?? "1.0.0") && context.mounted) {
          await showUpdateDialog(
            onUpdate: () async {
              launchUrl(AppConstance.playStoreURI);
            },
          );
        }
      }
    } else if (Platform.isIOS) {
      ITunesSearchAPI iTunesSearchAPI = ITunesSearchAPI();
      Map<dynamic, dynamic>? result = await iTunesSearchAPI.lookupByBundleId(AppConstance.iosBundleId, country: 'IN');
      if (result != null) {
        storeVersion = iTunesSearchAPI.version(result);
        debugPrint('storeVersion :: $storeVersion');

        if (Get.isDialogOpen == false && Utils.isUpdateAvailable(currentVersion: currentVersion, newAPKVersion: storeVersion ?? "1.0.0") && context.mounted) {
          await showUpdateDialog(
            onUpdate: () {
              launchUrl(AppConstance.appStoreURI);
            },
          );
        }
      }
    } else {
      storeVersion = null;
    }
  }
}
