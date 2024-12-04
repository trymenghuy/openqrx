// import 'package:flutter/material.dart';
// import 'package:openqrx/app/util/app_provider.dart';
// import 'package:openqrx/feature/shared/test/provider/test_page_provider.dart';
// import 'package:provider/provider.dart';

// class TestPage extends StatelessWidget {
// const TestPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppProvider(
//       provider: TestPageProvider(),
//       onReady: (p) {
//       },
//       child: Consumer<TestPageProvider>(builder: (_, provider, __) {
//         return provider.widget.build(
//             builder: (data) {
//               return Scaffold(
//               );
//             });
//       }),
//     );
//   }
// }
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class WidgetToImageConverter extends StatefulWidget {
  const WidgetToImageConverter({super.key});

  @override
  _WidgetToImageConverterState createState() => _WidgetToImageConverterState();
}

class _WidgetToImageConverterState extends State<WidgetToImageConverter> {
  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List> captureWidget() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 8.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<String> convertImageToPdf(Uint8List imageData) async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(imageData);

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(0),
        build: (pw.Context context) {
          return pw.Image(image);
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/temp_image.pdf');
    await file.writeAsBytes(await pdf.save());

    return file.path;
  }

  Future<void> sharePdf(String filePath) async {
    Share.shareXFiles([XFile(filePath)], text: 'Here is your PDF');
  }
// void convertAndSavePdf(Uint8List imageData) async {
//   final pdfBytes = await convertImageToPdf(imageData);

//   // To save the PDF to a file:
//   // final output = await getTemporaryDirectory();
//   // final file = File("${output.path}/example.pdf");
//   // await file.writeAsBytes(pdfBytes);

//   // To display the PDF:
//   await Printing.layoutPdf(onLayout: (_) => pdfBytes);
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              Uint8List imageBytes = await captureWidget();
              // Now you can use imageBytes to save or display the image
              print('Image captured! Byte length: ${imageBytes.length}');
              final tempDir = await getTemporaryDirectory();
              final file = await File('${tempDir.path}/image.png').create();
              file.writeAsBytesSync(imageBytes);
              Share.shareXFiles([XFile(file.path)], text: 'test');
            },
            icon: const Icon(Icons.check),
          ),
          IconButton(
            onPressed: () async {
              final data = await captureWidget();
              final filePath = await convertImageToPdf(
                data,
              );
              sharePdf(filePath);
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: AspectRatio(
                aspectRatio: 1,
                // child: Container(
                //   color: Colors.blue,
                //   child: const Center(
                //     child: Text('Hello, Widget to Image!',
                //         style: TextStyle(color: Colors.white)),
                //   ),
                // ),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15),
                  child: PrettyQrView(
                    // data: widget.data,
                    // size: widget.size,
                    // elementColor: Colors.black,
                    // roundEdges: true,
                    // decoration: PrettyQrDecoration( ),
                    qrImage: QrImage(QrCode.fromData(
                      data: 'https://tmh-pos.web.app/shop/sakada',
                      errorCorrectLevel: QrErrorCorrectLevel.H,
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
