import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tectoy_sunmiprinter_method_channel.dart';

abstract class TectoySunmiprinterPlatform extends PlatformInterface {
  /// Constructs a TectoySunmiprinterPlatform.
  TectoySunmiprinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static TectoySunmiprinterPlatform _instance = MethodChannelTectoySunmiprinter();

  /// The default instance of [TectoySunmiprinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelTectoySunmiprinter].
  static TectoySunmiprinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TectoySunmiprinterPlatform] when
  /// they register themselves.
  static set instance(TectoySunmiprinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
