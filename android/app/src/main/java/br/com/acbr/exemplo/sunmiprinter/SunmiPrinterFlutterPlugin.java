package br.com.acbr.exemplo.sunmiprinter;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

import com.tectoy.sunmiprinter.SunmiPrinter;


public class SunmiPrinterFlutterPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {

    private Context context;
    private SunmiPrinter sunmiPrinter;

    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        context = binding.getApplicationContext();
        sunmiPrinter = new SunmiPrinter(context);
        channel = new MethodChannel(binding.getBinaryMessenger(), "br.com.acbr.exemplo.sunmiprinterplugin");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "PrintTeste":
                handlePrintTeste(result);
                break;
            case "getServiceVersion":
                handleGetServiceVersion(result);
                break;
            case "printerInit":
                handlePrinterInit(result);
                break;
            case "printerSelfChecking":
                handlePrinterSelfChecking(result);
                break;
            case "getPrinterSerialNo":
                handleGetPrinterSerialNo(result);
                break;
            case "getPrinterVersion":
                handleGetPrinterVersion(result);
                break;
            case "getPrinterModal":
                handleGetPrinterModal(result);
                break;
            case "getPrintedLength":
                handleGetPrintedLength(result);
                break;
            case "cutPaper":
                handleCutPaper(result);
                break;
            case "lineWrap":
                handleLineWrap(call, result);
                break;

            case "sendRawData":
                handleSendRawData(call, result);
                break;
            case "setAlignment":
                handleSetAlignment(call, result);
                break;
            case "setFontName":
                handleSetFontName(call, result);
                break;

            case "getCutPaperTimes":
                handleGetCutPaperTimes(result);
                break;

            case "setFontSize":
                handleSetFontSize(call, result);
                break;
            case "printText":
                handleSetPrintText(call, result);
                break;

            case "printTextLF":
                handleSetPrintTextLF(call, result);
                break;
            case "printTextWithFont":
                handleSetPrintTextWithFont(call, result);
                break;

            case "printColumnsText":
                handlePrintColumnsText(call, result);
                break;

            case "printBitmap":
                handlePrintBitmap(call, result);
                break;

            case "printBarCode":
                handlePrintBarCode(call, result);
                break;

            case "printQRCode":
                handlePrintQRCode(call, result);
                break;

            case "printOriginalText":
                handlePrintOriginalText(call, result);
                break;

            case "commitPrinterBuffer":
                handleCommitPrinterBuffer(result);
                break;

            case "enterPrinterBuffer":
                handleEnterPrinterBuffer(call, result);
                break;

            case "exitPrinterBuffer":
                handleExitPrinterBuffer(call, result);
                break;

            case "openDrawer":
                handleOpenDrawer(result);
                break;

            case "getOpenDrawerTimes":
                handleGetOpenDrawerTimes(result);
                break;


            case "getPrinterMode":
                handleGetPrinterMode(result);
                break;

            case "getPrinterBBMDistance":
                handleGetPrinterBBMDistance(result);
                break;

            default:
                result.notImplemented();
                break;
        }
    }

    private void handleGetPrinterBBMDistance(MethodChannel.Result result) {
        try {
            int distance = sunmiPrinter.getPrinterBBMDistance();
            result.success(distance);
        } catch (Exception e) {
            result.error("Erro ao obter o status mais recente da impressora", e.getMessage(), e);
        }
    }

    private void handleGetPrinterMode(MethodChannel.Result result) {
        try {
            int mode = sunmiPrinter.getPrinterMode();
            result.success(mode);
        } catch (Exception e) {
            result.error("Erro ao obter modo da impressora", e.getMessage(), e);
        }
    }

    private void handleGetOpenDrawerTimes(MethodChannel.Result result) {
        try {
            sunmiPrinter.getOpenDrawerTimes();
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao quantas vez a gaveta foi aberta", e.getMessage(), e);
        }
    }

    private void handleOpenDrawer(MethodChannel.Result result) {
        try {
            sunmiPrinter.openDrawer();
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao abrir gaveta", e.getMessage(), e);
        }
    }

    private void handleExitPrinterBuffer(MethodCall call, MethodChannel.Result result) {
        try {
            boolean commit = call.argument("commit");
            sunmiPrinter.exitPrinterBuffer(commit);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao sair do modo transação de buffer", e.getMessage(), e);
        }
    }

    private void handleEnterPrinterBuffer(MethodCall call, MethodChannel.Result result) {
        try {
            boolean clean = call.argument("clean");
            sunmiPrinter.enterPrinterBuffer(clean);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao entrar em modo transação de buffer", e.getMessage(), e);
        }
    }


    private void handleCommitPrinterBuffer(MethodChannel.Result result) {
        try {
            sunmiPrinter.commitPrinterBuffer();
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao commitar buffer", e.getMessage(), e);
        }
    }

    private void handlePrintOriginalText(MethodCall call, MethodChannel.Result result) {
        try {
            String text = call.argument("text");
            sunmiPrinter.printOriginalText(text);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao imprimir texto original", e.getMessage(), e);
        }
    }

    private void handlePrintQRCode(MethodCall call, MethodChannel.Result result) {
        try {
            String data = call.argument("data");
            int modulesize = call.argument("modulesize");
            int errorlevel = call.argument("errorlevel");
            sunmiPrinter.printQRCode(data, modulesize, errorlevel);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao imprimir QRCode", e.getMessage(), e);
        }
    }

    private void handlePrintBarCode(MethodCall call, MethodChannel.Result result) {
        try {
            String data = call.argument("data");
            int symbology = call.argument("symbology");
            int height = call.argument("height");
            int width = call.argument("width");
            int textposition = call.argument("textposition");
            sunmiPrinter.printBarCode(data, symbology, height, width, textposition);
            result.success(true);

        } catch (Exception e) {
            result.error("Erro ao imprimir código de barras", e.getMessage(), e);
        }
    }

    private void handlePrintBitmap(MethodCall call, MethodChannel.Result result) {
        try {
            byte[] bitMapData = call.argument("bitmap");
            Bitmap bitmap = BitmapFactory.decodeByteArray(bitMapData, 0, bitMapData.length);
            sunmiPrinter.printBitmap(bitmap);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao imprimir bitmap", e.getMessage(), e);
        }
    }

    private void handlePrintColumnsText(MethodCall call, MethodChannel.Result result) {
        try {
            String[] columnsText = call.argument("colsTextArr");
            int[] colsWidthArr = call.argument("colsWidthArr");
            int[] colsAlign = call.argument("colsAlign");
            sunmiPrinter.printColumnsText(columnsText, colsWidthArr, colsAlign);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao imprimir texto em colunas", e.getMessage(), e);
        }
    }

    private void handleSetPrintTextWithFont(MethodCall call, MethodChannel.Result result) {
        try {
            String text = call.argument("text");
            float fontSize = call.argument("fontSize");
            String typeface = call.argument("typeface");
            sunmiPrinter.printTextWithFont(text, typeface, fontSize);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao imprimir texto com fonte", e.getMessage(), e);
        }
    }

    private void handleSetPrintTextLF(MethodCall call, MethodChannel.Result result) {
        try {
            String text = call.argument("text");
            sunmiPrinter.printTextLF(text);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao imprimir texto", e.getMessage(), e);
        }
    }

    private void handleSetPrintText(MethodCall call, MethodChannel.Result result) {
        try {
            String text = call.argument("text");
            sunmiPrinter.printText(text);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao imprimir texto", e.getMessage(), e);
        }
    }

    private void handleSetFontSize(MethodCall call, MethodChannel.Result result) {
        try {
            int fontSize = call.argument("fontSize");
            sunmiPrinter.setFontSize(fontSize);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao setar tamanho da fonte", e.getMessage(), e);
        }
    }

    private void handleSetAlignment(MethodCall call, MethodChannel.Result result) {
        try {
            int alignment = call.argument("alignment");
            sunmiPrinter.setAlignment(alignment);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao alinhar texto", e.getMessage(), e);
        }
    }

    private void handleSendRawData(MethodCall call, MethodChannel.Result result) {
        try {
            byte[] data = call.argument("data");
            sunmiPrinter.sendRAWData(data);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao enviar dados", e.getMessage(), e);
        }
    }

    private void handleLineWrap(MethodCall call, MethodChannel.Result result) {
        try {
            int lines = call.argument("numLines");
            sunmiPrinter.lineWrap(lines);
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao pular linha", e.getMessage(), e);
        }
    }

    private void handleCutPaper(MethodChannel.Result result) {
        try {
            sunmiPrinter.cutPaper();
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao cortar papel", e.getMessage(), e);
        }
    }

    private void handlePrintTeste(@NonNull MethodChannel.Result result) {
        try {
            sunmiPrinter.PrintTeste();
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao imprimir", e.getMessage(), e);
        }
    }

    private void handleGetServiceVersion(@NonNull MethodChannel.Result result) {
        try {
            String version = sunmiPrinter.getServiceVersion();
            result.success(version);
        } catch (Exception e) {
            result.error("Erro ao obter versão do serviço", e.getMessage(), e);
        }
    }

    private void handlePrinterInit(@NonNull MethodChannel.Result result) {
        try {
            sunmiPrinter.printerInit();
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao inicializar impressora", e.getMessage(), e);
        }
    }

    private void handlePrinterSelfChecking(@NonNull MethodChannel.Result result) {
        try {
            sunmiPrinter.printerSelfChecking();
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao verificar impressora", e.getMessage(), e);
        }
    }

    private void handleGetPrinterSerialNo(@NonNull MethodChannel.Result result) {
        try {
            String serialNo = sunmiPrinter.getPrinterSerialNo();
            result.success(serialNo);
        } catch (Exception e) {
            result.error("Erro ao obter serial da impressora", e.getMessage(), e);
        }
    }

    private void handleGetPrinterVersion(@NonNull MethodChannel.Result result) {
        try {
            String version = sunmiPrinter.getPrinterVersion();
            result.success(version);
        } catch (Exception e) {
            result.error("Erro ao obter versão da impressora", e.getMessage(), e);
        }
    }

    private void handleGetPrinterModal(@NonNull MethodChannel.Result result) {
        try {
            String modal = sunmiPrinter.getPrinterModal();
            result.success(modal);
        } catch (Exception e) {
            result.error("Erro ao obter modal da impressora", e.getMessage(), e);
        }
    }

    private void handleGetPrintedLength(@NonNull MethodChannel.Result result) {
        try {
            sunmiPrinter.getPrintedLength();
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao obter tamanho impresso", e.getMessage(), e);
        }
    }

    private void handleGetCutPaperTimes(@NonNull MethodChannel.Result result) {
        try {
            sunmiPrinter.getCutPaperTimes();
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao obter cortes de papel", e.getMessage(), e);
        }
    }

    private void handleSetFontName(MethodCall call, @NonNull MethodChannel.Result result) {
        try {
            sunmiPrinter.setFontName(call.argument("typeface"));
            result.success(true);
        } catch (Exception e) {
            result.error("Erro ao setar fonte", e.getMessage(), e);
        }
    }

}
