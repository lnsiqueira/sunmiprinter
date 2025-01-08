import 'dart:ffi';

import 'package:flutter/services.dart';

class SunmiPrinterPlugin {
  static const MethodChannel _channel = MethodChannel('br.com.acbr.exemplo.sunmiprinterplugin');

  Future<void> printTeste() async {
    try {
      await _channel.invokeMethod('PrintTeste');
    } on PlatformException catch (e) {
      throw 'Error printing test: ${e.message}';
    }
  }

  Future<String> getServiceVersion() async {
    try {
      final String version = await _channel.invokeMethod('getServiceVersion');
      return version;
    } on PlatformException catch (e) {
      throw 'Error getting service version: ${e.message}';
    }
  }

  Future<void> printerInit() async {
    try {
      await _channel.invokeMethod('printerInit');
    } on PlatformException catch (e) {
      throw 'Error initializing printer: ${e.message}';
    }
  }

  Future<void> printerSelfChecking() async {
    try {
      await _channel.invokeMethod('printerSelfChecking');
    } on PlatformException catch (e) {
      throw 'Error self-checking printer: ${e.message}';
    }
  }

  Future<String> getPrinterSerialNo() async {
    try {
      final String serialNo = await _channel.invokeMethod('getPrinterSerialNo');
      return serialNo;
    } on PlatformException catch (e) {
      throw 'Error getting printer serial number: ${e.message}';
    }
  }

  Future<String> getPrinterVersion() async {
    try {
      final String version = await _channel.invokeMethod('getPrinterVersion');
      return version;
    } on PlatformException catch (e) {
      throw 'Error getting printer version: ${e.message}';
    }
  }

  Future<String> getPrinterModal() async {
    try {
      final String modal = await _channel.invokeMethod('getPrinterModal');
      return modal;
    } on PlatformException catch (e) {
      throw 'Error getting printer modal: ${e.message}';
    }
  }

  Future<void> getPrintedLength() async {
    try {
      await _channel.invokeMethod('getPrintedLength');
    } on PlatformException catch (e) {
      throw 'Error getting printed length: ${e.message}';
    }
  }

  Future<void>cutPaper() async {
    try {
      await _channel.invokeMethod('cutPaper');
    } on PlatformException catch (e) {
      throw 'Error cutting paper: ${e.message}';
    }
  }
}