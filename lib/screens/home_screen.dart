import 'package:demosunmiprinter/sunmiprinterplugin.dart';
import 'package:demosunmiprinter/widgets/custom_button.dart';
import 'package:flutter/material.dart';

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
      await sunmiPrinterPlugin.printBarCode("1234567890", 8, 100, 2,1);
      await sunmiPrinterPlugin.cutPaper();
    }

    void onClickButtonImprimirTeste() async {
      await sunmiPrinterPlugin.printTeste();
      await sunmiPrinterPlugin.cutPaper();
    }

    void onClickButtonImprimirQrCode() async {
      String qrCode =
          "Projeto ACBr Consultoria S.A\nhttps://www.projetoacbr.com.br";
      await sunmiPrinterPlugin.printQRCode(qrCode, 8, 1);
      await sunmiPrinterPlugin.cutPaper();
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
            CustomButton(
              text: "Imprimir Teste",
              onPressed: onClickButtonImprimirTeste,
              icon: Icon(Icons.print),
            ),
            CustomButton(
                text: "Imprimir QrCode",
                onPressed: onClickButtonImprimirQrCode,
                icon: Icon(Icons.qr_code)),

            CustomButton(
                text: "Imprimir Código de Barras",
                onPressed: onClickButtonImprimirCodigoDeBarras,
                icon: Icon(Icons.bar_chart)
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
