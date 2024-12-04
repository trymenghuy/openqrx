import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/shared/report/provider/report_page_provider.dart';
import 'package:openqrx/feature/shared/widgets/title.dart';
import 'package:openqrx/helper/img_helper.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      provider: ReportPageProvider(),
      onReady: (p) => p.get(),
      child: Consumer<ReportPageProvider>(builder: (_, provider, __) {
        return Scaffold(
          appBar: AppBar(
            title: TitleLg('របាយការណ៍'),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kTextTabBarHeight),
                child: Row(
                  children: [
                    MaterialButton(
                        color: xColor.tertiary,
                        onPressed: () async {
                          DraggableScrollableController controller =
                              DraggableScrollableController();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: xColor.surface,
                            useSafeArea: true,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                controller: controller,
                                maxChildSize: 0.8,
                                initialChildSize: 0.6,
                                expand: false,
                                builder: (context, scrollController) {
                                  var list = List.from(provider.selectedDates);
                                  return ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(x20)),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: x20),
                                      child: SfDateRangePicker(
                                        backgroundColor: xColor.surface,
                                        headerHeight: kToolbarHeight + x10,
                                        rangeSelectionColor:
                                            xColor.primaryContainer,
                                        headerStyle: DateRangePickerHeaderStyle(
                                            backgroundColor: xColor.surface),
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                        initialSelectedRange: PickerDateRange(
                                          list.isNotEmpty ? list.first : null,
                                          list.length > 1 ? list.last : null,
                                        ),
                                        showActionButtons: true,
                                        showNavigationArrow: true,
                                        cancelText: 'Cancel',
                                        confirmText: 'Apply',
                                        onSubmit: (v) {
                                          if (v is PickerDateRange) {
                                            provider.onDateChanged(v);
                                          }
                                          Navigator.pop(context);
                                        },
                                        onCancel: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        textColor: xColor.onTertiary,
                        child: Row(
                          children: [
                            Text(
                              provider.range,
                            ),
                            space5,
                            const Icon(
                              Icons.calendar_month,
                              size: 16,
                            )
                          ],
                        )),
                  ],
                )),
          ),
          body: provider.widget.build(builder: (data) {
            return ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    'សរុប ${data.fold(0, (a, b) => a + b.total)}',
                    style:
                        xStyle.headlineMedium?.copyWith(color: xColor.primary),
                  ),
                ),
                ...data.map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleMd(e.dayId),
                              TitleMd(
                                'សរុប ${e.total}',
                                color: xColor.primary,
                              ),
                            ],
                          ),
                        ),
                        ...e.product.entries.map((e) {
                          final product = provider.product[e.key];
                          if (product == null) {
                            return const SizedBox();
                          }
                          return ListTile(
                            dense: true,
                            leading: ImgHelper.avatar(product.imageUrl),
                            title: TitleMd(product.title),
                            subtitle: SubTitleMd(product.price.toRiel),
                            trailing: TitleMd(e.value.toRiel),
                          );
                        })
                      ],
                    ))
              ],
            );
          }),
        );
      }),
    );
  }
}
