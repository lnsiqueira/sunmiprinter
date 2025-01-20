import 'package:flutter_test/flutter_test.dart';
import 'package:tectoy_sunmiprinter/tectoy_sunmiprinter.dart';
import 'package:tectoy_sunmiprinter/tectoy_sunmiprinter_platform_interface.dart';
import 'package:tectoy_sunmiprinter/tectoy_sunmiprinter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTectoySunmiprinterPlatform
    with MockPlatformInterfaceMixin
    implements TectoySunmiprinterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TectoySunmiprinterPlatform initialPlatform = TectoySunmiprinterPlatform.instance;

  test('$MethodChannelTectoySunmiprinter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTectoySunmiprinter>());
  });

  test('getPlatformVersion', () async {
    TectoySunmiprinter tectoySunmiprinterPlugin = TectoySunmiprinter();
    MockTectoySunmiprinterPlatform fakePlatform = MockTectoySunmiprinterPlatform();
    TectoySunmiprinterPlatform.instance = fakePlatform;

    expect(await tectoySunmiprinterPlugin.getPlatformVersion(), '42');
  });
}
