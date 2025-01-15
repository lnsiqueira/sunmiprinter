import 'dart:ffi';
import 'dart:ui';
import 'package:demosunmiprinter/utils/sunmiprinterstate.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;
class SunmiPrinterPlugin {

  static const MethodChannel _channel = MethodChannel('br.com.acbr.exemplo.sunmiprinterplugin');

  static const int SUNMI_PRINTERSTATUS_OK = 1;
  static const int SUNMI_PRINTERSTATUS_INITIALIZING = 2;
  static const int SUNMI_PRINTERSTATUS_ERROR = 3;
  static const int SUNMI_PRINTERSTATUS_OUT_OF_PAPER = 4;
  static const int SUNMI_PRINTERSTATUS_OVERHEATED = 5;
  static const int SUNMI_PRINTERSTATUS_COVER_IS_OPEN = 6;
  static const int SUNMI_PRINTERSTATUS_CUTTER_ABNORMAL = 7;
  static const int SUNMI_PRINTERSTATUS_CUTTER_NORMAL = 8;
  static const int SUNMI_PRINTERSTATUS_BLACK_MARK_NOT_FOUND = 9;
  static const int SUNMI_PRINTERSTATUS_PRINTER_NOT_DETECTED = 505;

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
      await _channel.invokeMethod('lineWrap', {"numLines":numLines });
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
      await _channel.invokeMethod('setAlignment', {"alignment":alignment });
    } on PlatformException catch (e) {
      throw 'Erro ao configurar o alinhamento: ${e.message}';
    }
  }

  Future<void>setFontName(String typeface) async {
    try {
      await _channel.invokeMethod('setFontName', {"typeface":typeface });
    } on PlatformException catch (e) {
      throw 'Erro ao configurar o nome da fonte: ${e.message}';
    }
  }

  Future<void> setFontSize(double fontSize) async {
    try {
      await _channel.invokeMethod('setFontSize', {"fontSize":fontSize });
    } on PlatformException catch (e) {
      throw 'Erro ao configurar o tamanho da fonte: ${e.message}';
    }
  }

  Future<void> printText(String text) async {
    try {
      await _channel.invokeMethod('printText', {"text":text });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir texto: ${e.message}';
    }
  }

  Future<void> printTextLF(String text) async {
    try {
      await _channel.invokeMethod('printTextLF', {"text":text });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir texto com LF: ${e.message}';
    }
  }

  Future<void> printTextWithFont(String text, String typeface, double fontSize) async {
    try {
      await _channel.invokeMethod('printTextWithFont', {"text":text, "typeface":typeface, "fontSize":fontSize });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir texto com fonte: ${e.message}';
    }
  }



  Future<void> printColumnsText(List<String> colsTextArr, List<int> colsWidthArr, List<int> colsAlign) async {
    try {
      await _channel.invokeMethod('printColumnsText', {"colsTextArr":colsTextArr, "colsWidthArr":colsWidthArr, "colsAlign":colsAlign });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir colunas de texto: ${e.message}';
    }
  }

 Future<void>printBitmap(Uint8List bitmap) async{
  try {
      await _channel.invokeMethod('printBitmap', {"bitmap":bitmap });
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
      await _channel.invokeMethod('printBarCode',{ "data":data, "symbology":symbology, "height":height, "width":width, "textposition":textPosition });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir código de barras: ${e.message}';
    }
  }

  Future<void>printQRCode(String data, int moduleSize, int errorLevel) async {
    try {
      await _channel.invokeMethod('printQRCode', {"data":data, "modulesize":moduleSize, "errorlevel":errorLevel });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir código QR: ${e.message}';
    }
  }

  Future<void>printOriginalText(String text) async {
    try {
      await _channel.invokeMethod('printOriginalText', {"text":text });
    } on PlatformException catch (e) {
      throw 'Erro ao imprimir texto original: ${e.message}';
    }
  }

  Future<void>commitPrinterBuffer() async {
    try {
      await _channel.invokeMethod('commitPrinterBuffer');
    } on PlatformException catch (e) {
      throw 'Erro ao confirmar o buffer da impressora: ${e.message}';
    }
  }

  Future<void>enterPrinterBuffer(bool clean) async {
    try {
      await _channel.invokeMethod('enterPrinterBuffer', {"clean":clean });
    } on PlatformException catch (e) {
      throw 'Erro ao entrar no buffer da impressora: ${e.message}';
    }
  }

  Future<void>exitPrinterBuffer(bool commit) async {
    try {
      await _channel.invokeMethod('exitPrinterBuffer', {"commit":commit });
    } on PlatformException catch (e) {
      throw 'Erro ao sair do buffer da impressora: ${e.message}';
    }
  }

  Future<void>openDrawer() async {
    try {
      await _channel.invokeMethod('openDrawer');
    } on PlatformException catch (e) {
      throw 'Erro ao abrir a gaveta: ${e.message}';
    }
  }

  Future<int>getOpenDrawerTimes() async {
    try {
      final int openDrawerTimes = await _channel.invokeMethod('getOpenDrawerTimes');
      return openDrawerTimes;
    } on PlatformException catch (e) {
      throw 'Erro ao obter o número de vezes que a gaveta foi aberta: ${e.message}';
    }
  }

  Future<int>getPrinterMode() async {
    try {
      final int printerMode = await _channel.invokeMethod('getPrinterMode');
      return printerMode;
    } on PlatformException catch (e) {
      throw 'Erro ao obter o modo da impressora: ${e.message}';
    }
  }

  Future<int>getPrinterBBMDistance() async {
    try {
      final int printerBBMDistance = await _channel.invokeMethod('getPrinterBBMDistance');
      return printerBBMDistance;
    } on PlatformException catch (e) {
      throw 'Erro ao obter o status mais recente da impressora: ${e.message}';
    }
  }

  Future<int>updatePrinterState() async {
    try {
      final int printerState = await _channel.invokeMethod('updatePrinterState');
      return printerState;
    } on PlatformException catch (e) {
      throw 'Erro ao atualizar o estado da impressora: ${e.message}';
    }
  }

  Future<bool>getDrawerStatus() async {
    try {
      final bool drawerStatus = await _channel.invokeMethod('getDrawerStatus');
      return drawerStatus;
    } on PlatformException catch (e) {
      throw 'Erro ao obter o status da gaveta: ${e.message}';
    }
  }

  Future<SunmiPrinterState> getPrinterState() async {
    try {
      final int printerState = await updatePrinterState() as int;
      SunmiPrinterState state;
      switch (printerState) {
        case SUNMI_PRINTERSTATUS_OK:
          state = SunmiPrinterState.OK;
          break;
        case SUNMI_PRINTERSTATUS_INITIALIZING:
          state = SunmiPrinterState.INITIALIZING;
          break;
        case SUNMI_PRINTERSTATUS_ERROR:
          state = SunmiPrinterState.ERROR;
          break;
        case SUNMI_PRINTERSTATUS_OUT_OF_PAPER:
          state = SunmiPrinterState.OUTOFPAPER;
          break;
        case SUNMI_PRINTERSTATUS_OVERHEATED:
          state = SunmiPrinterState.OVERHEATED;
          break;
        case SUNMI_PRINTERSTATUS_COVER_IS_OPEN:
          state = SunmiPrinterState.COVERISOPEN;
          break;
        case SUNMI_PRINTERSTATUS_CUTTER_ABNORMAL:
          state = SunmiPrinterState.CUTTERABNORMAL;
          break;
        case SUNMI_PRINTERSTATUS_CUTTER_NORMAL:
          state = SunmiPrinterState.CUTTERNORMAL;
          break;
        case SUNMI_PRINTERSTATUS_BLACK_MARK_NOT_FOUND:
          state = SunmiPrinterState.BLACKMARKNOTFOUND;
          break;
        case SUNMI_PRINTERSTATUS_PRINTER_NOT_DETECTED:
          state = SunmiPrinterState.PRINTERNOTDETECTED;
          break;
        default:
          state = SunmiPrinterState.ERROR;
          break;
      }
      return state;
    } on PlatformException catch (e) {
      throw 'Erro ao obter o estado da impressora: ${e.message}';
    }
  }
}