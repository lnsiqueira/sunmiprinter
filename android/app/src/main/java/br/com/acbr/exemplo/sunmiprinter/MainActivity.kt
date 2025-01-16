package br.com.acbr.exemplo.sunmiprinter

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import br.com.acbr.exemplo.sunmiprinter.SunmiPrinterFlutterPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Adiciona o plugin SunmiPrinterFlutterPlugin
        flutterEngine.plugins.add(SunmiPrinterFlutterPlugin())
    }
}
