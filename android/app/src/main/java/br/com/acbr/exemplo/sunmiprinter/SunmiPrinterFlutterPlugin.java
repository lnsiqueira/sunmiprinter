package br.com.acbr.exemplo.sunmiprinter;

import android.content.Context;

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
            case "getCutPaperTimes":
                handleGetCutPaperTimes(result);
                break;
            default:
                result.notImplemented();
                break;
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

}
