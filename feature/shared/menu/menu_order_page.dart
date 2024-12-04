import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/feature/shared/menu/pdf_page.dart';
import 'package:openqrx/feature/shared/widgets/buttons/left_button.dart';
import 'package:openqrx/feature/shared/widgets/buttons/right_button.dart';
import 'package:openqrx/feature/shared/widgets/title.dart';

class MenuOrderPage extends StatelessWidget {
  final List<Product> products;
  final ScrollController controller;
  final VoidCallback onSend;
  const MenuOrderPage(
      {super.key,
      required this.products,
      required this.controller,
      required this.onSend});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(x20)),
      child: Scaffold(
        bottomNavigationBar: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border(top: borderSide),
          ),
          child: Row(
            children: [
              LeftButton(
                icon: Icons.picture_as_pdf,
                onTap: () {
                  XNavigator.push(PdfPage(products: products));
                },
                text: 'Print',
              ),
              space10,
              Expanded(
                child: RightButton(
                  icon: Icons.send_rounded,
                  onTap: onSend,
                  text: 'Submit',
                ),
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          controller: controller,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: xColor.surfaceContainerHighest,
                      borderRadius: radiusMedium),
                  width: 40,
                  height: 4,
                ),
              ),
            ),
            const SliverAppBar(
              title: Text('Order'),
              automaticallyImplyLeading: false,
              // actions: [
              //   IconButton(
              //       onPressed: () {
              //         XNavigator.push(PdfPage(products: products));
              //       },
              //       icon: const Icon(Icons.picture_as_pdf)),
              // ],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              sliver: SliverList.builder(
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final e = products[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 5),
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
                    );
                  }),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                padding: const EdgeInsets.symmetric(vertical: 15),
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
            )
          ],
        ),
      ),
    );
  }
}
