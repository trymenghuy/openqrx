import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/factory/pop/base_pop.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/input_rule.dart';
import 'package:openqrx/feature/shared/generic/abstract/generic_form_abstract.dart';
import 'package:openqrx/feature/shared/generic/provider/generic_form_provider.dart';
import 'package:openqrx/feature/shared/generic/widgets/product_operator.dart';
import 'package:openqrx/feature/shared/widgets/form/app_input.dart';
import 'package:openqrx/feature/shared/widgets/form/input_style.dart';
import 'package:openqrx/feature/shared/widgets/pop/offset_pop.dart';
import 'package:openqrx/feature/shared/widgets/svg_icon.dart';
import 'package:openqrx/helper/form/convert_helper.dart';
import 'package:openqrx/helper/form/format_helper.dart';
import 'package:openqrx/helper/form/product_helper.dart';
import 'package:openqrx/helper/img_helper.dart';
import 'package:provider/provider.dart';

class GenericForm extends StatelessWidget {
  final InputRule input;
  final Map<String, dynamic>? map;
  final Map<String, dynamic>? translate;
  final AppBar? appBar;
  final Function(Map<String, dynamic> map)? onSubmit;
  final bool farmLevel;
  final List<Widget> Function(GenericFormAbstract provider)? children;
  const GenericForm(
      {super.key,
      required this.input,
      this.translate,
      this.appBar,
      this.map,
      this.onSubmit,
      this.children,
      this.farmLevel = true});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      provider: GenericFormProvider(farmLevel, onSubmit, translate),
      onReady: (p) {
        p.get(input, map);
      },
      child: Consumer<GenericFormProvider>(builder: (_, provider, __) {
        return provider.widget.build(builder: (data) {
          return Scaffold(
            appBar: appBar,
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: x20),
              children: [
                if (data.description != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(data.description!, style: xGreyStyleLarge),
                  ),
                ...data.map.entries
                    .where((e) => !data.getSkips.contains(e.key))
                    .map((e) {
                  final isFile = data.files?.contains(e.key) == true;
                  if (isFile) {
                    final path = data.map['${e.key}Path'];
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(x10),
                        child: ImgHelper.avatar(
                          e.value,
                          onTap: () async {
                            final file = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 30,
                            );
                            if (file?.path != null) {
                              provider.onChanged(e.key, file?.path);
                            }
                          },
                          radius: 50,
                          backgroundImage:
                              path != null ? FileImage(File(path)) : null,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 30,
                                color: xColor.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  final isOpt = data.isOpt(e.key);
                  TextInputType inputType = TextInputType.text;
                  List<TextInputFormatter>? formatter;
                  if (data.decimals?.contains(e.key) == true) {
                    inputType =
                        const TextInputType.numberWithOptions(decimal: true);
                    formatter = FormatHelper.doubleOnly;
                  } else if (data.digits?.contains(e.key) == true) {
                    inputType = TextInputType.number;
                    formatter = FormatHelper.digitOnly;
                  }

                  dynamic defaultValue = e.value;

                  final isMultiOptions = data.isMultiOptions(e.key);
                  final isOption = data.isOption(e.key);
                  final isNestedInputOptions = data.isNestOption(e.key);
                  if (isOpt && defaultValue != null) {
                    try {
                      if (defaultValue is List) {
                        final optBaseList = data.getOptMap[e.key]
                            ?.where((f) => defaultValue.contains(f.value))
                            .map((e) => e.title)
                            .toList();
                        defaultValue = optBaseList;
                      } else if (isOption) {
                        final optBase = data.getOptMap[e.key]
                            ?.firstWhere((f) => f.value == defaultValue);
                        defaultValue = optBase?.title;
                      }
                    } catch (error, stackTrace) {
                      xPrint(error);
                      xPrint(stackTrace, error: true);
                    }
                  }
                  final value = ConvertHelper.otherToString(defaultValue);
                  final isOptional = data.optionals?.contains(e.key) == true;
                  final isMultiline = data.isMultiLines(e.key);
                  final icon = data.icons?[e.key];
                  Widget? suffixIcon;
                  if (isOpt) {
                    suffixIcon = value.isEmpty
                        ? const IconButton(
                            onPressed: null, icon: InputDropDown())
                        : IconButton(
                            onPressed: () {
                              provider.onChanged(e.key, null);
                            },
                            icon: Icon(
                              Icons.clear,
                              color: xColor.error,
                              size: x20,
                            ));
                  }
                  final title = provider.tran(e.key);
                  final input = Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: AppInput(
                      value: value,
                      enabled: !isOpt,
                      keyboardType: inputType,
                      readOnly: isOpt,
                      onChanged: (value) {
                        provider.onChanged(e.key, value);
                      },
                      inputFormatters: formatter,
                      minLines: isMultiline ? 2 : null,
                      decoration: InputStyle.border(
                          errorText: provider.error[e.key],
                          floatingLabelBehavior:
                              isMultiline ? FloatingLabelBehavior.always : null,
                          labelText: title + (isOptional ? ' (Optional)' : ''),
                          suffixIcon: isOpt ? const SizedBox() : null,
                          fillColor: xColor.secondaryContainer.withOpacity(0.5),
                          prefixIcon: icon != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SvgIcon(icon),
                                )
                              : null),
                    ),
                  );

                  if (isOpt) {
                    final isSupply = ['usage', 'supply'].contains(data.id);
                    return Column(
                      children: [
                        OffsetPop(
                          clear: suffixIcon,
                          onTab: (context, position) async {
                            dynamic result;
                            PopupType popUpType = PopupType.menu;
                            if (data.isOptionAsBottomSheet(e.key)) {
                              popUpType = PopupType.bottomSheet;
                            } else if (data.isOptionAsDialog(e.key)) {
                              popUpType = PopupType.dialog;
                            }
                            if (data.isDate(e.key)) {
                              result = await Pop.pickDate(e.value);
                            } else {
                              result = await Pop.pick(
                                  context: context,
                                  title: title,
                                  position: position,
                                  options: data.getOptMap[e.key]!,
                                  selected: e.value,
                                  isMultiple: isMultiOptions,
                                  type: popUpType);
                            }
                            if (result != null) {
                              await Future.delayed(
                                  const Duration(milliseconds: 300));
                              provider.onChanged(e.key, result);
                            }
                            // dynamic result;
                            // if (isMultiOptions) {
                            //   result = await PopItems().showMulti(
                            //       title: title,
                            //       context: context,
                            //       position: position,
                            //       options: data.getOptMap[e.key]!,
                            //       selectedOptions: e.value);
                            // } else if (isOption) {
                            //   result = await PopItems().show(
                            //       context: context,
                            //       title: title,
                            //       position: position,
                            //       options: data.getOptMap[e.key]!,
                            //       selected: e.value);
                            // } else if (data.dates?.contains(e.key) == true) {
                            //   result = await DateService.instance.pickDate(
                            //       now: ConvertHelper.otherToDate(e.value));
                            // }
                            // if (result != null) {
                            //   provider.onChanged(e.key, result);
                            // }
                          },
                          child: input,
                        ),
                        if (isNestedInputOptions &&
                            provider.nestedInput[e.key].orIsNotEmpty) ...[
                          ...provider.nestedInput[e.key]!.entries.map(
                            (item) {
                              return data.nestedOptions![e.key]!(
                                  item, provider, e);
                            },
                          ),
                          if (ProductHelper.total(
                                  provider.nestedInput[e.key]!.values) >
                              0) ...[
                            const Divider(height: 15, indent: 0, endIndent: 0),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ProductTotal(
                                  provider.nestedInput[e.key]!.values,
                                  isSupply),
                            )
                          ],
                          space10,
                        ],
                      ],
                    );
                  }
                  return input;
                }),
                if (children != null) ...children!(provider),
                submitButton(context, () async {
                  FocusScope.of(context).unfocus();
                  final map = await provider.submit();
                  if (map != null && context.mounted && onSubmit == null) {
                    Navigator.of(context).pop(map);
                  }
                })
              ],
            ),
          );
        });
      }),
    );
  }

  Container submitButton(BuildContext context, VoidCallback onTap) {
    return Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FilledButton(
            onPressed: onTap, child: Text(map.orIsEmpty ? 'Send' : 'Edit')));
  }
}
