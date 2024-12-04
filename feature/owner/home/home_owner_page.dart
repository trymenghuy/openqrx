import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/route.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/e_category.dart';
import 'package:openqrx/feature/owner/home/provider/home_page_provider.dart';
import 'package:openqrx/feature/owner/home/widgets/drawer_tile.dart';
import 'package:openqrx/feature/owner/home/widgets/home_base_drawer.dart';
import 'package:openqrx/feature/shared/menu/widgets/menu_bottom.dart';
import 'package:openqrx/feature/shared/menu/widgets/menu_cal_icon.dart';
import 'package:openqrx/feature/shared/widgets/app_state/init_app_state.dart';
import 'package:openqrx/feature/shared/widgets/title.dart';
import 'package:openqrx/helper/img_helper.dart';
import 'package:provider/provider.dart';

class HomeOwnerPage extends StatelessWidget {
  const HomeOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    getColor(context);
    return AppProvider(
      provider: HomeOwnerPageProvider(),
      onReady: (p) => p.get(),
      child: Consumer<HomeOwnerPageProvider>(builder: (_, provider, __) {
        return provider.widget.build(
            placeholder: const Scaffold(
              body: InitAppState(),
            ),
            builder: (data) {
              return Stack(
                children: [
                  Scaffold(
                    drawer: HomeBaseDrawer(
                      children: [
                        DrawerTile(
                          svg: const Icon(Icons.add_shopping_cart),
                          text: 'Order',
                          onTap: () {
                            XNavigator.pushName(AppRoutes.order);
                          },
                        ),
                        DrawerTile(
                          svg: const Icon(Icons.bar_chart),
                          text: 'Report',
                          onTap: () {
                            XNavigator.pushName(AppRoutes.report);
                          },
                        ),
                        DrawerTile(
                          svg: const Icon(Icons.card_travel),
                          text: 'Product',
                          onTap: () {
                            XNavigator.pushName(AppRoutes.product);
                          },
                        ),
                        DrawerTile(
                          svg: const Icon(Icons.rule),
                          text: 'Farm',
                          onTap: () {
                            XNavigator.pushName(AppRoutes.farm);
                          },
                        ),
                        DrawerTile(
                          svg: const Icon(Icons.travel_explore_rounded),
                          text: 'Test',
                          onTap: () {
                            XNavigator.pushName(AppRoutes.test);
                          },
                        ),
                      ],
                    ),
                    appBar: AppBar(
                      title: Text(provider.farm.title),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications),
                        )
                      ],
                    ),
                    body: ListView(
                      children: [
                        ExpansionTile(
                          title: Row(
                            children: [
                              // Badge(
                              //   isLabelVisible: provider.filters.isNotEmpty,
                              //   label: Text(provider.filters.length.toString()),
                              //   backgroundColor: xColor.tertiary,
                              //   textColor: xColor.onTertiary,
                              //   offset: const Offset(12, 0),
                              //   child: TitleMd(
                              //     'Filter ',
                              //     color: xColor.tertiary,
                              //   ),
                              // ),
                              TitleMd(
                                'Filter',
                                color: xColor.tertiary,
                              ),
                              if (provider.filters.isNotEmpty) ...[
                                IconButton(
                                  style: IconButton.styleFrom(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap),
                                  onPressed: provider.onFilterClear,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.remove_circle),
                                  color: xColor.error,
                                  iconSize: 18,
                                ),
                              ]
                            ],
                          ),
                          childrenPadding:
                              const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          backgroundColor: xColor.surfaceContainerHigh,
                          collapsedBackgroundColor: xColor.surfaceContainerHigh,
                          expandedAlignment: Alignment.centerLeft,
                          shape:
                              RoundedRectangleBorder(borderRadius: radiusSmall),
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
                              child:
                                  ImgHelper.avatar(e.imageUrl, radius: x30 - 2),
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
                                MenuCalIcon(
                                    plus: false,
                                    onTap: () {
                                      if (isNotEmpty) {
                                        provider.onChanged(e.id, -1);
                                      }
                                    }),
                                Container(
                                  width: 40,
                                  height: 40,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
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
                                MenuCalIcon(
                                    plus: true,
                                    onTap: () => provider.onChanged(e.id, 1)),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  AnimatedBottomNavBar(
                    isVisible:
                        provider.order.values.fold(0, (a, b) => a + b) > 0,
                    onClear: provider.onOrderClear,
                    onOrder: provider.onSend,
                  ),
                ],
              );
            });
      }),
    );
  }
}
