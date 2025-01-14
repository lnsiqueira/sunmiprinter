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

    void onClickButtonImprimirTeste() async {
      await sunmiPrinterPlugin.printTeste();
      await sunmiPrinterPlugin.cutPaper();
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            CustomButton(
              text: "Imprimir Teste",
              onPressed: onClickButtonImprimirTeste,
            ),

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}