package com.order.bombaychowpati

import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

@Suppress("DEPRECATION")
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            when (call.method) {
                "getPackageInfo" -> {
                    try {
                        val packageInfo = this.packageManager.getPackageInfo(this.packageName, 0)
                        val installerPackage = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                            this.packageManager.getInstallSourceInfo(this.packageName).initiatingPackageName
                        } else {
                            this.packageManager.getInstallerPackageName(this.packageName)
                        }
                        val infoMap = HashMap<String, String?>()
                        infoMap["appName"] = packageInfo.applicationInfo.loadLabel(this.packageManager).toString()
                        infoMap["packageName"] = packageInfo.packageName
                        infoMap["version"] = packageInfo.versionName
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                            infoMap["buildNumber"] = packageInfo.longVersionCode.toString()
                        } else {
                            infoMap["buildNumber"] = packageInfo.versionCode.toString()
                        }
                        infoMap["installerStore"] = installerPackage
                        Log.d("PackageInfo", "infoMap: $infoMap")
                        result.success(infoMap)
                    } catch (e: PackageManager.NameNotFoundException) {
                        result.success(null)
                        throw RuntimeException(e)
                    }
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    companion object {
        private const val CHANNEL = "AndroidMethodChannel"
    }
}
