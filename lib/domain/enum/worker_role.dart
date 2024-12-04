import 'package:openqrx/domain/enum/item_base.dart';

enum WorkerRole implements OptBase {
  admin('admin'),
  editor('editor'),
  creator('creator'),
  viewer('viewer'),
  none('none');

  const WorkerRole(this.value, [this.en, this.km]);
  @override
  final String value;
  @override
  final String? en;
  @override
  final String? km;
  @override
  String get title => value;
  factory WorkerRole.fromString(String? ln) => WorkerRole.values
      .firstWhere((e) => e.value == ln, orElse: () => WorkerRole.none);
}
