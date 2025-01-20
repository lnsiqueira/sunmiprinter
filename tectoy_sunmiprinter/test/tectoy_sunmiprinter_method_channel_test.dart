import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tectoy_sunmiprinter/tectoy_sunmiprinter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelTectoySunmiprinter platform = MethodChannelTectoySunmiprinter();
  const MethodChannel channel = MethodChannel('tectoy_sunmiprinter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
