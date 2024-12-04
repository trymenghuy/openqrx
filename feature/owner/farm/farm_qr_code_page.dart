import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/farm/farm.dart';
import 'package:openqrx/helper/img_helper.dart';
import 'package:openqrx/helper/toast_helper.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';

class FarmQrCodePage extends StatelessWidget {
  final Farm farm;

  FarmQrCodePage({
    super.key,
    required this.farm,
  });

  final GlobalKey _qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RepaintBoundary(
                key: _qrKey,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30, bottom: 25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImgHelper.avatar(farm.imageUrl, radius: x40),
                      space10,
                      Text(
                        farm.title,
                        style: xStyle.headlineSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 25),
                        child: PrettyQrView(
                          qrImage: QrImage(QrCode.fromData(
                            data: farm.url,
                            errorCorrectLevel: QrErrorCorrectLevel.H,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _shareQrCode,
                icon: const Icon(
                  Icons.share,
                  size: x20,
                ),
                label: const Text('Share QR Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareQrCode() async {
    try {
      RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 6.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      await Share.shareXFiles(
        [XFile.fromData(pngBytes, name: 'qr_code.png', mimeType: 'image/png')],
        text: '${farm.title}\n${farm.url}',
      );
    } catch (e) {
      xPrint('Error sharing QR code: $e');
      Toast.pop('Failed to share QR code', error: true);
    }
  }
}
