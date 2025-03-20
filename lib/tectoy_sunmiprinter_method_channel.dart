import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tectoy_sunmiprinter_platform_interface.dart';

/// An implementation of [TectoySunmiprinterPlatform] that uses method channels.
class MethodChannelTectoySunmiprinter extends TectoySunmiprinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tectoy_sunmiprinter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
