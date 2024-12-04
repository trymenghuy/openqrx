// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/domain/model/farm/farm.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/helper/service/print_service.dart';
import 'package:openqrx/helper/uni_limon.dart';

class PdfBetDisplay {
  static Widget numRow(Product e) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: textBtb(e.title),
          ),
          Container(
            alignment: Alignment.center,
            width: 20,
            child: textBtb(e.qty.toString()),
          ),
          Container(
            width: 40,
            alignment: Alignment.centerRight,
            child: textBtb(
              (e.qty * e.price).toRiel,
              // color: xColor.primary,
            ),
          )
        ],
      ),
    );
  }

  static Widget _buildCell(
    String text, {
    TextAlign textAlign = TextAlign.center,
    bool isHeader = false,
  }) {
    final cell = textBtb(
      text,
      fontSize: 10,
      textAlign: textAlign,
    );
    if (isHeader) {
      return Padding(padding: const EdgeInsets.only(bottom: 3), child: cell);
    }
    return cell;
  }

  static Widget table(List<Product> items) {
    return Table(
      border: TableBorder.all(style: BorderStyle.none),
      columnWidths: const {
        0: FlexColumnWidth(), // Item Name (largest ratio)
        1: FixedColumnWidth(30), // Unit
        2: FixedColumnWidth(24), // Price/Unit
        3: FixedColumnWidth(30), // Total
      },
      children: [
        TableRow(
          children: [
            _buildCell('Item', textAlign: TextAlign.left, isHeader: true),
            _buildCell('Price', isHeader: true),
            _buildCell('Qty', isHeader: true),
            _buildCell('Total', textAlign: TextAlign.end, isHeader: true),
          ],
        ),
        ...items.map(_buildTableRow),
      ],
    );
  }

  static TableRow _buildTableRow(Product item) {
    return TableRow(
      children: [
        limonText(UniLimon.limon(item.title), fontSize: 18),
        _buildCell(item.price.toRiel),
        _buildCell(item.qty.toString()),
        _buildCell((item.price * item.qty).toRiel, textAlign: TextAlign.right),
      ],
    );
  }

  static Widget bottom() {
    final dateTime = DateTime.now();
    final format = DateFormat('yyyy-MM-dd').add_jm();
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      limonText('sUmGrKuN', fontSize: 18),
      text(format.format(dateTime), fontSize: 9),
    ]);
  }

  static Widget head(Farm farm) {
    return Column(children: [
      // limonText('eqñatpSgsMNag', fontSize: 36),
      text(farm.title, fontSize: 16),
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: text('Street 117, Preah Sihanouk', fontSize: 9)),
      text('098 322 666 / 012 222 222', fontSize: 9),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(style: BorderStyle.dotted, width: 0.5)),
        ),
      ),
    ], crossAxisAlignment: CrossAxisAlignment.center);
  }

  static text(String text, {double fontSize = 16, PdfColor? color}) {
    return Text(text, style: TextStyle(fontSize: fontSize, color: color));
  }

  static textBtb(
    String text, {
    double fontSize = 10,
    PdfColor? color,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(text,
            tightBounds: true,
            // textScaleFactor: 2,
            textAlign: textAlign,
            style: TextStyle(
                fontSize: fontSize,
                color: color,
                // height: 20,
                fontWeight: FontWeight.bold,
                font: Font.ttf(
                    PrintService.instance.fontBTBData!.buffer.asByteData()))));
  }

  static limonText(String text, {double fontSize = 20, PdfColor? color}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        font:
            Font.ttf(PrintService.instance.fontLimonData!.buffer.asByteData()),
      ),
      tightBounds: true,
    );
  }

  static Widget bottomTotal(num total) {
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, style: BorderStyle.dotted)),
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(top: 2),
                  alignment: Alignment.center,
                  child: textBtb('សរុប', fontSize: 10))),
          Spacer(),
          textBtb(total.toRiel, fontSize: 10),
        ],
      ),
    );
  }
}
