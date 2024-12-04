import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart' hide PdfDocument;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_render/pdf_render.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/provider/farm_provider.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/feature/shared/widgets/pdf_bet_display.dart';

class PrintService {
  static PrintService? _instance;
  PrintService._();
  static PrintService get instance {
    _instance ??= PrintService._();
    return _instance!;
  }

  Uint8List? fontLimonData;
  Uint8List? fontBTBData;
  Future<Uint8List> getFileAsUint8List(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  Future<Uint8List?> getPdfByte(List<Product> products,
      {double scale = 8}) async {
    final data = await generatePdf(products, padding: scale > 6 ? 10 : 0);
    final document = await PdfDocument.openData(data);
    final page = await document.getPage(1);
    final w = (scale * page.width).toInt();
    final h = (scale * page.height).toInt();
    final pageImage = await page.render(
      width: w,
      height: h,
      fullWidth: w.toDouble(),
      fullHeight: h.toDouble(),
    );
    xPrint('${pageImage.width} - ${pageImage.height}', error: true);
    await pageImage.createImageIfNotAvailable();
    final pngBytes = await pageImage.imageIfAvailable
        ?.toByteData(format: ui.ImageByteFormat.png);
    document.dispose();
    if (pngBytes != null) {
      return pngBytes.buffer.asUint8List();
    }
    return null;
  }

  Future<Uint8List> generatePdf(List<Product> products,
      {PdfPageFormat format = PdfPageFormat.roll57, double padding = 0}) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    fontLimonData ??= await getFileAsUint8List('assets/fonts/lmns1.ttf');
    fontBTBData ??=
        await getFileAsUint8List('assets/fonts/Suwannaphum-Regular.ttf');
    fontLimonData ??= await getFileAsUint8List('assets/fonts/lmns4.ttf');
    // final logo = await getFileAsUint8List('assets/images/apple.png');
    // final Uint8List fontData =
    //     await getFileAsUint8List('assets/fonts/lmns1.ttf');
    // final font = pw.Font.ttf(fontData.buffer.asByteData());
    // const marginLeft = 0;
    // final marginLeft = SettingProvider.instance.marginPrinter.value;
    final farm = FarmProvider.instance.farm!;
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        margin: const pw.EdgeInsets.all(0),
        theme: pw.ThemeData(),
        build: (context) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(padding),
            child: pw.Column(mainAxisSize: pw.MainAxisSize.min, children: [
              PdfBetDisplay.head(farm),
              PdfBetDisplay.table(products),
              PdfBetDisplay.bottomTotal(products.total),
              PdfBetDisplay.bottom(),
            ]),
          );
        },
      ),
    );
    return pdf.save();
  }
}
