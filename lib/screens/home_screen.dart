import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tectoy_sunmiprinter/tectoy_sunmiprinter.dart';
import 'package:tectoy_sunmiprinter/utils/sunmiprinterstate.dart';

import '../widgets/button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/**
 * Classe que implementa a tela principal do aplicativo
 */

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final sunmiPrinterPlugin = TectoySunmiprinter();

    /* Funções auxiliares para obter informações da impressora*/

    /**
     * Retorna uma mensagem de acordo com o estado da impressora
     */

    String buildMensagemDeEstadoDaImpressora( SunmiPrinterState estadoImpressora) {
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
          mensagem = "Impressora com tampa aberta";
          break;
        case SunmiPrinterState.CUTTERABNORMAL:
          mensagem = "Impressora com erro no cortador";
          break;
        case SunmiPrinterState.CUTTERNORMAL:
          mensagem = "Impressora com recuo no cortador";
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

    /**
     * Imprime informações da impressora Sunmi
     */
    void imprimeInformacoesDaSunmiPrinter() async {
      final modal = await sunmiPrinterPlugin.getPrinterModal();
      final serviceVersion = await sunmiPrinterPlugin.getServiceVersion();
      final basicSunmiPrintInfo =
          "modal:" + modal + "service version: " + serviceVersion + "\n";
      await sunmiPrinterPlugin.printText(basicSunmiPrintInfo);
    }

    /* Funções onClick de botões*/

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
      imprimeInformacoesDaSunmiPrinter();
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

    // Matriz com widgets de botões e labels
    final List<List<Widget>> widgetGroup = [
      [
        Button(
            onPressed: onClickButtonImprimirTeste,
            icon: Icon(Icons.text_snippet)),
        Button(
            onPressed: onClickButtonImprimirQrCode, icon: Icon(Icons.qr_code)),
        Button(
            onPressed: onClickButtonImprimirCodigoDeBarras,
            icon: Icon(MdiIcons.barcode)),
      ],
      [
        Text("Imprimir Teste"),
        Text("Imprimir QrCode"),
        Text("Código de Barras"),
      ],
      [
        Button(
            onPressed: onClickButtonPularLinha,
            icon: Icon(Icons.arrow_downward)),
        Button(onPressed: onClickButtonImprimirImagem, icon: Icon(Icons.image)),
        Button(onPressed: onClickButtonCortarPapel, icon: Icon(Icons.cut)),
      ],
      [Text("Saltar linha"), Text("Imprimir Imagem"), Text("Cortar papel")],
    ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: widgetGroup.map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 5,
                    children: row,
                  );
                }).toList()) // This trailing comma makes auto-formatting nicer for build methods.
            ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: onClickButtonEstadoImpressora,
            child: Icon(Icons.info,
                color: Theme.of(context).colorScheme.onPrimary)));
  }
}
