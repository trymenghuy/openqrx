import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/feature/shared/generic/provider/generic_page_provider.dart';
import 'package:openqrx/feature/shared/widgets/load_more_bottom.dart';
import 'package:openqrx/feature/shared/widgets/load_more_helper.dart';
import 'package:openqrx/feature/shared/widgets/pop_icon_item.dart';
import 'package:provider/provider.dart';

class GenericPage<T extends Identifiable> extends StatelessWidget {
  final String collection;
  final String? title;
  final bool isTotal;
  final Widget? divider;
  final String? fieldEqual;
  final String? fieldMap;
  final bool farmLevel;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final Widget Function(T, PopupMenuItem Function(T data, {String? title}),
      PopupMenuItem Function(T data, {String? title})) itemBuilder;
  final FormBuilder? form;
  final Iterable<T> Function(Iterable<T>)? sortedBy;

  const GenericPage(
      {super.key,
      required this.collection,
      this.isTotal = false,
      this.farmLevel = true,
      this.divider,
      this.title,
      required this.itemBuilder,
      required this.fromJson,
      required this.toJson,
      this.form,
      this.sortedBy,
      this.fieldEqual,
      this.fieldMap});
  PopupMenuItem editOpt(
    BuildContext context,
    Function(T) add,
    T data,
    String? title,
  ) {
    return PopIconItem(
      icon: Icons.edit,
      text: 'Edit ${title ?? getTitle(data)}',
      onTap: () async {
        final map = await NavigatorHelper(context).push(form!(toJson(data)));
        if (map != null) {
          add(fromJson(map));
        }
      },
    );
  }

  String getTitle(T data) {
    final map = toJson(data);
    return map['name'] ?? map['title'] ?? '';
  }

  PopupMenuItem deleteOpt(
    Function(T) remove,
    T data,
    String? title,
  ) {
    return PopIconItem(
      icon: Icons.delete,
      text: 'Delete ${title ?? getTitle(data)}',
      onTap: () {
        button.confirm(
            title: 'Delete ${title ?? getTitle(data)}',
            subTitle: 'Are you sure to delete this? ',
            onNext: () {
              remove(data);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      provider: GenericPageProvider<T>(collection, isTotal, fromJson, toJson,
          sortedBy, form, farmLevel, fieldEqual, fieldMap),
      onReady: (p) {
        p.get();
      },
      child: Consumer<GenericPageProvider<T>>(builder: (_, provider, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title ?? collection),
          ),
          floatingActionButton: form != null
              ? FloatingActionButton(
                  onPressed: () async {
                    final Map<String, dynamic>? result =
                        await NavigatorHelper(context).push(form!(null));

                    if (result != null) {
                      provider.add(fromJson(result));
                    }
                  },
                  child: const Icon(Icons.add),
                )
              : null,
          body: provider.widget.build(builder: (data) {
            return LoadMore(
              onMore: () {
                provider.get(more: true);
              },
              child: ListView(
                children: () {
                  var list = data
                      .map<Widget>((e) => itemBuilder(
                            e,
                            (data, {title}) =>
                                editOpt(context, provider.add, data, title),
                            (data, {title}) =>
                                deleteOpt(provider.remove, data, title),
                          ))
                      .toList();
                  if (divider != null) {
                    list = list.addBetween(divider!);
                  }
                  list.add(LoadMoreBottom(load: provider.offset.hasMore));
                  return list;
                }(),
              ),
            );
          }),
        );
      }),
    );
  }
}
