import 'package:demosunmiprinter/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tectoy_sunmiprinter/tectoy_sunmiprinter.dart';
import 'package:tectoy_sunmiprinter/utils/sunmiprinterstate.dart';

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
      final data2 = await rootBundle.load('assets/images/nfe-logo.bmp');
      try {
        await Future.wait([
          sunmiPrinterPlugin.printText("Exemplo de impressão de imagem\n"),
          sunmiPrinterPlugin.printBitmap(data.buffer.asUint8List()),
          sunmiPrinterPlugin.printBitmap(data2.buffer.asUint8List()),
          sunmiPrinterPlugin.cutPaper()
        ]);
      } catch (e) {
        debugPrint("Erro ao imprimir imagem: $e");
      }
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

    void onClickButtonAbrirGaveta() async {
      await sunmiPrinterPlugin.openDrawer();
    }


    // Função para determinar o número de colunas baseado no tamanho da tela
  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 600) {
      return 4; // Tablet landscape
    } else if (width > 400) {
      return 3; // Tablet portrait / Phone landscape
    } else {
      return 2; // Phone portrait
    }
  }

  // Widget para construir cada item do grid
  Widget _buildGridItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }


    // Lista de itens do grid
    

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> gridItems = [
      {
        'title': 'Imprimir Teste',
        'icon': Icons.text_snippet,
        'onPressed': this.onClickButtonImprimirTeste,
      },
      {
        'title': 'Imprimir QrCode',
        'icon': Icons.qr_code,
        'onPressed': this.onClickButtonImprimirQrCode,
      },
      {
        'title': 'Código de Barras',
        'icon': MdiIcons.barcode,
        'onPressed': this.onClickButtonImprimirCodigoDeBarras,
      },
      {
        'title': 'Saltar linha',
        'icon': Icons.arrow_downward,
        'onPressed': this.onClickButtonPularLinha,
      },
      {
        'title': 'Imprimir Imagem',
        'icon': Icons.image,
        'onPressed': this.onClickButtonImprimirImagem,
      },
      {
        'title': 'Cortar papel',
        'icon': Icons.cut,
        'onPressed': this.onClickButtonCortarPapel,
      },
      {
        'title': 'Abrir Gaveta',
        'icon': Icons.money,
        'onPressed': this.onClickButtonAbrirGaveta,
      },
    ];

    

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header com título
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              
              // Grid de botões
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(context),
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: gridItems.length,
                    itemBuilder: (context, index) {
                      final item = gridItems[index];
                      return _buildGridItem(
                        context,
                        item['title'],
                        item['icon'],
                        item['onPressed'],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onClickButtonEstadoImpressora,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.info_outline),
        label: const Text('Status'),
        elevation: 8,
      ),
    );
  }

  
}
