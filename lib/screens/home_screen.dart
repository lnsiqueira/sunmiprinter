import 'package:demosunmiprinter/sunmiprinterplugin.dart';
import 'package:demosunmiprinter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/sunmiprinterstate.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final sunmiPrinterPlugin = SunmiPrinterPlugin();

    void onClickButtonImprimirCodigoDeBarras() async {
      await sunmiPrinterPlugin.printBarCode("1234567890", 8, 100, 2, 1);
      await sunmiPrinterPlugin.cutPaper();
    }

    void onClickButtonImprimirTeste() async {
      await sunmiPrinterPlugin.setFontSize(10.0);
      await sunmiPrinterPlugin.printText("Texto com fonte de tamanho 10\n");
      await sunmiPrinterPlugin.setFontSize(20.0);
      await sunmiPrinterPlugin.printText("Texto com fonte de tamanho 20\n");
      await sunmiPrinterPlugin.setFontSize(30.0);
      await sunmiPrinterPlugin.printText("Texto com fonte de tamanho 30\n");

      await sunmiPrinterPlugin.setAlignment(1);
      await sunmiPrinterPlugin.printText("Texto centralizado\n");
      await sunmiPrinterPlugin.setAlignment(2);
      await sunmiPrinterPlugin.printText("Texto alinhado à direita\n");
      await sunmiPrinterPlugin.setAlignment(0);
      await sunmiPrinterPlugin.printText("Texto alinhado à esquerda\n");
      await sunmiPrinterPlugin.cutPaper();


    }

    void onClickButtonImprimirQrCode() async {
      String qrCode =
          "Projeto ACBr Consultoria S.A\n" + "https://www.projetoacbr.com.br";
      await sunmiPrinterPlugin.printQRCode(qrCode, 8, 1);
      await sunmiPrinterPlugin.cutPaper();
    }

    void onClickButtonImprimirImagem() async {
      //obs: a imagem deve ser um arquivo bmp
      final data = await rootBundle.load('assets/images/logo.bmp');
      await sunmiPrinterPlugin.printText("Exemplo de impressão de imagem\n");
      await sunmiPrinterPlugin.printBitmap(data.buffer.asUint8List());
      await sunmiPrinterPlugin.printText("\n");
      await sunmiPrinterPlugin.cutPaper();
    }

    void onClickButtonEstadoImpressora() async {
      final estadoImpressora = await sunmiPrinterPlugin.getPrinterState();
      String mensagem = "";

      switch (estadoImpressora) {
        case SunmiPrinterState.OK:
          mensagem = "Impressora OK";
          break;
        case SunmiPrinterState.INITIALIZING:
          mensagem = "Inicializando impressora";
          break;
        case SunmiPrinterState.ERROR:
          mensagem = "Erro na impressora";
          break;
        case SunmiPrinterState.OUTOFPAPER:
          mensagem = "Sem papel";
          break;
        case SunmiPrinterState.OVERHEATED:
          mensagem = "Impressora superaquecida";
          break;
        case SunmiPrinterState.COVERISOPEN:
          mensagem = "Tampa aberta";
          break;
        case SunmiPrinterState.CUTTERABNORMAL:
          mensagem = "Cortador anormal";
          break;
        case SunmiPrinterState.CUTTERNORMAL:
          mensagem = "Cortador normal";
          break;
        case SunmiPrinterState.BLACKMARKNOTFOUND:
          mensagem = "Marcador preto não encontrado";
          break;
        case SunmiPrinterState.PRINTERNOTDETECTED:
          mensagem = "Impressora não detectada";
          break;
      }
      Fluttertoast.showToast(
          msg: mensagem,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Imprimir Teste"),
            CustomButton(
              onPressed: onClickButtonImprimirTeste,
              icon: Icon(Icons.print),
            ),
            Text("Imprimir QrCode"),
            CustomButton(
                onPressed: onClickButtonImprimirQrCode,
                icon: Icon(Icons.qr_code)),
            Text("Imprimir Código de Barras"),
            CustomButton(
                onPressed: onClickButtonImprimirCodigoDeBarras,
                icon: Icon(MdiIcons.barcode)),
            Text("Imprimir Imagem"),
            CustomButton(
                onPressed: onClickButtonImprimirImagem,
                icon: Icon(Icons.image)),
            Text("Estado da impressora"),
            CustomButton(
                onPressed: onClickButtonEstadoImpressora,
                icon: Icon(Icons.print)),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
