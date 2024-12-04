import 'package:intl/intl.dart';
import 'package:openqrx/app/service/date_service.dart';
import 'package:openqrx/domain/model/product/product.dart';

extension NonNullInteger on int? {
  int get orZero => this ?? 0;
  bool get orNotZero => orZero > 0;
  String get toTon => (orZero / 1000).toDollar;
  int get orOne => (this ?? 1);
}

extension NullBool on bool? {
  bool get orFalse => this ?? false;
  bool get orTrue => this ?? true;
  bool get isTrue => this == true;
}

extension NoneNullNum on num? {
  num get orZero => this ?? 0;
  num get orOne => (this ?? 1);
  String get orEmpty => orZero > 0 ? orZero.toString() : '';
}

extension NoneNullDouble on double? {
  double get orZero => this ?? 0;
  double get orOne => (this ?? 1);
}

extension ListProduct on List<Product> {
  double get total => fold(0, (a, b) => a + (b.qty * b.price));
}

extension Integer on num {
  String get toMoney => toStringAsFixed(2);
  String get toRiel {
    final numberFormat = NumberFormat.currency(
      // locale: 'km_KH', // Khmer locale
      locale: 'en', //locale
      symbol: '៛', // Khmer Riel symbol
      decimalDigits: 0, // Number of decimal places (0 for whole numbers)
      customPattern: '###,###', // Custom pattern for thousands separator
    );
    return numberFormat.format(this);
  }

  String get toDollar => toStringAsFixed(2);
}

extension StringNull on String? {
  String or({String text = 'xxxxxxxxxxx'}) {
    if (this == null || this!.isEmpty) return text;
    return this!;
  }

  String get orEmpty => this ?? '';
  bool get isPath => this?.endsWith('Path') == true;
  String get toAverage => '$orEmpty kg/ក្បាល';
  bool get orIsEmpty => orEmpty.isEmpty;
  bool get orIsNotEmpty => orEmpty.isNotEmpty;
}

extension DateNull on DateTime? {
  String get formatOrEmpty => DateService.instance.nameYmd(this);
  String get formatFullOrEmpty => DateService.instance.fullText(this);
}

extension MapId on Map<String, dynamic> {
  Map<String, dynamic> setId(String id) {
    // putIfAbsent('id', () => id);
    update('id', (_) => id, ifAbsent: () => id);
    return this;
  }

  Map<String, dynamic> get nullClean {
    removeWhere((key, value) => value == null);
    return this;
  }

  // Map<String, dynamic> get addUser {
  //   final user = AuthProvider.instance.user;
  //   update('createdBy', (_) => user?.uid, ifAbsent: () => user?.uid);
  //   // putIfAbsent('createdBy', () => user?.uid);
  //   return this;
  // }
}

extension MapNull<T> on Map<String, T>? {
  Map<String, T> get orEmpty {
    return this ?? {};
  }

  bool get orIsNotEmpty {
    return orEmpty.isNotEmpty;
  }

  bool get orIsEmpty {
    return orEmpty.isEmpty;
  }

  int get hash {
    int result = 17; // Choose an arbitrary starting value
    orEmpty.forEach((key, value) {
      result = 37 * result + key.hashCode; // Combine hash code of the key
      result = 37 * result + value.hashCode; // Combine hash code of the value
    });
    return result;
  }
}

extension ListNull<T> on List<T>? {
  List<T> get orEmpty {
    return this ?? [];
  }

  bool get orIsEmpty {
    return this.orEmpty.isEmpty;
  }

  bool get orIsNotEmpty {
    return this.orEmpty.isNotEmpty;
  }

  // T? getFirstWhere(bool Function(T) condition) {
  //   final i = this.orEmpty.indexWhere(condition);
  //   return i >= 0 ? this.orEmpty[i] : null;
  // }
}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable Function(E e) key,
          {bool desc = true}) =>
      toList()
        ..sort((a, b) =>
            desc ? key(b).compareTo(key(a)) : key(a).compareTo(key(b)));
  E? getFirstWhere(bool Function(E) condition) {
    for (final element in this) {
      if (condition(element)) {
        return element;
      }
    }
    return null;
  }
}

extension MyNullIterable<E> on Iterable<E>? {
  Iterable<E> get orEmpty {
    return this ?? [];
  }
}

extension MyMapSorting<K, V> on Map<K, V> {
  Map<K, V> sortedByKey(Comparable Function(K key) key, {bool desc = false}) {
    var sortedEntries = entries.toList()
      ..sort((a, b) => desc
          ? key(b.key).compareTo(key(a.key))
          : key(a.key).compareTo(key(b.key)));

    return Map.fromEntries(sortedEntries);
  }

  Map<K, V> sortedByValue(Comparable Function(V value) value,
      {bool desc = false}) {
    var sortedEntries = entries.toList()
      ..sort((a, b) => desc
          ? value(b.value).compareTo(value(a.value))
          : value(a.value).compareTo(value(b.value)));

    return Map.fromEntries(sortedEntries);
  }

  Map<K, V> filterMapByKeys(Iterable<K> keysToKeep) {
    return Map.fromEntries(
        entries.where((entry) => keysToKeep.contains(entry.key)));
  }
}

extension ListPWWidgetExtension<T> on Iterable<T> {
  List<T> addBetween(T element, {T? add}) {
    if (length < 2) {
      return toList();
    }

    List<T> result = [];
    for (int i = 0; i < length - 1; i++) {
      result.add(elementAt(i));
      result.add(element);
    }
    result.add(last);
    if (add != null) {
      result.add(element);
      result.add(add);
    }
    return result;
  }

  Set<T> uniqueKeys() {
    Set<T> keys = <T>{};
    for (T item in this) {
      keys.add(item);
    }
    return keys;
  }
}
