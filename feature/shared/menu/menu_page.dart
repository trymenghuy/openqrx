import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/e_category.dart';
import 'package:openqrx/feature/shared/menu/provider/menu_page_provider.dart';
import 'package:openqrx/feature/shared/menu/widgets/menu_bottom.dart';
import 'package:openqrx/feature/shared/widgets/title.dart';
import 'package:openqrx/helper/img_helper.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Widget icon(bool plus, {required VoidCallback? onTap}) {
    return MaterialButton(
      onPressed: onTap,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 44,
      padding: EdgeInsets.zero,
      elevation: 0,
      color: xColor.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
              right: plus ? const Radius.circular(x20) : Radius.zero,
              left: plus ? Radius.zero : const Radius.circular(x20))),
      height: 40,
      child: Icon(plus ? Icons.add : Icons.remove, size: 20
          // color: xColor.onSecondaryContainer,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      provider: MenuPageProvider(),
      onReady: (p) => p.get(),
      child: Consumer<MenuPageProvider>(builder: (_, provider, __) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
                ],
              ),
              body: provider.widget.build(builder: (data) {
                return ListView(
                  children: [
                    ExpansionTile(
                      title: Row(
                        children: [
                          TitleMd(
                            'Filter ',
                            color: xColor.tertiary,
                          ),
                          if (provider.filters.isNotEmpty) ...[
                            CircleAvatar(
                              radius: x12,
                              child: TitleSm(
                                provider.filters.length.toString(),
                              ),
                            ),
                            InkWell(
                              onTap: provider.onFilterClear,
                              child: Padding(
                                padding: const EdgeInsets.all(x5),
                                child: Text('Clear',
                                    style: xStyle.labelMedium
                                        ?.copyWith(color: xColor.error)),
                              ),
                            ),
                          ]
                        ],
                      ),
                      childrenPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      backgroundColor: xColor.surfaceContainerHigh,
                      collapsedBackgroundColor: xColor.surfaceContainerHigh,
                      expandedAlignment: Alignment.centerLeft,
                      shape: RoundedRectangleBorder(borderRadius: radiusSmall),
                      children: [
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: ECategory.values.map((e) {
                            final isSelected = provider.filters.contains(e);
                            return ChoiceChip.elevated(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                label: Text(
                                  e.title,
                                  style: xStyle.labelLarge,
                                ),
                                selected: isSelected,
                                onSelected: (value) {
                                  provider.onFilterChange(e, isSelected);
                                });
                          }).toList(),
                        ),
                      ],
                    ),
                    ...data
                        .where((e) =>
                            provider.filters.isEmpty ||
                            provider.filters
                                .any((f) => e.category.orEmpty.contains(f)))
                        .map((e) {
                      final count = provider.getQuantity(e.id);
                      final isNotEmpty = count > 0;
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 15, right: 10),
                        leading: CircleAvatar(
                          radius: x30,
                          backgroundColor: xColor.primaryContainer,
                          child: ImgHelper.avatar(e.imageUrl, radius: x30 - 2),
                        ),
                        title: TitleMd(
                          e.title,
                        ),
                        subtitle: TitleSm(
                          e.price.toRiel,
                          color: xColor.error,
                        ),
                        trailing: Wrap(
                          children: [
                            icon(false, onTap: () {
                              if (isNotEmpty) {
                                provider.onChanged(e.id, -1);
                              }
                            }),
                            Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color: isNotEmpty
                                    ? xColor.secondaryContainer
                                    : xColor.surfaceContainerHigh,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                count.toString(),
                                style: xStyle.labelLarge,
                              ),
                            ),
                            icon(true,
                                onTap: () => provider.onChanged(e.id, 1)),
                          ],
                        ),
                      );
                    })
                  ],
                );
              }),
            ),
            AnimatedBottomNavBar(
              isVisible: provider.order.values.fold(0, (a, b) => a + b) > 0,
              onClear: provider.onOrderClear,
              onOrder: provider.onSend,
            ),
          ],
        );
      }),
    );
  }
}
