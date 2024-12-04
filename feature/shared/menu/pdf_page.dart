import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart' hide PdfDocument;
import 'package:pdf/pdf.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/helper/service/print_service.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class PdfPage extends StatelessWidget {
  final List<Product> products;
  const PdfPage({super.key, required this.products});
  Future<void> shareImageBytes(Uint8List imageBytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageBytes);
    Share.shareXFiles([XFile(file.path)], text: getDateString);
  }

  String get getDateString =>
      DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                final pngBytes =
                    await PrintService.instance.getPdfByte(products);
                if (pngBytes != null) {
                  shareImageBytes(pngBytes);
                }
              },
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        body: PdfPreview(
          initialPageFormat: PdfPageFormat.roll57,
          build: (format) =>
              PrintService.instance.generatePdf(products, padding: 10),
          useActions: false,
          padding: const EdgeInsets.all(0),
          previewPageMargin: const EdgeInsets.all(15),
          pdfPreviewPageDecoration: BoxDecoration(
            boxShadow: kElevationToShadow[2],
            color: xWhite,
            borderRadius: radiusSmall,
          ),
        ));
  }
}
