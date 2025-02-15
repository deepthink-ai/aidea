import 'dart:io' show Directory, Platform;
import 'package:askaide/helper/constant.dart';
import 'package:askaide/helper/logger.dart';
import 'package:askaide/helper/platform.dart';
import 'package:path_provider/path_provider.dart';

class PathHelper {
  late final String cachePath;
  late final String documentsPath;
  late final String supportPath;

  init() async {
    try {
      cachePath = (await getApplicationCacheDirectory()).path.replaceAll('\\', '/');
    } catch (e) {
      cachePath = '';
    }

    try {
      documentsPath = (await getApplicationDocumentsDirectory()).path.replaceAll('\\', '/');
    } catch (e) {
      documentsPath = '';
    }

    try {
      supportPath = (await getApplicationSupportDirectory()).path.replaceAll('\\', '/');
    } catch (e) {
      supportPath = '';
    }

    // 确保 .aidea 目录存在
    try {
      Directory(getHomePath).create(recursive: true);
    } catch (e) {
      Logger.instance.e('Create $getHomePath directory failed: $e');
    }
  }

  String get getHomePath {
    if (PlatformTool.isMacOS() || PlatformTool.isLinux()) {
      return '${Platform.environment['HOME'] ?? ''}/$homePathDirName'.replaceAll('\\', '/');
    } else if (PlatformTool.isWindows()) {
      return '${Platform.environment['UserProfile'] ?? ''}/$homePathDirName'.replaceAll('\\', '/');
    } else if (PlatformTool.isAndroid() || PlatformTool.isIOS()) {
      return '$documentsPath/$homePathDirName'.replaceAll('\\', '/');
    }

    return homePathDirName;
  }

  String get getLogfilePath {
    return '$getHomePath/deepthink.log';
  }

  String get getCachePath {
    return getHomePath;
  }

  /// 单例
  static final PathHelper _instance = PathHelper._internal();
  PathHelper._internal();

  factory PathHelper() {
    return _instance;
  }

  Map<String, String> toMap() {
    return {
      'cachePath': cachePath,
      'cachePathReal': getCachePath,
      'documentsPath': documentsPath,
      'supportPath': supportPath,
      'homePath': getHomePath,
      'logfilePath': getLogfilePath,
    };
  }
}
