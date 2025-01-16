import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:demosunmiprinter/sunmiprinterplugin.dart';
import 'package:demosunmiprinter/widgets/button.dart';
import 'package:demosunmiprinter/utils/sunmiprinterstate.dart';

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

    String buildMensagemDeEstadoDaImpressora(
        SunmiPrinterState estadoImpressora) {
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
      return mensagem;
    }

    void onClickButtonImprimirCodigoDeBarras() async {
      await sunmiPrinterPlugin.printBarCode("1234567890", 8, 100, 2, 1);
    }

    void onClickButtonImprimirTeste() async {
      await sunmiPrinterPlugin.setFontSize(15.0);
      await sunmiPrinterPlugin.printTextLF("Texto com fonte de tamanho 15");
      await sunmiPrinterPlugin.setFontSize(20.0);
      await sunmiPrinterPlugin.printTextLF("Texto com fonte de tamanho 20");
      await sunmiPrinterPlugin.setFontSize(30.0);
      await sunmiPrinterPlugin.printTextLF("Texto com fonte de tamanho 30");

      await sunmiPrinterPlugin.setFontSize(20.0);

      await sunmiPrinterPlugin.setAlignment(1);
      await sunmiPrinterPlugin.printTextLF("Texto centralizado");
      await sunmiPrinterPlugin.setAlignment(2);
      await sunmiPrinterPlugin.printTextLF("Texto alinhado à direita");
      await sunmiPrinterPlugin.setAlignment(0);
      await sunmiPrinterPlugin.printTextLF("Texto alinhado à esquerda");
      await sunmiPrinterPlugin.printText("Pulei uma linha");
      await sunmiPrinterPlugin.lineWrap(1);

      await sunmiPrinterPlugin.setFontSize(20.0);
      await sunmiPrinterPlugin.printText("Texto sem quebra de linha ");
      await sunmiPrinterPlugin.printText("Outro texto sem quebra de linha\n\n");
    }

    void onClickButtonImprimirQrCode() async {
      String qrCode =
          "Projeto ACBr Consultoria S.A\n" + "https://www.projetoacbr.com.br";
      await sunmiPrinterPlugin.printQRCode(qrCode, 8, 1);
    }

    void onClickButtonImprimirImagem() async {
      //obs: a imagem deve ser um arquivo bmp
      final data = await rootBundle.load('assets/images/logo.bmp');
      await sunmiPrinterPlugin.printText("Exemplo de impressão de imagem\n");
      await sunmiPrinterPlugin.printBitmap(data.buffer.asUint8List());
      await sunmiPrinterPlugin.printText("\n");
    }

    void onClickButtonEstadoImpressora() async {
      final estadoImpressora = await sunmiPrinterPlugin.getPrinterState();
      String mensagem = "";

      if (estadoImpressora != null) {
        mensagem = buildMensagemDeEstadoDaImpressora(estadoImpressora);
      } else {
        mensagem = "Erro ao obter o estado da impressora";
      }
      Fluttertoast.showToast(
          msg: mensagem,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
    }

    void onClickButtonCortarPapel() async {
      await sunmiPrinterPlugin.cutPaper();
    }

    void onClickButtonPularLinha() async {
      await sunmiPrinterPlugin.lineWrap(1);
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
            Button(
              onPressed: onClickButtonImprimirTeste,
              icon: Icon(Icons.print),
            ),
            Text("Imprimir QrCode"),
            Button(
                onPressed: onClickButtonImprimirQrCode,
                icon: Icon(Icons.qr_code)),
            Text("Imprimir Código de Barras"),
            Button(
                onPressed: onClickButtonImprimirCodigoDeBarras,
                icon: Icon(MdiIcons.barcode)),
            Text("Imprimir Imagem"),
            Button(
                onPressed: onClickButtonImprimirImagem,
                icon: Icon(Icons.image)),
            Text("Pular linha"),
            Button(
                onPressed: onClickButtonPularLinha,
                icon: Icon(Icons.arrow_downward)),
            Text("Cortar papel"),
            Button(
                onPressed: onClickButtonCortarPapel,
                icon: Icon(Icons.cut)),


            Text("Estado da impressora"),
            Button(
                onPressed: onClickButtonEstadoImpressora,
                icon: Icon(Icons.print)),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
