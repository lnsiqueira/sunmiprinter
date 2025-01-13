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
      throw 'Erro ao obter o modelo da impressora: ${e.message}';
    }
  }

  Future<void> getPrintedLength() async {
    try {
      await _channel.invokeMethod('getPrintedLength');
    } on PlatformException catch (e) {
      throw 'Erro ao obter o comprimento impresso: ${e.message}';
    }
  }

  Future<void>cutPaper() async {
    try {
      await _channel.invokeMethod('cutPaper');
    } on PlatformException catch (e) {
      throw  'Erro ao cortar papel: ${e.message}';
    }
  }

  Future <void>lineWrap(int numLines) async {
    try {
      await _channel.invokeMethod('lineWrap', {"numLines",numLines });
    } on PlatformException catch (e) {
      throw 'Erro ao saltar linhas: ${e.message}';
    }
  }

  Future<void>sendRAWData(Uint8List data) async {
    try {
      await _channel.invokeMethod('sendRAWData', data);
    } on PlatformException catch (e) {
      throw 'Erro ao enviar  array de dados: ${e.message}';
    }
  }

  Future<void>setAlignment(int alignment) async {
    try {
      await _channel.invokeMethod('setAlignment', {"alignment",alignment });
    } on PlatformException catch (e) {
      throw 'Erro ao configurar o alinhamento: ${e.message}';
    }
  }

  Future<void>setFontName(String typeface) async {
    try {
      await _channel.invokeMethod('setFontName', {"typeface",typeface });
    } on PlatformException catch (e) {
      throw 'Erro ao configurar o nome da fonte: ${e.message}';
    }
  }

  Future<void> setFontSize(Float fontSize) async {
    try {
      await _channel.invokeMethod('setFontSize', {"fontSize",fontSize });
    } on PlatformException catch (e) {
      throw 'Erro ao configurar o tamanho da fonte: ${e.message}';
    }
  }

  Future<void> printText(String text) async {
    try {
      await _channel.invokeMethod('printText', {"text",text });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir texto: ${e.message}';
    }
  }

  Future<void> printTextLF(String text) async {
    try {
      await _channel.invokeMethod('printTextLF', {"text",text });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir texto com LF: ${e.message}';
    }
  }

  Future<void> printTextWithFont(String text, String typeface, Float fontSize) async {
    try {
      await _channel.invokeMethod('printTextWithFont', {"text",text, "typeface",typeface, "fontSize",fontSize });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir texto com fonte: ${e.message}';
    }
  }


  
  Future<void> printColumnsText(List<String> colsTextArr, List<int> colsWidthArr, List<int> colsAlign) async {
    try {
      await _channel.invokeMethod('printColumnsText', {"colsTextArr",colsTextArr, "colsWidthArr",colsWidthArr, "colsAlign",colsAlign });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir colunas de texto: ${e.message}';
    }
  }

 Future<void>printBitmap(Uint8List bitmap) async{
  try {
      await _channel.invokeMethod('printBitmap', {"bitmap",bitmap });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir bitmap: ${e.message}';
    }
  }
  Future<int> getCutPaperTimes() async {
    try {
      final int cutPaperTimes = await _channel.invokeMethod('getCutPaperTimes');
      return cutPaperTimes;
    } on PlatformException catch (e) {
      throw 'Error getting cut paper times: ${e.message}';
    }
  }

  Future<void>printBarCode(String data, int symbology, int height, int width, int textPosition) async {
    try {
      await _channel.invokeMethod('printBarCode', {"data",data, "symbology",symbology, "height",height, "width",width, "textPosition",textPosition });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir código de barras: ${e.message}';
    }
  }

  Future<void>printQRCode(String data, int moduleSize, int errorLevel) async {
    try {
      await _channel.invokeMethod('printQRCode', {"data",data, "moduleSize",moduleSize, "errorLevel",errorLevel });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir código QR: ${e.message}';
    }
  }
}