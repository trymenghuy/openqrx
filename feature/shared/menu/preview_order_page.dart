import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/feature/shared/menu/pdf_page.dart';
import 'package:openqrx/feature/shared/menu/provider/preview_order_page_provider.dart';
import 'package:openqrx/feature/shared/widgets/buttons/long_button.dart';
import 'package:openqrx/feature/shared/widgets/title.dart';
import 'package:provider/provider.dart';

class PreviewOrderPage extends StatelessWidget {
  final List<Product> products;
  final ScrollController controller;
  const PreviewOrderPage(
      {super.key, required this.products, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      provider: PreviewOrderPageProvider(products),
      onReady: (p) {},
      child: Consumer<PreviewOrderPageProvider>(builder: (_, provider, __) {
        return provider.widget.build(builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Order'),
              actions: [
                IconButton(
                    onPressed: () {
                      XNavigator.push(PdfPage(products: products));
                    },
                    icon: const Icon(Icons.picture_as_pdf)),
                IconButton(
                    onPressed: provider.onPrint, icon: const Icon(Icons.print))
              ],
            ),
            bottomNavigationBar: LongButton(
              onTap: () => provider.onSubmit(context),
            ),
            body: ListView(
              controller: controller,
              children: [
                for (final e in products)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TitleMd(e.title),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 30,
                          child: SubTitleLg(e.qty.toString()),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.centerRight,
                          child: TitleMd(
                            (e.qty * e.price).toRiel,
                          ),
                        )
                      ],
                    ),
                  ),
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(border: Border(top: borderSide)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SubTitleLg('Total :'),
                      space10,
                      TitleMd(
                        products.total.toRiel,
                        color: xColor.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      }),
    );
  }
}
